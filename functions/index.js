const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();



exports.sendReqNotification = functions.firestore.document('Requests/{reqId}')
    .onCreate(async (snap,context) => {
        //To take the doc Data, email, name, sender,reciever 
        const newValue = snap.data();
        //To log the progress in firbase cloud functions.
        functions.logger.log(
            'New req',
            newValue,

        );
        
        const receiverUid = newValue.receiverUid;
        const name = newValue.name;

        functions.logger.log(
            receiverUid,
            name,
           
        );

        //To get the fcm token for the reciever.
        await db.collection('Tokens').doc(receiverUid).get().then(async(snap) => {
            const token = snap.data();

            
            functions.logger.log(
                'user Token',
                token.fcm,
            );
    
            const payload = {
                notification: {
                    title: 'You have a new request!',
                    body: name + ' have sent you a request',
                  }
            };
            //To send the notification msg to the desired device ** FCM token
            await admin.messaging().sendToDevice(token.fcm,payload).then((res) => {
                
                functions.logger.log(
                    'sent!',
                );
                return;
            }).catch((e) => {
                functions.logger.log(
                    'Error sending the notification!',
                );
                
            });

        }).catch((e) => {
            functions.logger.log(
                'Fcm Token not found!',
            );
        });

       
    });


exports.chatNotifications = functions.firestore.document('Notifications/{notId}')
.onCreate(async(snap,context) => {
    const notification = snap.data();

    functions.logger.log(
        'New notification',
        notification,
    );
    const receiverUid = notification.receiverUid;
    functions.logger.log(
        'receiver UID',
        receiverUid,
    );

    const title = 'You have received new message';
    const body = notification.senderName + ' have sent you a message';

    
    await db.collection('Tokens').doc(receiverUid).get().then(async(tokenSnap) => {
        const token = tokenSnap.data();

        const payload = {
            notification: {
                title: title,
                body: body,
              }
        };

        functions.logger.log(
            'reveriver FCM',
            token.fcm,
        );

        
         try{
            await admin.messaging().sendToDevice(token.fcm,payload);
            functions.logger.log(
                'Notification sent!'
            );
            await db.collection('Notifications').doc(snap.id).delete();
            
        } catch(err){
                functions.logger.log(
                    'Notification faild!',
                    err,
                );
        }
        


    });

});


exports.locationUpdates = functions.firestore.document('LocationUpdates/{docId}').onCreate(async (snap,_) => {
    const notification = snap.data();

    functions.logger.log(
        'New notification',
        notification,
    );
    
    const receiverUid = notification.receiverUid;

    const name = notification.name;

    const title = "you have new location update";

    const body = name + " have sent you location update";


    await db.collection('Tokens').doc(receiverUid).get().then(async(tokenSnap) => {
        const token = tokenSnap.data();

        const payload = {
            notification: {
                title: title,
                body: body,
              }
        };

        functions.logger.log(
            'reveriver FCM',
            token.fcm,
        );

        
         try{
            await admin.messaging().sendToDevice(token.fcm,payload);
            functions.logger.log(
                'Notification sent!'
            );
            await db.collection('LocationUpdates').doc(snap.id).delete();
            
        } catch(err){
                functions.logger.log(
                    'Notification faild!',
                    err,
                );
        }
        


    });



} );


exports.emergencyNotifications = functions.firestore.document('Emergency/{notId}').onCreate(async (snap,context) => {
    const notification = snap.data();

    functions.logger.log(
        'New notification',
        notification,
    );
    const receiverUid = notification.receiverUid;
    functions.logger.log(
        'receiver UID',
        receiverUid,
    );
    const mode = notification.mode;
    const name = notification.name;

    const title = name + " have an emergency";

    let body = "";

    if(mode == "call me"){
        body = name + " needs to be called";
    } else {
        body = name + " can't find his way home";
    }

    await db.collection('Tokens').doc(receiverUid).get().then(async(tokenSnap) => {
        const token = tokenSnap.data();

        const payload = {
            notification: {
                title: title,
                body: body,
              }
        };

        functions.logger.log(
            'reveriver FCM',
            token.fcm,
        );

        
         try{
            await admin.messaging().sendToDevice(token.fcm,payload);
            functions.logger.log(
                'Notification sent!'
            );
            await db.collection('Emergency').doc(snap.id).delete();
            
        } catch(err){
                functions.logger.log(
                    'Notification faild!',
                    err,
                );
        }
        


    });

    


});

exports.scheduledNotifications = functions.pubsub.schedule('* * * * *').timeZone('Asia/Amman').onRun(async(contxt) => {
    const query = await db.collection('scheduledNotifications').where('time','<=',admin.firestore.Timestamp.now()).get();

    query.forEach(async snapshot => {
        const name = snapshot.data().name;
        const date = snapshot.data().time.toDate();
        if(snapshot.data().mode == 'To Do'){
            
            await sendNotification(snapshot.data().receiverUid,'You have a '+ name +' to do!','Don\'t forget to do your tasks!');
            await db.collection('scheduledNotifications').doc(snapshot.id).delete();

        } else{
            try{
                let newDate = new Date();
                newDate.setDate(date.getDate() +1 );
                functions.logger.log(
                    newDate.getDate(),
                );
                await sendNotification(snapshot.data().receiverUid,'You have a '+ name +' to take','Don\'t forget to take your drugs!');
                await db.collection('scheduledNotifications').doc(snapshot.id).set({'time':newDate},{ merge: true });
            } catch(err){
                functions.logger.log(
                    err,
                );
            }

        }
    });

    async function sendNotification(userUid,title,body){
        await db.collection('Tokens').doc(userUid).get().then(async(tokenSnap) => {
            const token = tokenSnap.data();
    
            const payload = {
                notification: {
                    title: title,
                    body: body,
                  }
            };
    
            functions.logger.log(
                'reveriver FCM',
                token.fcm,
            );
    
            
             try{
                await admin.messaging().sendToDevice(token.fcm,payload);
                functions.logger.log(
                    'Notification sent!'
                );
               
                
            } catch(err){
                    functions.logger.log(
                        'Notification faild!',
                        err,
                    );
            }
            
    
    
        });
    }

});

