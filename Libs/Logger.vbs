'================================
'Author: Mircea Sirghi, hakkussg@gmail.com, www.linkedin.com/pub/mircea-sirghi/32/6b5/700/
'================================

Option Explicit

'================================
 'Description : Logger's global variable used for events logging 
'================================
Dim gLogger
Set gLogger=New ClsLogger

'================================
'Logger class
'Code from: http://everythingaboutqa.blogspot.com/2011/07/qtp-generating-customized-logs-during.html
'================================
Class ClsLogger

    Public v_StepName, v_ProjectPath, objLogger
    Private objFSO

	'================================
    'Description : Function used to initiate the log file
    'Arguments  :  sStepName(String) -- Name of the step(can be any text)
    '================================
    Public Sub LogStart(ByVal sStepName)
   
        'Dim objFSO
           
        v_StepName=sStepName
       
        Set objFSO = CreateObject("Scripting.FileSystemObject")
        
        v_ProjectPath = Environment.Value("TestDir")
        
'        Set wshShell = CreateObject( "WScript.Shell" )
'		
'		'WScript.Echo wshShell.ExpandEnvironmentStrings( "%PATHEXT%" )
'		'WScript.Echo wshShell.ExpandEnvironmentStrings( "PATH=%PATH%" )
'		msgbox wshShell.ExpandEnvironmentStrings( "PATH=%PATH%" )
'		
'		Set wshShell = Nothing


		'msgbox Environment.Value("TestDir")
         
        'Set objLogger=objFSO.OpenTextFile(v_ProjectPath & "\Logs.txt", 8, True)
        
        Set objLogger=objFSO.OpenTextFile(v_ProjectPath & "\Logs.txt", 2, True)        

        objLogger.WriteLine(Now() & " '" & sStepName & "' execution has been Started" )
        
        objLogger.WriteLine(vbcrlf)

    End Sub

	'================================
    'Description : Function used to end the log file
    'Arguments  :  N/A 
    '================================
    Public Sub LogEnd()
    
    	objLogger.WriteLine(vbcrlf)

        objLogger.WriteLine(Now() & " '" & v_StepName & "' execution has been Completed" )
       
        objLogger.Close

        SET objLogger = NOTHING

        SET objFSO = NOTHING

    End Sub

    '================================
    'Description: Function used to capture any exception in log file that is occurred during script execution
    'Arguments 1:  sStepName(String)-- Name of the step(can be any text) 
    'Arguments 2: sException(String)-- Exception that needs to be logged   
    '================================
    Public Sub LogException(ByVal sStepName, ByVal sException)
    	objLogger.WriteLine(vbcrlf)

        objLogger.WriteLine(Now() & " Exception has been raised on step '" & sStepName & "': " & sException & Err.Description)

        objLogger.WriteLine(vbcrlf)

        Err.Clear

    End Sub

 	'================================
    'Description: Function used to capture any Warnings in log file that is occurred during script execution
    'Arguments 1:  sStepName(String)-- Name of the step(can be any text) 
    'Arguments 2: sWarning(String)-- Warning that needs to be logged   
    '================================
    Public Sub LogWarning(ByVal sStepName, ByVal sWarning)
    	objLogger.WriteLine(vbcrlf)

        objLogger.WriteLine(Now() & " Warning has been raised on step '" & sStepName & "': " & sWarning & Err.Description)

        objLogger.WriteLine(vbcrlf)

        Err.Clear

    End Sub

    '================================
    'Description: Function used to write any statement in log file
    'Arguments: sLine(String)-- Statement to be written in log(can be any text)  
    '================================
    Public Sub LogWrite(sLine)

        objLogger.WriteLine(Now() & " " & sLine)

        'objLogger.WriteLine(vbcrlf)

    End Sub  
    
    '================================
	'Description: Function used to write start of function statement to the log
    'Arguments: sName(String)-- Function name
    '================================
	Public Sub LogFunctionStart(sName)

        objLogger.WriteLine(Now() & " " & "Starting function: ["& sName &"]")

        'objLogger.WriteLine(vbcrlf)

    End Sub 

	'================================
	'Description: Function used to write end of function statement to the log
    'Arguments: sName(String)-- Function name
    '================================
	Public Sub LogFunctionEnd(sName)

        objLogger.WriteLine(Now() & " " & "  Ending function: ["& sName &"]")

        'objLogger.WriteLine(vbcrlf)

    End Sub 
End Class  
'================================