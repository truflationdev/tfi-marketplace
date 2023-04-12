#!/usr/bin/env python3
from web3 import Web3
import json

node_url = 'CHAINSTACK NODE URL'
web3 = Web3(Web3.HTTPProvider(node_url))
abi = json.loads('ABI JSON CODE HERE')
address = '0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82'
   
contract = web3.eth.contract(address = address , abi = abi)
