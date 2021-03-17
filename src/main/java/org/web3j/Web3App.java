package org.web3j;

import org.web3j.crypto.Credentials;
import org.web3j.crypto.Wallet;
import org.web3j.crypto.WalletUtils;
import org.web3j.generated.contracts.OZERC721;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.RemoteFunctionCall;
import org.web3j.protocol.core.methods.response.Web3ClientVersion;
import org.web3j.protocol.http.HttpService;
import org.web3j.tx.gas.ContractGasProvider;
import org.web3j.tx.gas.DefaultGasProvider;
import org.web3j.tx.gas.StaticGasProvider;

import java.io.IOException;
import java.math.BigInteger;

/**
 * <p>This is the generated class for <code>web3j new helloworld</code></p>
 * <p>It deploys the Hello World contract in src/main/solidity/ and prints its address</p>
 * <p>For more information on how to run this project, please refer to our <a href="https://docs.web3j.io/quickstart/#deployment">documentation</a></p>
 */
public class Web3App {

   private static final String nodeUrl = System.getenv().getOrDefault("WEB3J_NODE_URL", "http://127.0.0.1:8545");
   private static final String walletPassword = System.getenv().getOrDefault("WEB3J_WALLET_PASSWORD", "<wallet_password>");
   private static final String walletPath = System.getenv().getOrDefault("WEB3J_WALLET_PATH", "<wallet_path>");

   private static final Credentials credentials = Credentials.create("0x757cf9f10c1587be6c73294b373961ed0540c3daf86826144a97056405f25665");

   public static void main(String[] args) throws Exception {

//        Credentials credentials = WalletUtils.loadCredentials(walletPassword, walletPath);
        Web3j web3j = Web3j.build(new HttpService(nodeUrl));

////        System.out.println("Deploying HelloWorld contract ...");
////        ContractGasProvider contractGasProvider = new StaticGasProvider(BigInteger.valueOf(4_100_000_000L), BigInteger.valueOf(90_000_000L));
////        HelloWorld helloWorld = HelloWorld.deploy(web3j, credentials, contractGasProvider, "Hello Blockchain World!").send();
////        System.out.println("Contract address: " + helloWorld.getContractAddress());
////        System.out.println("Greeting method result: " + helloWorld.greeting().send());
//
//       HelloWorld helloWorld = HelloWorld.load("0xd0b7f2cdfc03413907b03f3dadf8168d58f70fea", web3j, credentials, new DefaultGasProvider());
//       String greeting =  helloWorld.greeting().send();
//       System.out.println(greeting);
//       deployContract(web3j);
       getInfo(web3j);
   }

   public static void getClientVersion() throws IOException {
       Web3j web3 = Web3j.build(new HttpService());  // defaults to http://localhost:8545/
       Web3ClientVersion web3ClientVersion = web3.web3ClientVersion().send();
       String clientVersion = web3ClientVersion.getWeb3ClientVersion();
       System.out.println(clientVersion);
   }

   public static void deployContract(Web3j web3j) throws Exception {
       ContractGasProvider contractGasProvider = new StaticGasProvider(BigInteger.valueOf(4_100_000_000L), BigInteger.valueOf(100_000_000L));
       OZERC721 ozerc721 = OZERC721.deploy(web3j,credentials,contractGasProvider).send();
       System.out.println(ozerc721.getContractAddress());
   }

   public static void getInfo(Web3j web3j) throws  Exception{
       OZERC721 ozerc721 = OZERC721.load("0xd323bfc8ed0d0e8fa923dc00df30848bd6721fb2", web3j, credentials, new DefaultGasProvider());
       System.out.println(ozerc721.name().send());
   }

}

