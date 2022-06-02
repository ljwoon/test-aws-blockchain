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

// type Sender struct {
// 	Id			string	`json:"id"`
// 	Email		string	`json:"email"`
// }

// type Receiver struct {
// 	Id			string	`json:"id"`
// 	Email		string	`json:"email"`
// }

// type Tool struct {
// 	Type	string `json:"type"`
// 	Color	string `json:"color"`
// 	Width	int `json:"width"`
// }

// type DrawingEvent struct {
// 	Points		[]int	`json:"points"`
// 	Tool		Tool	`json:"tool"`
// 	SignedTime	string	`json:"signedTime"`
// }

// type SenderSign struct {
// 	PageNum			int	`json:"pageNum"`
// 	DrawingEvent	[]DrawingEvent	`json:"drawingEvent"`
// 	SignedTime		string	`json:"signedTime"`
// }

// type ReceiverSign struct {
// 	PageNum			int	`json:"pageNum"`
// 	DrawingEvent	[]DrawingEvent	`json:"drawingEvent"`
// 	SignedTime		string	`json:"signedTime"`
// }

// Define the car structure, with 16 properties.  Structure tags are used by encoding/json library
type Contract struct {
	// Id               string `json:"id"`
	CompanyId        string `json:"companyId"`
	Title            string `json:"title"`
	Description      string `json:"description"`
	Sender           string `json:"sender"`
	Receiver         string `json:"receiver"`
	Date             string `json:"date"`
	OriginalFileName string `json:"originalFileName"`
	FileName         string `json:"fileName"`
	FileSize         string `json:"fileSize"`
	SaveKey          string `json:"saveKey"`
	Hash             string `json:"hash"`
	Status           string `json:"status"`
	RejectReason     string `json:"rejectReason"`
	SenderSign       string `json:"senderSign"`
	ReceiverSign     string `json:"receiverSign"`
	SenderHash       string `json:"senderHash"`
	ReceiverHash     string `json:"receiverHash"`
}

/*
 * The Init method is called when the Smart Contract "Contract" is instantiated by the blockchain network
 * Best practice is to have any Ledger initialization in separate function -- see initLedger()
 */
func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

/*
 * The Invoke method is called as a result of an application request to run the Smart Contract "Contract"
 * The calling application program has also specified the particular smart contract function to be called, with arguments
 */
func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	// Retrieve the requested Smart Contract function and arguments
	function, args := APIstub.GetFunctionAndParameters()
	// Route to the appropriate handler function to interact with the ledger appropriately
	if function == "queryTest" {
		return s.queryTest(APIstub, args)
	} else if function == "createContract" {
		return s.createContract(APIstub, args)
	} else if function == "selectContract" {
		return s.selectContract(APIstub, args)
	} else if function == "signSender" {
		return s.signSender(APIstub, args)
	} else if function == "signReceiver" {
		return s.signReceiver(APIstub, args)
	} else if function == "rejectContract" {
		return s.rejectContract(APIstub, args)
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

	contractAsBytes, _ := APIstub.GetState(args[0])
	return shim.Success(contractAsBytes)
}

// 계약서 업로드
func (s *SmartContract) createContract(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	// fmt.Println("문서 _Id값:" + args)

	if len(args) != 14 {
		return shim.Error("Incorrect number of arguments. Expecting 14")
	}

	var contract = Contract{CompanyId: args[1], Title: args[2], Description: args[3], Sender: args[4], Receiver: args[5], Date: args[6], OriginalFileName: args[7], FileName: args[8], FileSize: args[9], SaveKey: args[10], Hash: args[11], Status: args[12], RejectReason: args[13]}

	// var company = Company{Company_name: args[1], My_name: args[2], Your_name: args[3]}

	contractAsBytes, _ := json.Marshal(contract)
	APIstub.PutState(args[0], contractAsBytes)

	return shim.Success(nil)
}

// 보낸이 서명

func (s *SmartContract) signSender(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	// fmt.Println("문서 _Id값:" + args)

	if len(args) != 4 {
		return shim.Error("Incorrect number of arguments. Expecting 4")
	}

	// var contract = Contract{SenderSign: args[1], Status: args[2], SenderHash: args[3]}

	contractAsBytes, _ := APIstub.GetState(args[0])
	contract := Contract{}

	json.Unmarshal(contractAsBytes, &contract)
	contract.SenderSign = args[1]
	contract.Status = args[2]
	contract.SenderHash = args[3]

	contractAsBytes, _ = json.Marshal(contract)

	APIstub.PutState(args[0], contractAsBytes)

	return shim.Success(nil)
}

// 받은이 서명

func (s *SmartContract) signReceiver(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	// fmt.Println("문서 _Id값:" + args)

	if len(args) != 4 {
		return shim.Error("Incorrect number of arguments. Expecting 4")
	}

	contractAsBytes, _ := APIstub.GetState(args[0])
	contract := Contract{}

	json.Unmarshal(contractAsBytes, &contract)
	contract.ReceiverSign = args[1]
	contract.Status = args[2]
	contract.ReceiverHash = args[3]

	contractAsBytes, _ = json.Marshal(contract)

	APIstub.PutState(args[0], contractAsBytes)

	return shim.Success(nil)
}

// 계약 거절

func (s *SmartContract) rejectContract(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	// fmt.Println("문서 _Id값:" + args)

	if len(args) != 3 {
		return shim.Error("Incorrect number of arguments. Expecting 3")
	}

	contractAsBytes, _ := APIstub.GetState(args[0])
	contract := Contract{}

	json.Unmarshal(contractAsBytes, &contract)
	contract.RejectReason = args[1]
	contract.Status = args[2]

	contractAsBytes, _ = json.Marshal(contract)

	APIstub.PutState(args[0], contractAsBytes)

	return shim.Success(nil)
}

// 계약서 상세 조회
func (s *SmartContract) selectContract(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
	// 인자값이 하나이상이면 에러
	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	// 인자값 키
	//key := args[0]
	// 로그 남기기
	fmt.Println("계약서 요청 _Id값:" + args[0])

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
