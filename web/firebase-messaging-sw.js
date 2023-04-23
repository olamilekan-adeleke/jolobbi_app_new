importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js"
);

firebase.initializeApp({
  appId: "1:754917959694:web:662b2aafc2802daf33f45f",
  authDomain: "jolobbi-food.firebaseapp.com",
  databaseURL: "...",
  projectId: "jolobbi-food",
  storageBucket: "jolobbi-food.appspot.com",
  messagingSenderId: "754917959694",
  appId: "1:754917959694:web:662b2aafc2802daf33f45f",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
