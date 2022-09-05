# contracts/library.cairo
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.bool import TRUE, FALSE
from starkware.starknet.common.syscalls import get_caller_address
from starkware.starknet.common.messages import send_message_to_l1
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.alloc import alloc

#
# Storage
#

@storage_var
func l1_interact_address_() -> (l1_address: felt):
end

#
# Events
#

@event
func InterractedWithL1(l1_recipient: felt, payload_len: felt, payload: felt*):
end

namespace L2DataBridge:

    #
    # Initializer
    #

    func initializer{
            syscall_ptr: felt*, 
            pedersen_ptr: HashBuiltin*, 
            range_check_ptr
        }(l1_address: felt):
        l1_interact_address_.write(l1_address)
        return ()
    end

    #
    # Getters
    #

    ###
    # Returns the address of the Interacted contract on the L1
    ###
    func get_l1_address{
            syscall_ptr: felt*, 
            pedersen_ptr: HashBuiltin*, 
            range_check_ptr
        }() -> (l1_address: felt):
        return l1_interact_address_.read()
    end

    ###
    # Update L1 Address interact
    ###
    func update_l1_address{
            syscall_ptr: felt*, 
            pedersen_ptr: HashBuiltin*, 
            range_check_ptr
        }(l1_address: felt):
        l1_interact_address_.write(l1_address)
        return ()
    end

    ###
    # Send message to L1 Contract
    ###

    func send_data_to_l1{
            pedersen_ptr: HashBuiltin*, 
            syscall_ptr: felt*, 
            range_check_ptr
        }(l1_caller: felt, _payload_len: felt, _payload: felt*):
        alloc_locals
        let (l1_address) = get_l1_address()

        send_message_to_l1(to_address=l1_address, payload_size=_payload_len, payload=_payload)
        InterractedWithL1.emit(l1_caller, _payload_len, _payload)
        return ()
    end
end

namespace internal:
end