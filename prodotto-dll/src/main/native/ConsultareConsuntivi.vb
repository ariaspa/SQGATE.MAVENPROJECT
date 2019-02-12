Imports System
Imports System.Linq
Imports System.Collections.Generic
Imports System.Runtime.Serialization
Imports ConsuntiviInterventi.Consuntivo
Imports EwCore.Commons
Imports EwCore.Collections

Namespace Global.ConsuntiviInterventi.ConsultareConsuntivi

    Public Class ListModel
        Inherits Global.EwCore.Collections.PagedListModel(Of ConsuntivoItemModel)
        
        Public Property Filter() As String
        
    End Class
    
    Public Class ConsuntivoItemModel
        Inherits Global.ConsuntiviInterventi.Consuntivo.ConsuntivoInterventoModel
        
    End Class
    
End Namespace