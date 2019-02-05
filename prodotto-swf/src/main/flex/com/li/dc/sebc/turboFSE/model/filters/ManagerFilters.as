package com.li.dc.sebc.turboFSE.model.filters
{
	import com.li.dc.sebc.turboFSE.model.filters.base.ValidFolderSpecification;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.util.ArrayCollectionIterator;
	
	import flash.utils.Dictionary;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.specification.ISpecification;
	
	import mx.collections.ArrayCollection;
	
	public class ManagerFilters
	{
		public static const KEY_ENTE:String 		= "keyEnte";
		public static const KEY_DATE:String 		= "keyDate";
		public static const KEY_EROGAZIONE:String 	= "keyErogazione";
		public static const KEY_FOLDER:String 		= "keyFolder";
		public static const KEY_PRESIDIO:String 	= "keyPresidio";
		
		private static var instance:ManagerFilters;
		public static function getInstance():ManagerFilters
		{
			if(instance==null)
			{
				instance = new ManagerFilters();
			}
			return instance;
		}
		private var dictionary:Dictionary;
		private var specification:ISpecification;
		public function ManagerFilters()
		{
			 dictionary = new Dictionary(); 
		}
		public function hasFilter():Boolean
		{
			return getHasSpecification();
		} 
		public function getFilter(key:String):ISpecification
		{
			return dictionary[key];
		}
		public function addFilter(nameFilter:String,filter:ISpecification):void
		{
			if(dictionary[nameFilter]==null)
			{
				dictionary[nameFilter] = filter;
			}
		}
		public function removeFilter(nameFilter:String):void
		{
			delete dictionary[nameFilter];
		}
		private function recursiveFilters(list:ArrayCollection):ArrayCollection
		{
			var iter:ArrayIterator	= new ArrayCollectionIterator(list);
			while(iter.hasNext())
			{
				var folder:FolderTree 	= iter.next() as FolderTree;
				folder.visible			= specification.isSatisfiedBy( folder );
				if(folder.children!=null && folder.children.length>0)
				{
					folder.children		= internalExecuteFilters(folder.children);
				}
			}
			return list;
		}
		private function internalExecuteFilters(listaFolder:ArrayCollection ):ArrayCollection
		{
			return  recursiveFilters( listaFolder  )  ; 
		}
		public function executeFilters( listaFolder:ArrayCollection ):ArrayCollection
		{
			clear();
			createFilter();
			return internalExecuteFilters( listaFolder );
		}
		private function getHasSpecification():Boolean
		{
			for(var s:Object in dictionary)
			{
				return true
			}
			return false;
		}
		private function createFilter():void
		{
			var hasSpecification:Boolean	= getHasSpecification();
			if(hasSpecification)
			{
				var oldSpec:ISpecification;
				for(var s:Object in dictionary)
				{
					specification = dictionary[s] as ISpecification;
					if(oldSpec!=null)
					{
						specification  = oldSpec.and( specification );	
					}
					oldSpec = specification
				}	
			}else
			{
				specification	= new ValidFolderSpecification();
			}
		}
		private function clear():void
		{
			specification = null;
		}
		public function clearSpecification():void
		{
			clear();
		}
	}
}