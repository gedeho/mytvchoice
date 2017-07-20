Vue.component('chanl-list',{
	template: '#channel-list',
	data:function(){
	    return{
	    	checkedNames:Cookies.getJSON('channelselection') || ["2", "3", "13", "5", "6", "1"]
	    }
	},	
	methods:{
		addChannel:function(){
			Cookies.set('channelselection', this.checkedNames, {expires:7});
		},
		getChannels:function(){
			this.$emit('channel-list-updated');
		}
	},
	mounted(){
		this.addChannel();
	}
});

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
		hour:(value)=>moment(value).format('HH:mm')
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
			p = (p >= 100)?100:p;
			p = (p < 0)?0:p;
			return p;
		}
	}
}); 



// Main APP :
var app = new Vue({
	el: '#app',
	data:{
		active : 'A',
		currentView:'refresh',
		datas:null
	},
	mounted(){
		this.refresh('A', 'refresh');
	},
	methods:{
		refresh:function(value, action){
			var _this = this;
			this.active = value;
			this.currentView = action;
			
			this.$http.get(action).then(function(response){
				_this.datas = response.body;
			})
		},
		updateChannels:function(){
			this.refresh(this.active, this.currentView);
		},
		isActive:function(value){
			return this.active === value
		}
	}
});



