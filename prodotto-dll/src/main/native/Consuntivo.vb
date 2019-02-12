Imports System
Imports System.Linq
Imports System.Collections.Generic
Imports System.Runtime.Serialization
Imports ElaboratiBase.Elaborato
Imports EwCore.Commons
Imports ElencoPrezzi.Prezziario
Imports EwCore.System
Imports ReportManutenzioneImprese.ReportElaboratoConsuntivo
Imports ReportManutenzioneImprese.Reports

Namespace Global.ConsuntiviInterventi.Consuntivo

    Public Class ConsuntivoInterventoModel
        Inherits Global.ElaboratiBase.Elaborato.ElaboratoBaseModel
        
        Public Property CodiceIntervento() As Int32
        
        Public Property CodiceBudget() As Int32
        
        Public Property Trasmesso() As Boolean = false
        
    End Class
    
    Public Class DettaglioConsuntivoInterventoModel
        Inherits Global.ElaboratiBase.Elaborato.DettaglioElaboratoModel
        
        Public Property CodiceIntervento() As Int32
        
        Public Property CodiceBudget() As Int32
        
        Public Property TotaleOneri() As Decimal
        
        Public Property TotaleSoggARibasso() As Decimal
        
        Public Property TotaleRibassato() As Decimal
        
        Public Property ImportoRibassato() As Decimal
        
        Public Property Ribasso() As Decimal
        
    End Class
    
    Public Class DettaglioConsuntivoIntervento_DecodificaArticoloModel
        Public Property DescrizioneArticolo() As String
        
        Public Property PrezzoUnitario() As Decimal
        
        Public Property CodiceUM() As String
        
        Public Property DescrizioneUM() As String
        
    End Class
    
    Public Class ConsuntivoIntervento_CalcolaTotaliModel
        Public Property Totale() As Decimal
        
        Public Property TotaleImportoRibassato() As Decimal
        
        Public Property TotaleOneri() As Decimal
        
        Public Property TotaleRibassato() As Decimal
        
        Public Property TotaleSoggARibasso() As Decimal
        
        Public Property Ribasso() As Decimal
        
    End Class
    
    Public Class CommandsModel
        Inherits Global.EwCore.Commons.ObservableModel
        
    End Class
    
End Namespace