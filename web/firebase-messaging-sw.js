importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyDSOogazoVC3eV9K6WV1hVumYyRHumVexM",
        authDomain: "bigmart-7be63.firebaseapp.com",
        projectId: "bigmart-7be63",
        storageBucket: "bigmart-7be63.appspot.com",
        messagingSenderId: "217504743824",
        appId: "1:217504743824:web:14895edea64bf462517315",
        measurementId: "G-M7GK4Q2FQG"
});
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});