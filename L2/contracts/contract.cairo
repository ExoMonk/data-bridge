# Declare this file as a StarkNet contract.
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from openzeppelin.access.ownable.library import Ownable

from contracts.library import L2DataBridge

#
# Constructor
#

@constructor
func constructor{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(owner: felt, l1_address: felt):
    L2DataBridge.initializer(l1_address)
    Ownable.initializer(owner)
    return ()
end

#
# Getters
#
@view
func get_l1_contract{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }() -> (l1_address: felt):
    return L2DataBridge.get_l1_address()
end


#
# Write Functions
#

@external
func send_message{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(l1_caller: felt, payload_len: felt, payload: felt*):
    #@TODO Get Layer 1 State
    L2DataBridge.send_data_to_l1(l1_caller, payload_len, payload)
    return ()
end

@external
func update_l1_address{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(new_l1_address: felt):
    Ownable.assert_only_owner()
    L2DataBridge.update_l1_address(new_l1_address)
    return ()
end