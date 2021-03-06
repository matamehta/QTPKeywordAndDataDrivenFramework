'================================
'Author: Mircea Sirghi, hakkussg@gmail.com, www.linkedin.com/pub/mircea-sirghi/32/6b5/700/
'================================

Option Explicit

'================================
'Function Name - fnReadKeywords
'Purpose - This function reads the keywords that are associated to a given test case
'Source - http://www.automationrepository.com/2012/11/desigining-keyword-driven-framework-mapped-at-functional-level-part-2/
'================================
Function fnReadKeywords(sTCName, sSheetTOAdd, sSheetToImport, sExcelLocation)
 	Dim fname:fname = "fnReadKeywords"	
	gLogger.LogFunctionStart(fname)
    
    Dim iRow, iR
    
    'Add a new Sheet into QTP Data Table
    DataTable.AddSheet(sSheetTOAdd)
 
    'Import the Excel Sheet into QTP Data Table
    DataTable.AddSheet(sSheetTOAdd)    
    DataTable.ImportSheet sExcelLocation & "\" & sSheetToImport & ".xls", sSheetToImport, sSheetTOAdd

'	DataTable.AddSheet("SearchGoogle")
'
'    DataTable.ImportSheet sExcelLocation & "\SearchGoogle.xls", "SearchGoogle", "SearchGoogle"

 	
 
    'Loop through all the rows in the Data Sheet
    iRow = DataTable.GetSheet(sSheetTOAdd).GetRowCount
 
 	Dim found:found=false	 	
 
    For iR=1 to iRow
            'Set the Current Row in the Data Sheet according to the loop counter
            DataTable.GetSheet(sSheetTOAdd).SetCurrentRow iR
 
 			Dim sTestName:sTestName = DataTable("TestCaseName", sSheetTOAdd)
			Dim sSheetName:sSheetName = DataTable("TestFlowFileName", sSheetTOAdd)

            'Capture the Keyword based upon the test case name
            If (found=false And sTestName = sTCName) Or (found = true and sTestName="") Then
            		If(found=false) then            			
            			DataTable.AddSheet(sTestName)
            			DataTable.ImportSheet sExcelLocation & "\" & sSheetName & ".xls", sSheetName, sTCName
            		End If
                    'Call the executeFlow function that will execute the function associated to the keyword
                    If(DataTable("ExecuteStep", sSheetTOAdd) = "Yes") Then
                    	executeFlow DataTable("TestCaseFlow", sSheetTOAdd), sTCName
                    End If
                    found = true
            ElseIf found Then 
				DataTable.DeleteSheet sTCName
            	Exit For
            End If
    Next 
    gLogger.LogFunctionEnd(fname)
End Function
'================================

'================================
'Function Name - executeFlow
'Purpose - This function executes the functions that are associated to the given keyword
'Source - http://www.automationrepository.com/2012/11/desigining-keyword-driven-framework-mapped-at-functional-level-part-2/
'================================
Function executeFlow(flowName, sTestSheetName)
 
    'Call the function associated with the keyword
    Select Case flowName
        Case "ActionSearchString"  ActionSearchString(sTestSheetName)
        Case "ActionSelectFirstFoundLink" ActionSelectFirstFoundLink(sTestSheetName)
        Case "ActionMoveBackToTheGooglePage" ActionMoveBackToTheGooglePage(sTestSheetName)
    End Select
 
End Function
'================================

'================================
'Function Name - getBrowser
'Purpose - This function returns the BrowserName from repository 
'Arguments: sBrowserType(String) - can take the following values IE, Firefox, Chrome
'================================
Function getBrowser(sBrowserType)
	Select Case sBrowserType
    	Case "IE" getBrowser="IEBrowser"
    End Select
End Function
'================================