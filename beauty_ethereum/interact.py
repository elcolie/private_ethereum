"""
Interacting with existing contracts.
https://web3py.readthedocs.io/en/stable/examples.html#working-with-contracts
"""
from web3 import Web3, HTTPProvider

human_0 = '0x6A48A50A53462A22D2c30F5138c4970a3020b30a'
human_address_1 = "0x92e320aE601BC8235D605d38D03142C3FE28Ba92"
foggy = '0xa456c84CC005100B277D4637896456F99a59A290'
sarit = '0xB795518Ee574c2a55B513D2C1319e8e6e40F6c04'


def main():
    w3 = Web3(HTTPProvider('http://localhost:8545'))  # web3 must be called locally
    assert True is w3.isConnected()
    print('Network connected')
    address = "0x89829891FBB78bf1142dd58952f8C62CC2222D6B"
    # ContractCaller https://web3py.readthedocs.io/en/stable/contracts.html?highlight=w3.eth.contract#contractcaller
    # To get ABI
    # vyper -f abi contracts/ERC721.vy
    abi = '[{"name": "Transfer", "inputs": [{"name": "sender", "type": "address", "indexed": true}, {"name": "receiver", "type": "address", "indexed": true}, {"name": "tokenId", "type": "uint256", "indexed": true}], "anonymous": false, "type": "event"}, {"name": "Approval", "inputs": [{"name": "owner", "type": "address", "indexed": true}, {"name": "approved", "type": "address", "indexed": true}, {"name": "tokenId", "type": "uint256", "indexed": true}], "anonymous": false, "type": "event"}, {"name": "ApprovalForAll", "inputs": [{"name": "owner", "type": "address", "indexed": true}, {"name": "operator", "type": "address", "indexed": true}, {"name": "approved", "type": "bool", "indexed": false}], "anonymous": false, "type": "event"}, {"stateMutability": "nonpayable", "type": "constructor", "inputs": [], "outputs": []}, {"stateMutability": "view", "type": "function", "name": "supportsInterface", "inputs": [{"name": "_interfaceID", "type": "bytes32"}], "outputs": [{"name": "", "type": "bool"}], "gas": 2641}, {"stateMutability": "view", "type": "function", "name": "balanceOf", "inputs": [{"name": "_owner", "type": "address"}], "outputs": [{"name": "", "type": "uint256"}], "gas": 2925}, {"stateMutability": "view", "type": "function", "name": "ownerOf", "inputs": [{"name": "_tokenId", "type": "uint256"}], "outputs": [{"name": "", "type": "address"}], "gas": 2813}, {"stateMutability": "view", "type": "function", "name": "getApproved", "inputs": [{"name": "_tokenId", "type": "uint256"}], "outputs": [{"name": "", "type": "address"}], "gas": 5040}, {"stateMutability": "view", "type": "function", "name": "isApprovedForAll", "inputs": [{"name": "_owner", "type": "address"}, {"name": "_operator", "type": "address"}], "outputs": [{"name": "", "type": "bool"}], "gas": 3190}, {"stateMutability": "nonpayable", "type": "function", "name": "transferFrom", "inputs": [{"name": "_from", "type": "address"}, {"name": "_to", "type": "address"}, {"name": "_tokenId", "type": "uint256"}], "outputs": [], "gas": 173314}, {"stateMutability": "nonpayable", "type": "function", "name": "safeTransferFrom", "inputs": [{"name": "_from", "type": "address"}, {"name": "_to", "type": "address"}, {"name": "_tokenId", "type": "uint256"}], "outputs": [], "gas": 190624}, {"stateMutability": "nonpayable", "type": "function", "name": "safeTransferFrom", "inputs": [{"name": "_from", "type": "address"}, {"name": "_to", "type": "address"}, {"name": "_tokenId", "type": "uint256"}, {"name": "_data", "type": "bytes"}], "outputs": [], "gas": 190624}, {"stateMutability": "nonpayable", "type": "function", "name": "approve", "inputs": [{"name": "_approved", "type": "address"}, {"name": "_tokenId", "type": "uint256"}], "outputs": [], "gas": 46741}, {"stateMutability": "nonpayable", "type": "function", "name": "setApprovalForAll", "inputs": [{"name": "_operator", "type": "address"}, {"name": "_approved", "type": "bool"}], "outputs": [], "gas": 39516}, {"stateMutability": "nonpayable", "type": "function", "name": "mint", "inputs": [{"name": "_to", "type": "address"}, {"name": "_tokenId", "type": "uint256"}], "outputs": [{"name": "", "type": "bool"}], "gas": 82269}, {"stateMutability": "nonpayable", "type": "function", "name": "burn", "inputs": [{"name": "_tokenId", "type": "uint256"}], "outputs": [], "gas": 99632}]'
    contract_instance = w3.eth.contract(address=address, abi=abi)
    # Both raise error
    human_0_balance = contract_instance.functions.balanceOf(human_0).call({'from': foggy})
    # Change tokenId to avoid error
    token_id = 15
    result = contract_instance.functions.mint(human_0, token_id).transact({'from': human_0})

    import time
    time.sleep(60)
    new_human_0_balance = contract_instance.functions.balanceOf(human_0).call({'from': foggy})
    assert new_human_0_balance == human_0_balance + 1


if __name__ == '__main__':
    main()
