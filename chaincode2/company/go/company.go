

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
type LeaveRequest struct {
	Id						string `json:"id"`
	Requestor   			string `json:"requestor"`
	ApproverId  			string `json:"approverId"`
	Approver  				string `json:"approver"`
	LeaveType 				string `json:"leaveType"`
	LeaveDay 				string `json:"leaveDay"`
	LeaveDuration 			string `json:"leaveDuration"`
	LeaveStartDate 			string `json:"leaveStartDate"`
	LeaveEndDate 			string `json:"leaveEndDate"`
	LeaveReason 			string `json:"leaveReason"`
	Status 					string `json:"status"`
	Year 					string `json:"year"`
}

/*
 * The Init method is called when the Smart Contract "LeaveRequest" is instantiated by the blockchain network
 * Best practice is to have any Ledger initialization in separate function -- see initLedger()
 */
func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

/*
 * The Invoke method is called as a result of an application request to run the Smart Contract "LeaveRequest"
 * The calling application program has also specified the particular smart contract function to be called, with arguments
 */
func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	// Retrieve the requested Smart Contract function and arguments
	function, args := APIstub.GetFunctionAndParameters()
	// Route to the appropriate handler function to interact with the ledger appropriately
	if function == "queryTest" {
		return s.queryTest(APIstub, args)
	}  else if function == "createLeaveRequest" {
		return s.createLeaveRequest(APIstub, args)
	}  else if function == "selectLeaveRequest" {
		return s.selectLeaveRequest(APIstub, args)
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

	leaveRequestAsBytes, _ := APIstub.GetState(args[0])
	return shim.Success(leaveRequestAsBytes)
}




// 휴가 요청 생성
func (s *SmartContract) createLeaveRequest(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	// fmt.Println("휴가 요청 _Id값:" + args)

	if len(args) != 12 {
		return shim.Error("Incorrect number of arguments. Expecting 12")
	}

	var leaveRequest = LeaveRequest{Requestor: args[1], ApproverId: args[2], Approver: args[3], LeaveType: args[4], LeaveDay: args[5], LeaveDuration: args[6], LeaveStartDate: args[7], LeaveEndDate: args[8], LeaveReason: args[9], Status: args[10], Year: args[11]}

	// var company = Company{Company_name: args[1], My_name: args[2], Your_name: args[3]}

	leaveRequestAsBytes, _ := json.Marshal(leaveRequest)
	APIstub.PutState(args[0], leaveRequestAsBytes)

	return shim.Success(nil)
}


// 휴가 상세 조회
func (s *SmartContract) selectLeaveRequest(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
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
