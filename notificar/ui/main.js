let notificationsArray = [];
let loopingStarted = false;
var idplayer = 0;
window.addEventListener('message', (event) => {
  if (event.data.type === 'open') {
    if(event.data.id){
      idplayer = event.data.id
    }
    appendNotification('notificationsContainer', event.data.job, event.data.msg)
  }
});

function appendNotification(containerId, type, message){

  if(message.length >= 75){
    $.post(`https://Thedoc_JobNotifications/limitexceded`, JSON.stringify({
      id: idplayer
    })); return;
  }

  notificationsArray.push({type: type, message: message});
  if(!loopingStarted){
    startNotificationsLoop(containerId);
    loopingStarted = true;
  }  
}

function startNotificationsLoop(containerId){  
  if(notificationsArray.length != 0){
    let lastAdminNotificationIndex = -1;
    let hasAdminNotification = notificationsArray.filter((notification, notificationIndex) => {
      if(notification.type == "admin"){ lastAdminNotificationIndex = notificationIndex; return true; }
      else{ return false; }
    }).length != 0;
    
    let lastNotification;
    if(!hasAdminNotification){ lastNotification = notificationsArray.splice(0, 1)[0]; }
    else{ lastNotification = notificationsArray.splice(lastAdminNotificationIndex, 1)[0]; }
    
    let notificationsContainer = document.getElementById(containerId);
    let notificationContainer = createNotification(lastNotification.type, lastNotification.message);
    notificationsContainer.appendChild(notificationContainer);
    
    let fullTextWidth = document.querySelector(".notification-message").offsetWidth*1.09 + 20*window.innerWidth/1240;
    console.log(fullTextWidth);
    document.querySelector(":root").style.setProperty('--fullWidth', fullTextWidth + "px");
    
    setTimeout(function(){
      this.classList.toggle("slideDown");
      this.classList.toggle("slideUp");
      this.getElementsByClassName("notification-message-container")[0].classList.toggle("shrinkLeft");
      this.getElementsByClassName("notification-message-container")[0].classList.toggle("growRight");
    }.bind(notificationContainer), 12000);

    setTimeout(function(){
      this.innerHTML = "";
      startNotificationsLoop(containerId);
    }.bind(notificationsContainer), 16000);

  }else{
    loopingStarted = false;    
  }
}

function createNotification(type, message){
  let classInfo = getClassInfo(type);

  let notificationContainer = document.createElement("div");
  notificationContainer.classList.value = "notification-container slideDown";
  let notificationIconContainer = document.createElement("div");
  notificationIconContainer.classList.add("notification-icon-container");
  let notificationMessageContainer = document.createElement("div");
  notificationMessageContainer.classList.value = "notification-message-container shrinkLeft";

  let notificationIcon;
  if(classInfo.iconType == "icon"){
    notificationIcon = document.createElement("i");
    notificationIcon.classList.value = 'notification-icon fa-solid ' + classInfo.className;
  }else if(classInfo.iconType == "image"){
    notificationIconContainer.style.backgroundColor = "transparent";
    notificationIconContainer.style.border = "0";
    notificationIconContainer.style.boxShadow = "none";
    notificationContainer.style.flexDirection = "column";
    notificationMessageContainer.style.borderLeft = "solid 0.2vw #181818c0";
    notificationMessageContainer.style.left = "0";
    //notificationMessageContainer.style.top = "-0.3vw";
    notificationMessageContainer.style.borderRadius = "0.4vw";
    notificationIcon = document.createElement("img");
    notificationIcon.classList.add("notification-icon-image");
    notificationIcon.src = classInfo.iconSrc;
  }
  let notificationMessage = document.createElement("p");
  notificationMessage.classList.add("notification-message");
  notificationMessage.innerText = message;

  notificationIconContainer.appendChild(notificationIcon);
  notificationMessageContainer.appendChild(notificationMessage);
  notificationContainer.appendChild(notificationIconContainer);
  notificationContainer.appendChild(notificationMessageContainer);
  
  return notificationContainer;
}

function getClassInfo(type){
  let info = {
    className: "",
    iconType: "icon",
    iconSrc: ""
  }

  switch(type){
    
    case "police": info.iconType = "image"; info.iconSrc = "./images/lspd.png";
      break;
    case "ambulance": info.iconType = "image"; info.iconSrc = "./images/ems.png";
      break;
    case "burgershot": info.iconType = "image"; info.iconSrc = "./images/burgershot.png";
        break;
    case "mechanic": info.iconType = "image"; info.iconSrc = "./images/lsc.png";
      break;
    case "mechanic2": info.iconType = "image"; info.iconSrc = "./images/bennys.png";
      break; 
    case "admin": info.iconType = "image"; info.iconSrc = "./images/adminLogo.png";
      break;
  }

  return info;
}