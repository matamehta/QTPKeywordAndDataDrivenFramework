'================================
'Author: Mircea Sirghi, hakkussg@gmail.com, www.linkedin.com/pub/mircea-sirghi/32/6b5/700/
'================================

Option Explicit

'Registering the user defined functions
'================================

RegisterUserFunc "WebEdit", "fnSetValue", "fnSetValue"
RegisterUserFunc "WebEdit", "fnClickSecure", "fnClickSecure"
RegisterUserFunc "WebElement", "fnClickSecure", "fnClickSecure"

'================================
'Function name - fnSetValue
'Description - Set value in a text field
'================================
Function fnSetValue(ByRef objControl,ByVal strValue)
	
	Dim fname:fname = "fnSetValue"
	
	gLogger.LogFunctionStart(fname)
 	fnSetValue = false
 	
 	Err.Number = 0 
	On Error Resume Next

	'Set the value
 	objControl.Object.Value = ""
	objControl.Set strValue
	 
	Dim message:message="Value - '" & strValue & "' entered in Field - '" & objControl.ToString() & "'"
	 
	'Report out the result
	If Err.Number = 0 Then
		fnSetValue = true
		if(objControl.Object.Value = strValue) Then	
			Reporter.ReportEvent micPass, message, "Passed"
			Call gLogger.LogWrite(message & "," & "Passed")
		Else
			Reporter.ReportEvent micFail, message, "Failed"
			Call gLogger.LogException(fname, message & "," & "Failed")	
		End If
	Else
		Reporter.ReportEvent micFail, message, "Failed"
		Call gLogger.LogException(fname, message & "," & "Failed")	
	End If
	
	On Error GOTO 0
	gLogger.LogFunctionEnd(fname)
End Function
'================================


'================================
'Function name - fnClickSecure
'Description - Clicks on the specified x,y arguments to make sure QTP clicks ot the object area not on its edges.
'================================
Function fnClickSecure(ByRef objControl)	
	objControl.Click 3,3
End Function
'================================