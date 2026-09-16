Attribute VB_Name = "import"
Sub import()

Dim ws_import, ws_file As Worksheet
Set ws_import = Workbooks("home insurance ratemaking project 1").Worksheets("1. ENC - Home Dataset")
Set ws_file = Workbooks("Book2").Worksheets("Sheet1")

Dim current_row As Long
Dim transaction

ws_file.Columns("A:E").ClearContents
ws_file.Cells(1, "A").Value = "payment_id"
ws_file.Cells(1, "B").Value = "claim_id"
ws_file.Cells(1, "C").Value = "transaction"
ws_file.Cells(1, "D").Value = "transaction_year"
ws_file.Cells(1, "E").Value = "transaction_month"

current_row = 2
For i = 3 To 499:
    For j = 1 To 96:
        transaction = ws_import.Cells(i, 5 + j).Value
        If transaction > 0 Then
            ws_file.Cells(current_row, "A").Value = "PMT" + Format(current_row, "0000")
            ws_file.Cells(current_row, "B").Value = ws_import.Cells(i, "A").Value
            ws_file.Cells(current_row, "C").Value = transaction
            If j Mod 12 = 0 Then
                ws_file.Cells(current_row, "D").Value = Int(j / 12) - 1 + 2018
                ws_file.Cells(current_row, "E").Value = 12
            Else
                ws_file.Cells(current_row, "D").Value = Int(j / 12) + 2018
                ws_file.Cells(current_row, "E").Value = j Mod 12
            End If
            current_row = ws_file.Range("B1").End(xlDown).Row + 1
        End If
    Next j
Next i



End Sub
