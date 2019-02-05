package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	import com.li.dc.sebc.turboFSE.view.nodeView.BoxTree;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.filters.DropShadowFilter;
	
	import it.lispa.siss.sebc.flex.collection.HashEntry;
	import it.lispa.siss.sebc.flex.color.HTMLTabColor;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	
	import mx.core.UIComponent;

	public class ExpandViewCommand extends Command
	{
		public function ExpandViewCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			if(data !=null)
			{
				FSEModel.getInstance().oldParamExpand = data; 
				var select:Boolean 		= data.select;
				var who:UIComponent 	= data.who as UIComponent;
				if(select)
				{
					expand(who);
				}else
				{
					close(who);
				}
			}
		}
		private function getPad(who:UIComponent):Object
		{
			if(who is BoxTree)
			{
				return null;
			}
			var pad:Object	= {vertical:80,horizontal:70};
			return pad;
		}
		private function expand(who:UIComponent):void
		{
			try{
				var vmm:ViewMessageManager = ViewMessageManager.getInstance();
				if(!vmm.popUpBusy())
				{
					preparePopUp(who);	
					who.filters = [new DropShadowFilter(4,45,0,0.5,6,6)];
					vmm.showPanel( who ,HTMLTabColor.GREEN,getPad(who));
				}
			}catch(e:Error)
			{
				Debug.logError( "Error : "+e.message);
			}
		}
		private function preparePopUp(who:UIComponent):void
		{
			try{
				var entryMeasure:HashEntry 		= getEntry(who);
				FSEModel.getInstance().hashTable.putEntry( entryMeasure );
				var p:UIComponent	= (entryMeasure.value as Object).parent as UIComponent;
				if( p.contains( who ) )
				{
					//p.addEventListener(Event.REMOVED,removeChildAAAA,true,1000);
					 
					var indx:int = p.getChildIndex( who );
					p.removeChildAt(indx);
				}
			}catch(e:Error)
			{
				Debug.logError( "Error : "+e.message);
			}
		}
		private function removeChildAAAA(e:Event):void
		{
			Debug.logError( "Event type :: "+e);
			if (e.eventPhase == EventPhase.AT_TARGET){
				try{
					
					UIComponent(e.target).removeEventListener(Event.REMOVED,removeChildAAAA,true);
					e.stopImmediatePropagation();
				}catch(e:Error)
				{
					Debug.logError( "Error : "+e.message);
				}
			}
		}
		private function close(who:UIComponent):void
		{
			var name:String		= who.name;
			var measure:Object 	= FSEModel.getInstance().hashTable.getValue( name );
			var vmm:ViewMessageManager = ViewMessageManager.getInstance();
			vmm.closeDisplayer();
			var index:int = measure.index;
			var parent:DisplayObjectContainer	= measure.parent as DisplayObjectContainer;
			if(!parent.contains( who ))
			{
				var nmc:int	= parent.numChildren;
				if(index==nmc)
				{
					parent.addChild( who );
				}else if(index < nmc && index>=0)
				{
					parent.addChildAt(who,index);
				}
			} 
			who.x 		= measure.x; 
			who.y 		= measure.y; 
			who.width 	= measure.w; 
			who.percentHeight 	= measure.h;
			who.filters	= measure.filters;
		}
		private function getEntry(who:UIComponent):HashEntry
		{
			var name:String		= who.name;
			var w:Number		= who.width;	
			var h:Number		= who.percentHeight;
			var x:Number		= who.x;
			var y:Number		= who.y;
			var parent:DisplayObjectContainer	= who.parent;
			var index:int 		= parent.getChildIndex( who );
			var f:Array			= who.filters;
			var o:Object		= {x:x,y:y,w:w,h:h,parent:parent,index:index,filters:f};
			return new HashEntry(name,o);
		}
	}
}