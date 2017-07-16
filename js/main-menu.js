// Main APP :
var app = new Vue({
	el: '#app',
	data:{
		active : 'A',
		datas:null
	},
	created: function(){
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
	filters:{
		hour:function(value){
			return moment(value).format('HH:mm');
		}
	},
	methods:{
		updateProgressBar:function(){

		},
	}
});