// Main APP :
var app = new Vue({
	el: '#app',
	data:{
		active : 'A',
		datas:null
	},
	mounted(){
		this.refresh('A', 'refresh');
	},
	methods:{
		refresh:function(value, action){
			var _this = this;
			_this.active = value;
			$.getJSON(action, function (json){
				_this.datas = json;
			});
		},
		isActive:function(value){
			return this.active === value;
		}
	}
})

// Program Card Component :
Vue.component('program-card',{
	props:['prog'],	
	template : '#prog-card',
	data:function(){
		return{
			progression:'0'		
		}
	},
	computed:{
		startInMs:function(){
			return moment(this.prog.start).format('x');
		},
		endInMs:function(){
			return moment(this.prog.end).format('x');
		},
		timeBetweenStartAndEnd:function()
		{
			return (this.endInMs - this.startInMs);
		},
		progressionStyle:function(){
			return "width:"+this.progression+"%";
		}

	},
	filters:{
		hour:function(value){
			return moment(value).format('HH:mm');
		}
	},
	mounted(){
		setInterval(this.updateProgressBar, 1000)
	},
	methods:{
		updateProgressBar:function(){
			this.progression = this.getProgression();
			
		},
		getProgression:function(){
			var now = moment().format('x');
			var timeBetweenStartAndToday = (now - this.startInMs);
			var p = Math.round(timeBetweenStartAndToday / this.timeBetweenStartAndEnd * 100);
			var p = (p >= 100)?100:p;
			var p = (p < 0)?0:p;
			return p;
		}
	}
}); 