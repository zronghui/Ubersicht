command:"pmset -g batt | grep \"%\" | awk 'BEGINN { FS = \";\" };{ print $4,$3, $2 }' | sed -e 's/-I/I/' -e 's/-0//' -e 's/;//' -e 's/;//'",

refreshFrequency: 10000,

render: function () {
	$('head').append('<link rel="stylesheet" href="circular-liquid-battery.widget/cb.css" type="text/css" /><link href="http://fonts.googleapis.com/css?family=Dosis:200,300" rel="stylesheet" type="text/css">');
	return "<div id='batt'></div>";
	},
update: function (output){
	var arr = output.split(' ');
	var percent = arr[1].split('%');
	var a = arr[0];
	var power = "";
	var image = "";
	var percentage = "";
	var percentagebg = "";
	if (a == "discharging"){
		power = "Battery";
		image = '<img src="circular-liquid-battery.widget/bat.png" width="30px">';
	}else{
		power = "Charging"
		image = '<img src="circular-liquid-battery.widget/charge.png" width="30px">';
	}
	if (percent[0]<=5){
		percentage = "wave0";
		percentagebg = "waveb0";
	}
	else if(percent[0]<=10 && percent[0]>5){
		percentage = "wave5";
		percentagebg = "waveb5";
	}
	else if(percent[0]<=15 && percent[0]>10){
		percentage = "wave10";
		percentagebg = "waveb10";
	}
  else if(percent[0]<=20 && percent[0]>15){
		percentage = "wave15";
		percentagebg = "waveb15";
	}
	else if(percent[0]<=25 && percent[0]>20){
		percentage = "wave20";
		percentagebg = "waveb20";
	}
	else if(percent[0]<=30 && percent[0]>25){
		percentage = "wave25";
		percentagebg = "waveb25";
	}
  else if(percent[0]<=35 && percent[0]>30){
		percentage = "wave30";
		percentagebg = "waveb30";
	}
	else if(percent[0]<=40 && percent[0]>35){
		percentage = "wave35";
		percentagebg = "waveb35";
	}
	else if(percent[0]<=45 && percent[0]>40){
		percentage = "wave40";
		percentagebg = "waveb40";
	}
  else if(percent[0]<=50 && percent[0]>45){
		percentage = "wave45";
		percentagebg = "waveb45";
	}
	else if(percent[0]<=55 && percent[0]>50){
		percentage = "wave50";
		percentagebg = "waveb50";
	}
	else if(percent[0]<=60 && percent[0]>55){
		percentage = "wave55";
		percentagebg = "waveb55";
	}
  else if(percent[0]<=65 && percent[0]>60){
		percentage = "wave60";
		percentagebg = "waveb60";
	}
	else if(percent[0]<=70 && percent[0]>65){
		percentage = "wave65";
		percentagebg = "waveb65";
	}
	else if(percent[0]<=75 && percent[0]>70){
		percentage = "wave70";
		percentagebg = "waveb70";
	}
  else if(percent[0]<=80 && percent[0]>75){
		percentage = "wave75";
		percentagebg = "waveb75";
	}
	else if(percent[0]<=85 && percent[0]>80){
		percentage = "wave80";
		percentagebg = "waveb80";
	}
	else if(percent[0]<=90 && percent[0]>85){
		percentage = "wave85";
		percentagebg = "waveb85";
	}
	else if(percent[0]<95 && percent[0]>90){
		percentage = "wave90";
		percentagebg = "waveb90";
	}
	else if(percent[0]<100 && percent[0]>95){
		percentage = "wave95";
		percentagebg = "waveb95";
	}
	else if(percent[0]== 100){
		percentage = "wave100";
		percentagebg = "waveb100";
		power = "Charged";
	}
	$("#batt").html('<div id="circle-battery" class="'+percentage+'"><p>'+percent[0]+'%</p><p class="capt">'+power+'</p>'+image+'</div><div id="counter" class="'+percentagebg+'"></div>');

	},

  style: "        \n\
  top: -80px  \n\
  right: 280px  \n\
  "
