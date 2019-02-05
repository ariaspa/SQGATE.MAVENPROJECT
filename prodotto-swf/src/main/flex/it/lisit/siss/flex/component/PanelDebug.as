package it.lisit.siss.flex.component
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import it.lisit.siss.flex.core.Core;
	import it.lisit.siss.flex.sebwebsiss;
	import it.lisit.siss.flex.utility.debug.IConsole;
	import it.lisit.siss.flex.utility.debug.IFormatLog;
	
	import mx.containers.HBox;
	import mx.containers.TitleWindow;
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.controls.TextArea;
	import mx.events.ResizeEvent;
	use namespace sebwebsiss;
	public class PanelDebug extends TitleWindow implements IConsole
	{
		private var _consoleFilter:Boolean;
		private var _text:TextArea;
		private var formatLogHtml:IFormatLog;
		private var formatLogNorm:Format;
		private var _trasp:Boolean;
		private var _double:Boolean;
		private var _oldH:Number;
		private var rectApp:Rectangle;
		public var useHtml:Boolean;
		public function PanelDebug()
		{
			super();
			_consoleFilter 	= false;
			_trasp			= false;
			_double			= false;
			useHtml			= true;
			formatLogHtml 		= new FormatHTML();
			formatLogNorm 		= new Format();
			this.title		= "DEBUG";
			//LAYOUT
			var verticaBox:VBox	= new VBox();
			verticaBox.percentHeight = 100;
			verticaBox.percentWidth  = 100;
			
			var box:HBox    	= new HBox();
			box.percentWidth 	= 100;
			verticaBox.addChild( box );
			 
			var btnClear:Button = new Button();
			btnClear.label 		= "cancella";	
			btnClear.addEventListener(MouseEvent.CLICK,onClickClear);
			box.addChild( btnClear );
			 
			var btnTrasp:Button = new Button();
			btnTrasp.label 		= "trasparente";	
			btnTrasp.addEventListener(MouseEvent.CLICK,onClickTrasp);
			box.addChild( btnTrasp );
			
			var btnRid:Button = new Button();
			btnRid.label 		= "riduci";	
			btnRid.addEventListener(MouseEvent.CLICK,onClickRid);
			box.addChild( btnRid );
			
			_text				= new TextArea();
			_text.editable		= false;
			
			_text.percentHeight = 100;
			_text.percentWidth  = 100; 
			verticaBox.addChild( _text );
			this.addChild( verticaBox );
			//
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedStage);
		}
		//////////////////////////////////////////////////////////////////
		private function onClickRid(e:MouseEvent):void
		{
			var btn:Button = e.target as Button;
			if(!_oldH)
				_oldH = this.height;
				
			_double 	=!_double;
			btn.label 	=  _double ? "ingrandisci" : "riduci";
			this.height = _double ? 100 : _oldH; 
			 //
			var nwy:Number	= this.y + this.height;
			if(nwy>this.stage.height)
			{
				var dif:Number = nwy -  this.stage.height;
				this.y -= dif; 
			}  
		}
		private function onDrag(e:MouseEvent):void
		{
			this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			this.startDrag();
		}
		private function onStopDrag(e:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			this.stopDrag();
		}
		private function onMouseMove(e:MouseEvent):void
		{
			//
			var breakDrag:Boolean	= checkMargin();	
			if(breakDrag)
			{
				this.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
				this.stopDrag();
			}
		}
		private function checkMargin():Boolean
		{
			var xRight:Number	= this.x + this.width;
			var xLeft:Number	= this.x;
			var yTop:Number		= this.y;
			var yBot:Number		= this.y + this.height;
			///////////////////////////////////////////
			var breakDrag:Boolean	= false;
			if(rectApp!=null)
			{
				if(xRight>rectApp.width)
				{
					breakDrag 	= true;
					this.x 		= rectApp.width - this.width; 
				}
				if(xLeft<rectApp.x)
				{
					breakDrag 	= true;
					this.x 		= rectApp.x + 1;
				}
				if(yTop<rectApp.y)
				{
					breakDrag 	= true;
					this.y		= rectApp.y + 1;
				}
				if(yBot>rectApp.height)
				{
					breakDrag 	= true;
					this.y 		= rectApp.height - this.height; 
				}
			}
			return breakDrag;
		}
		private function onClickTrasp(e:MouseEvent):void
		{
			_trasp =!_trasp;
			this.alpha = _trasp ? 0.3 : 1;
		}
		private function onClickClear(e:MouseEvent):void
		{
			_text.text = "";
		}
		///////////////MI ASSICURO CHE STIA SEMPRE AL TOP////////////////
		
		private function onAddedChildParent(e:Event):void
		{
			var myIndex:int 	= this.parent.getChildIndex(this);
			var topIndex:int 	= this.parent.numChildren-1;
			if(myIndex<topIndex)
			{
				this.parent.swapChildrenAt(myIndex,topIndex);
			}
		}
		private function onRemoveStage(e:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoveStage);
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedStage);
			this.parent.removeEventListener(Event.ADDED,onAddedChildParent);
			this.titleBar.removeEventListener(MouseEvent.MOUSE_DOWN,onDrag);
			this.titleBar.removeEventListener(MouseEvent.MOUSE_UP,onStopDrag);
			if(Core._app!=null)
				Core._app.removeEventListener(ResizeEvent.RESIZE,onResizeApp);
		}
		private function onAddedStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoveStage);
			this.parent.addEventListener(Event.ADDED,onAddedChildParent); 
			this.callLater( addTittle );
		}
		private function addTittle():void
		{
			this.titleBar.addEventListener(MouseEvent.MOUSE_DOWN,onDrag);
			this.titleBar.addEventListener(MouseEvent.MOUSE_UP,onStopDrag);
			if(Core._app!=null)
			{
				rectApp = new Rectangle(Core._app.x,Core._app.y,Core._app.width,Core._app.height);
				Core._app.addEventListener(ResizeEvent.RESIZE,onResizeApp);
			}
		}
		private function onResizeApp(e:ResizeEvent):void
		{
			rectApp = new Rectangle(Core._app.x,Core._app.y,Core._app.width,Core._app.height);
			checkMargin();
		}
		/////////////////////////////////////////////////////////////////////
		public function get consoleFilter():Boolean
		{
			return _consoleFilter;
		}
		public function set consoleFilter(value:Boolean):void
		{
			_consoleFilter = value;
		}
		public function write(message:Object, level:uint, levelDebug:uint=0):void
		{
			var popentag:RegExp 	= /</g;
			var pclosetag:RegExp 	= />/g;
			 //
			var msgg:String	= String( message );
			msgg 			= msgg.replace(popentag,"&lt;");
			msgg 			= msgg.replace(pclosetag,"&gt;");
			//StringUtil.trim(
			var msg:String  = formatLogHtml.getFormatString(msgg,level,levelDebug);
			
			_text.htmlText			+= msg+"\n"; 
		}
	}
}
////////////////////////////////////////////////////////////////////////////
	import it.lisit.siss.flex.utility.debug.IFormatLog;
	import it.lisit.siss.flex.utility.debug.DebugUtils;
	import it.lisit.siss.flex.utility.debug.DebugLevel;
	
class Format implements IFormatLog
{
	public static var counter:uint;
	public function Format()
	{
		counter = 0;
	}
	protected function getDate():String
	{
		return DebugUtils.getCompleteStringDate();
	}
	protected function getLevel(level:uint):String
	{
		return DebugUtils.getStringLevel( level );
	}
	public function getFormatString(message:Object, level:uint, levelDebug:uint=0):String
	{
		counter++;
		var lev:String 		= getLevel(level);
		var logDate:String 	= getDate();
		var msg:String =  "***[MSG "+counter+" - DATE "+logDate+" - LEVEL : "+lev+"]***\n"+message+"\n======================================";
		return msg;
	}
}
 
class FormatHTML extends Format
{
	public function FormatHTML()
	{
	}
	override public function getFormatString(message:Object, level:uint, levelDebug:uint=0):String
	{
		Format.counter++;
		var lev:String 		= getLevel(level);
		var logDate:String 	= getDate();
		var newCol:String 	= getColor(level);
		var msg:String = "<font color='"+newCol+"'><b>***[MSG "+Format.counter+" - DATE "+logDate+" - LEVEL : "+lev+"]***</b><br>"+message+"<br>======================================</font>";
		return msg;
	}
	private function getColor(level:int):String
	{
		switch(level)
		{
			case DebugLevel.DEBUG:	
				return "#006600";
			case DebugLevel.ERROR:
				return "#FF0000";	
			case DebugLevel.FATAL:	
				return "#990033";
			case DebugLevel.INFO:	
				return "#006666";
			case DebugLevel.WARNING:	
				return "#CC9900";
		}
		return "#000000";
	}
}