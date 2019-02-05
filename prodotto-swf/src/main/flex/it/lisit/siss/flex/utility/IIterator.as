package it.lisit.siss.flex.utility
{
	/**
	 * Iteratore
	 * @author Marco Salonia
	 * 
	 */	
	public interface IIterator
	{
		/** 
	 	* @return <code>true</code> se l'iteratore ha altri elementi, altrimenti false .
	 	*/
		function hasNext():Boolean;
		/** 
		 * @return il prossimo elemento dell'iterazione. 
		 * throw new Error("Out of range");
		 */
		function next():Object;
		/**
		 * riazzera l'iteratore 
		 * 
		 */		
		function reset():void
	}
}