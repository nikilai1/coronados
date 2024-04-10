
const app = new Vue({
  el: '#app',
  data: {
    LastIndex: 0,
    SColor:{R:null, G:null, B:null},
    BColor:0,
    Class:null,
    ui:false,
    vehicles:[],
    color:[],
    category:[],
    table:{
      trunk:'...',
      capacity:'70 LITERS',
      fuel:'6 LITERS',
      label:'NO SELECT',
      price:0,
      model:''
    },
    status:{
      speed:0,
      break:0,
      acceleration:0,
      control:0
    }
    },
  methods:{
    Category(i){
      let categories = {
        trunk: i.trunk + 'KG'
      }
      this.table.trunk = categories.trunk
      this.Class = i.name;
    },
    TestDrive(){
      $.post(`https://${GetParentResourceName()}/TestDrive`, JSON.stringify({car:this.table.model, color:this.SColor}));
      this.SColor = {};
    },
    BuyCar(){
      $.post(`https://${GetParentResourceName()}/Buy`, JSON.stringify({model:this.table.model, price:this.table.price, color:this.SColor}));
    },
    CarData(i){
      let cars = {
        color: i.model,
        model: i.model,
        label: i.label,
        price: i.price
      }
      this.BColor = cars.color;
      this.table.model = cars.model;
      this.table.price = cars.price;
      this.table.label = cars.label;
      let Refresh = {
        R: this.color[0].R,
        G: this.color[0].G,
        B: this.color[0].B
      }
      this.SColor = Refresh
      this.LastIndex = 0,
      $.post(`https://${GetParentResourceName()}/Delete`, JSON.stringify({}));
      $.post(`https://${GetParentResourceName()}/Vehicle`, JSON.stringify({vehicle:i.model, coords:this.table.coords, color:Refresh}), function(data){
      app.status.speed = (data.maxSpeed).toFixed(0)
      app.status.break = (data.Brake).toFixed(0)
      app.status.acceleration = (data.Acceleration).toFixed(0) 
      app.status.fuel = data.fuel
      app.status.control = (data.Handling).toFixed(0) 
      if (data.fuel == undefined) {
        data.fuel = Math.floor(Math.random() * 100);
      }
      app.table.capacity = (data.fuel +' LITERS ')
      })
    },
    Filter(type, data){
      let table = {
        R: this.color[this.LastIndex].R,
        G: this.color[this.LastIndex].G,
        B: this.color[this.LastIndex].B
      }
      this.SColor = table;
      this.LastIndex = data;
      $.post(`https://${GetParentResourceName()}/SelectColor`, JSON.stringify({color:table}));
    },
    FormatPrice(value) {
      let val = (value/1).toFixed(2).replace('.', ',')
      return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")
    },
    Position(type) {
      var base = document.querySelector('.color')
      if (type == 'left'){
        if (-1 < (this.LastIndex - 1)) {
          this.LastIndex = this.LastIndex - 1
          this.Filter(this.color[this.LastIndex],this.LastIndex)
          if (this.LastIndex < 7){
            base.scrollLeft = 1
          }
        }
      }
      if (type == 'right'){
        if (this.color.length > (this.LastIndex + 1)) {
          this.LastIndex = this.LastIndex + 1
          this.Filter(this.color[this.LastIndex],this.LastIndex)
          if (this.LastIndex > 6){
            base.scrollLeft = 507
          }
        }
      }
    },
  }
})

window.addEventListener('message', function (event) {
  var v = event.data;
  switch (v.type) {
  	case "ui":
  		app.color = v.color;
  		app.category = v.category;
  		app.vehicles = v.vehicle;
      app.CarData(v.vehicle[0]);
  		app.Class = app.vehicles[0].category;
      app.SColor = v.color[0];
  		app.table.trunk = app.category[0].trunk + 'KG';
  		app.ui = true;
  		break
  	case "close":
  		app.ui = false,
  			$.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
  		break
  }
})

let holding = false
let direction = "", oldx = 0
document.addEventListener('mousedown', (e) => holding = true)
document.addEventListener('mouseup', (e) => holding = false)
document.addEventListener('mousemove', function(e) {
  if (e.pageX < oldx) { direction = "left" } else if (e.pageX > oldx) { direction = "right" }
  oldx = e.pageX;
  if (direction == "left" && holding) {
    if (e.target.classList.contains("move")) {
      $.post(`https://${GetParentResourceName()}/rotateright`);
    }
  }
  if (direction == "right" && holding) {
    if (e.target.classList.contains("move")) {
      $.post(`https://${GetParentResourceName()}/rotateleft`);
    }
  }

});


document.onkeyup = function (data) {
  if (data.which == 27) {
    app.ui = false,
    $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
  }
};

