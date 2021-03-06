//
//  ClientSignature.swift
//  VaporCoin
//
//  Created by Valtteri Koskivuori on 12/09/2017.
//

import Foundation

//This will contain key loading, signing, funcs to check balance...

class Wallet {
	
	var pubKey: AsymmetricKey? = nil
	var privKey: AsymmetricKey? = nil
	
	var nonce: UInt64
	
	var address: Data? {
		return self.pubKey?.keyData.ripemd160
	}
	
	var readableAddress: String? {
		return self.address?.base58
	}
	
	init(pub: AsymmetricKey, priv: AsymmetricKey) {
		self.pubKey = pub
		self.privKey = priv
		self.nonce = 0
	}
	
	init() {
		self.pubKey = nil
		self.privKey = nil
		self.nonce = 0
	}
	
	init(withKeyPath: String) {
		//TODO: Fetch from blockchain
		self.nonce = 0
		
		//Try and load up the keypair into memory
		print("Loading keypair")
		print("Looking for keys in \(withKeyPath)")
		
		do {
			self.privKey = try AsymmetricKey.makePrivateKey(readingPEMAtPath: withKeyPath + "private.pem", passphrase: nil)
		} catch {
			print("Private key not found at \(withKeyPath)")
		}
		
		do {
			self.pubKey = try AsymmetricKey.makePublicKey(readingPEMAtPath: withKeyPath + "public.pem")
		} catch {
			print("Public key not found at \(withKeyPath)")
		}
		
		if self.pubKey != nil && self.privKey != nil {
			print("Keys loaded")
		}
	}
	
	func signTransaction(txn: Transaction, priv: Wallet) -> Data {
		return Data()
	}
	
	//TODO
	func signMessage(msg: Data, priv: Wallet) -> Data {
		//let megaRandomBytes = [0x1a, 0x2b, 0x3c, 0x4d, 0x5e, 0x6f]
		//let ecdsaSHA512Sig = try Signature.sign(message: msg, with: priv.privKey, using: .sha512)
		//let ecdsaPrivateKey = try! CryptoKey(path: "/path/to/ecdsa_privateKey.pem", component: .privateKey(passphrase: nil))
		//let ecdsaSHA512Sig = try Signature.sign(message: megaRandomBytes, with: ecdsaPrivateKey, using: .sha512)
		//let newSignatureee = try Signature.si
		return Data()
	}
	
	//TODO
	func checkSignature(msg: Data, sign: Wallet) -> Bool {
		//'Decrypt' the signature, and then see if hash matches data
		return false
	}
}
