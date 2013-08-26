package ludumdare27.systems 
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	import flash.utils.Dictionary;
	import ludumdare27.components.Display;
	import ludumdare27.components.Position;
	import ludumdare27.nodes.RenderNode;
	import ludumdare27.nodes.SparkSpotlightNode;
	import ludumdare27.visuals.LayerIndexes;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class RenderSystem extends System
	{
		public var renderTarget : DisplayObjectContainer;
		
		private var m_renderNodes : NodeList;
		private var m_sparkNodes : NodeList;
		private var m_renderLayers : Dictionary;
		
		public function RenderSystem (renderTarget : DisplayObjectContainer) 
		{
			this.renderTarget = renderTarget;
			this.m_renderLayers = new Dictionary();
		}
		
		override public function addToEngine (engine : Engine) : void
		{
			this.m_renderNodes = engine.getNodeList(RenderNode);
			this.m_sparkNodes = engine.getNodeList(SparkSpotlightNode);
			
			for (var currentNode : RenderNode = this.m_renderNodes.head; currentNode; currentNode = currentNode.next)
			{
				this.addNodeToRenderTarget(currentNode);
			}
			
			this.m_renderNodes.nodeAdded.add(addNodeToRenderTarget);
			this.m_renderNodes.nodeRemoved.add(removeNodeFromRenderTarget);
		}
		
		private function addNodeToRenderTarget (renderNode : RenderNode) : void
		{
			var layer : DisplayObjectContainer = this.m_renderLayers[renderNode.display.layer];
			
			if (layer == null)
			{
				this.m_renderLayers[renderNode.display.layer] = new Sprite();
				layer = m_renderLayers[renderNode.display.layer];
				this.renderTarget.addChild(layer);
				
				var unsortedLayer : DisplayObjectContainer;
				for (var key : String in this.m_renderLayers)
				{
					unsortedLayer = this.m_renderLayers[key];
					unsortedLayer.parent.setChildIndex(unsortedLayer, parseInt(key));
				}
			}
			
			layer.addChild(renderNode.display.displayObject);
		}
		
		private function removeNodeFromRenderTarget (renderNode : RenderNode) : void
		{
			this.m_renderLayers[renderNode.display.layer].removeChild(renderNode.display.displayObject);
		}
		
		override public function update (time : Number) : void
		{
			// Spotlight filter initialization
			if (this.m_renderLayers[LayerIndexes.background] != null &&
				this.m_renderLayers[LayerIndexes.background].filter == null)
			{
				var spark : SparkSpotlightNode = this.m_sparkNodes.head;
				this.m_renderLayers[LayerIndexes.background].filter = spark.spotlight.spotlightFilter;
			}
			
			var currentNode : RenderNode;
			var positionComponent : Position;
			var displayComponent : Display;
			var displayObject : DisplayObject;
			
			for (currentNode = this.m_renderNodes.head; currentNode; currentNode = currentNode.next)
			{
				displayComponent = currentNode.display;
				displayObject = displayComponent.displayObject;
				positionComponent = currentNode.position;
				
				displayObject.x = positionComponent.position.x;
				displayObject.y = positionComponent.position.y;
			}
		}
		
		override public function removeFromEngine (engine : Engine) : void
		{
			this.m_renderNodes = null;
			this.m_sparkNodes = null;
		}
	}
}