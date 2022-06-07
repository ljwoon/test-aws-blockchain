

package main

import (
	// "bytes"
	"encoding/json"
	"fmt"
	// "strconv"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

// Define the Smart Contract structure
type SmartContract struct {
}

// Define the car structure, with 4 properties.  Structure tags are used by encoding/json library
type Document struct {
	Id						string `json:"id"`
	CompanyId   			string `json:"companyId"`
	Uploader   				string `json:"uploader"`
	Title  					string `json:"title"`
	Content  				string `json:"content"`
	OriginalFileName 		string `json:"originalFileName"`
	FileName 				string `json:"fileName"`
	FileSize 				string `json:"fileSize"`
	SaveKey					string `json:"saveKey"`
	Hash 					string `json:"hash"`
	FileBuffer 				string `json:"fileBuffer"`

}

/*
 * The Init method is called when the Smart Contract "Document" is instantiated by the blockchain network
 * Best practice is to have any Ledger initialization in separate function -- see initLedger()
 */
func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

/*
 * The Invoke method is called as a result of an application request to run the Smart Contract "Document"
 * The calling application program has also specified the particular smart contract function to be called, with arguments
 */
func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	// Retrieve the requested Smart Contract function and arguments
	function, args := APIstub.GetFunctionAndParameters()
	// Route to the appropriate handler function to interact with the ledger appropriately
	if function == "queryTest" {
		return s.queryTest(APIstub, args)
	}  else if function == "createDocument" {
		return s.createDocument(APIstub, args)
	}  else if function == "selectDocument" {
		return s.selectDocument(APIstub, args)
	} 
	// else if function == "initLedger" {
	// 	return s.initLedger(APIstub)
	// }

	return shim.Error("Invalid Smart Contract function name.")
}

func (s *SmartContract) queryTest(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	documentAsBytes, _ := APIstub.GetState(args[0])
	return shim.Success(documentAsBytes)
}




// 문서 업로드
func (s *SmartContract) createDocument(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	// fmt.Println("문서 _Id값:" + args)

	if len(args) != 11 {
		return shim.Error("Incorrect number of arguments. Expecting 11")
	}

	var document = Document{CompanyId: args[1], Uploader: args[2], Title: args[3], Content: args[4], OriginalFileName: args[5], FileName: args[6], FileSize: args[7], SaveKey: args[8], Hash: args[9], FileBuffer: args[10]}

	// var company = Company{Company_name: args[1], My_name: args[2], Your_name: args[3]}

	documentAsBytes, _ := json.Marshal(document)
	APIstub.PutState(args[0], documentAsBytes)

	return shim.Success(nil)
}


// 문서 상세 조회
func (s *SmartContract) selectDocument(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
	// 인자값이 하나이상이면 에러
	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	// 인자값 키
	//key := args[0]
	// 로그 남기기
	fmt.Println("휴가 요청 _Id값:" + args[0])

	resultsIterator, _ := APIstub.GetState(args[0])

	return shim.Success(resultsIterator)
}



// The main function is only relevant in unit test mode. Only included here for completeness.
func main() {

	// Create a new Smart Contract
	err := shim.Start(new(SmartContract))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}
