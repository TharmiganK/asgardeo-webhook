import ballerinax/trigger.asgardeo;
import ballerina/http;
import ballerina/log;

configurable asgardeo:ListenerConfig config = ?;

listener http:Listener httpListener = new(8090);
listener asgardeo:Listener webhookListener =  new(config,httpListener);

service asgardeo:RegistrationService on webhookListener {
  
    remote function onAddUser(asgardeo:AddUserEvent event ) returns error? {
      log:printInfo("Add user : " + event.toJsonString());
    }
    remote function onConfirmSelfSignup(asgardeo:GenericEvent event ) returns error? {
      log:printInfo("Confirm self signup : " + event.toJsonString());
    }
    remote function onAcceptUserInvite(asgardeo:GenericEvent event ) returns error? {
      log:printInfo("Accept user invite : " + event.toJsonString());
    }
}

service asgardeo:UserOperationService on webhookListener {

    remote function onDeleteUser(asgardeo:GenericEvent event) returns error? {
      log:printInfo("Delete user : " + event.toJsonString());
    }

    remote function onLockUser(asgardeo:GenericEvent event) returns error? {
      log:printInfo("Lock user : " + event.toJsonString());
    }

    remote function onUnlockUser(asgardeo:GenericEvent event) returns error? {
      log:printInfo("Unlock user : " + event.toJsonString());
    }

    remote function onUpdateUserCredentials(asgardeo:GenericEvent event) returns error? {
      log:printInfo("Update user credentials : " + event.toJsonString());
    }

    remote function onUpdateUserGroup(asgardeo:UserGroupUpdateEvent event) returns error? {
      log:printInfo("Update user group : " + event.toJsonString());
    }
}

service /ignore on httpListener {}
