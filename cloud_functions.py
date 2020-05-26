# Add to requirements.txt the dependencies
# flask==1.1.2
# firebase-admin==4.3.0

import json
import firebase_admin as admin
import firebase_admin.messaging as messaging


# [START notify_helpers]

# Init Firebase
try:
    admin.initialize_app()
    print('admin initialized')
except Exception as ex:
    print('Cant initialized admin')


def notify_helpers(data, context):
    """ Triggered by a change to a Firestore document.
    Args:
        data (dict): The event payload.
        context (google.cloud.functions.Context): Metadata for the event.
    """
    # trigger_resource = context.resource  
    try:
        new_call = data['value']['fields']
        curr_topic = new_call['topic']['stringValue']
        print('/topics/' + curr_topic)

        # See documentation on defining a message payload.
        notification_body = new_call['caller']['stringValue'] + ' קרא/ה לעזרה, הכנס/י לקבלת פרטים נוספים'
        my_notification = messaging.Notification(
            title='קריאה חדשה לעזרה',
            body=notification_body,
        )

        print(my_notification)

        message = messaging.Message(
            data={
                'caller': 'new_call['caller']['stringValue']',
                'topic': new_call['topic']['stringValue'],
            },
            notification=my_notification,
            topic=curr_topic,
        )

        # Send a message to the devices subscribed to the provided topic.
        response = messaging.send(message)
        # Response is a message ID string.
        print('Successfully sent message:', response)
    except Exception as ex:
        print('Helpers Notify Failed!!\nError:', ex)
# [END notify_helpers]
