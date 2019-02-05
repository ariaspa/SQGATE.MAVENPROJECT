package it.lisit.siss.flex.utility.xml
{
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;
	
	import memorphic.xpath.XPathQuery;
	import memorphic.xpath.model.XPathContext;
	/**
	 * Trascizione della classe XMLUtility di Luca Sartori
	 * Si appoggia sul framework memorphic xpath-as3-1.0.0.swc
	 * Fornisce una serie di metodi per selezionare copiare 
	 * e attribuire valori dentro un XML.
	 * Non consente l'indentazione
	 * @author Marco Salonia
	 * 
	 */	
	public class XPathUtility
	{
		/**
		 * Inizializzazione statica 
		 */		
		private static const INIT:Boolean = getInitialization();
		private static function getInitialization():Boolean
		{
			XML.prettyIndent = 0;
			return true;
		}
		private static var myQuery:XPathQuery;
		/**
		 * Restituisce il valore di un attributo
		 * @param xmlDoc il nodo XML di input
		 * @param xpathQuery la query in formato XPATH per selezionare il nodo
		 * @param attributeName il nome dell'attributo
		 * @return il valore dell'attributo
		 */ 
		public static function getAttributeValueFromNode(xmlDoc:XML,xpathQuery:String,attributeName:String):String
		{
			var node:XML = getNode(xmlDoc,xpathQuery);
			if(node==null)
			{
				return null; 
			}else
			{
				return node.@[attributeName];
			}
		}
		/**
		 * Inserisce il valore in un attributo
		 * @param xmlDoc il nodo XML di input
		 * @param xpathQuery la query in formato XPATH per selezionare il nodo
		 * @param attributeName il nome dell'attributo
		 * @param attributeValue il valore dell'attributo
		 */ 
		public static function setAttributeValueIntoNode(xmlDoc:XML,xpathQuery:String,attributeName:String,attributeValue:String):void
		{
			var node:XML = getNode(xmlDoc,xpathQuery);
			if(node!=null)
			{
				node.@[attributeName] = attributeValue;
			}
		}
		/**
		 * Converte la stringa in formato xml in un oggetto XML
		 * @param inputString la stringa in formato xml
		 * @return il nodo XML
		 */ 
		public static function getNodeFromString(inputString:String):XML
		{
			var xmlResult:XML = new XML(inputString);
			return xmlResult;
		}
		/**
		 * Converte il nodo XML in una stringa in formato xml
		 * @param inputNode il nodo XML
		 * @param prettyIndent true/false definisce se la stringa di uscita deve essere formattata
		 * @return la stringa in formato xml
		 */ 
		public static function getStringFromNode(inputNode:XML,prettyIndent:Boolean=false):String
		{
			var outputXMLString:String;
			if(prettyIndent)
			{
				XML.prettyIndent = 1;
				outputXMLString = inputNode.toXMLString();
				XML.prettyIndent = 0;
			}
			else
			{
				outputXMLString = inputNode.toXMLString();
			}
			return outputXMLString;
		}
		/**
		 * Importa un oggetto XML in un altro oggetto XML nel nodo selezionato dalla query XPATH
		 * @param targetNode il nodo XML di destinazione
		 * @param xpath la query in formato XPATH per selezionare il nodo 
		 * @param nodeToImport il nodo XML da importare
		 */ 
		public static function importNode(targetNode:XML,xpath:String,nodeToImport:XML):void
		{
			var nodeSelected:XML = getNode(targetNode,xpath);
			if(nodeSelected!=null)
			{
				nodeSelected.appendChild(nodeToImport);
			}
		}
		
		/**
		 * Esegue la query XPATH sul il nodo XML di input
		 * @private
		 * @param xmlDoc il nodo XML
		 * @param xmlDoc la query in formato XPATH di selezione 
		 * @return * il nodo derivante dalla selezione XPATH
		 */ 
		public static function execQuery(xmlDoc:XML,xpathQuery:String):*
		{
			var ns:Namespace = xmlDoc.namespace();
			var context:XPathContext = new XPathContext();
			if(ns!=null)
			{
				context.namespaces[ns.prefix] = ns.uri;
			}
			var query:XPathQuery = new XPathQuery(xpathQuery,context);
			return query.exec(xmlDoc);
		}
		
		/**
		 * Seleziona il nodo XML dalil nodo XML di input applicando la query XPATH
		 * @param xmlDoc il nodo XML
		 * @param xpath la query in formato XPATH per selezionare il nodo 
		 * @return result il nodo XML selezionato
		 */ 
		public static function getNode(xmlDoc:XML,xpathQuery:String):XML
		{
			var result:XMLList = execQuery(xmlDoc,xpathQuery);

			return result[0];
		}
		
		/**
		 * Seleziona una lista di nodi XML dalil nodo XML di input applicando la query XPATH
		 * @param xmlDoc il nodo XML
		 * @param xpath la query in formato XPATH per selezionare il nodo 
		 * @return result una lista di nodi XML
		 */ 
		public static function getNodeList(xmlDoc:XML,xpathQuery:String):XMLList
		{
			var result:XMLList = execQuery(xmlDoc,xpathQuery);
			return result;
		}
		
		/**
		 * Restituisce il numero di occorrenze risultanti dall'esecuzione della query XPATH
		 * @param xmlDoc il nodo XML
		 * @param xpath la query in formato XPATH per selezionare il nodo 
		 * @return result il numero di occorrenze risultanti
		 */ 
		public static function countNodes(xmlDoc:XML,xpathQuery:String):Number
		{
			var result:XMLList = execQuery(xmlDoc,xpathQuery);
			if(result!=null)
			{
				return result.length();
			}
			return 0;
		}
		
		/**
		 * Restituisce il valore contenuto nel nodo XML selezionato dalla query XPATH
		 * @param xmlDoc il nodo XML
		 * @param xpath la query in formato XPATH per selezionare il nodo 
		 * @return result il valore contenuto nel nodo XML
		 */ 
		public static function getNodeValue(xmlDoc:XML,xpathQuery:String):String
		{
			var result:XML = getNode(xmlDoc,xpathQuery);
			if(result!=null)
			{
				return result.text();
			}
			return "";
		}
		
		/**
		 * Inserisce il valore nel nodo XML selezionato dalla query XPATH
		 * @param xmlDoc il nodo XML
		 * @param xpath la query in formato XPATH per selezionare il nodo
		 * @param newValue il valore da inserire nel nodo
		 * @param result il valore contenuto nel nodo XML
		 */ 
		public static function setNodeValue(xmlDoc:XML,xpathQuery:String,newValue:String):void
		{
			var result:XML = getNode(xmlDoc,xpathQuery);
			if(result!=null&&newValue!=null)
			{
				if(result.children().length()>0)
				{
					result.children()[0] = newValue;
				}else
				{
					result.appendChild(new XMLNode(XMLNodeType.TEXT_NODE,newValue));
					
				}
			}
		}
		
		/**
		 * Crea un nodo XML e lo aggiunge al nodo XML selezionato dalla query XPATH
		 * @param xmlDoc il nodo XML
		 * @param xpath la query in formato XPATH per selezionare il nodo
		 * @param nameNodeToAdd il nome del nodo da creare
		 */ 
		public static function createNode(xmlDoc:XML,xpathQuery:String,nameNodeToAdd:String):void
		{
			var result:XML = getNode(xmlDoc,xpathQuery);
			if(result!=null)
			{
				result.appendChild(new XMLNode(XMLNodeType.ELEMENT_NODE,nameNodeToAdd));				
			}
		}
		
		/**
		 * Crea un nodo CDATA e lo aggiunge al nodo XML selezionato dalla query XPATH
		 * @param xmlDoc il nodo XML
		 * @param xpath la query in formato XPATH per selezionare il nodo
		 * @param cdataValue il valore del nodo CDATA
		 */ 
		public static function addCDATANode(xmlDoc:XML,xpathQuery:String,cdataValue:String):void
		{
			var result:XML = getNode(xmlDoc,xpathQuery);
			if(result!=null)
			{
				var cdataNode:XML = new XML("<![CDATA["+cdataValue+"]]>");
				if(result.children().length()>0)
				{
					result.children()[0] = cdataNode;
				}else
				{
					result.appendChild(cdataNode);
					
				}
			}
		}
			/**
		 * Rimuove il nodo selezionato dalla query XPATH
		 * @param xmlDoc il nodo XML
		 * @param xmlDoc la query in formato XPATH di selezione 
		 */ 
		public static function removeNode(xmlDoc:XML,xpathQuery:String):void
		{
			var result:XML = getNode(xmlDoc,xpathQuery);
			if(result!=null)
			{
				var nodeName:String = result.localName();
				var nodeParent:XML = result.parent();
				if(nodeParent!=null)
				{
					var nodeListChild:XMLList = nodeParent.child(nodeName);
					var i:int;
					for (i = 0; i < nodeListChild.length(); i++) {
						if(nodeListChild[i]==result)
						{
							delete nodeListChild[i];
							i--;
						}	
					}		
				}
			}
		}
		/**
		 * Esegue la query XPATH sulil nodo XML di input
		 * @param xmlDoc il nodo XML
		 * @param xmlDoc la query in formato XPATH di selezione 
		 * @return Object il nodo derivante dalla selezione XPATH
		 */ 
		public static function evaluateXPathExpression(xmlDoc:XML,xpathQuery:String):Object
		{
			return execQuery(xmlDoc,xpathQuery);
		}
	}
}