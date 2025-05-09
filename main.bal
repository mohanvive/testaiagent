import ballerina/http;
import ballerinax/ai;

service /healthcare on new http:Listener(8290) {
    resource function get doctors/[string doctorType]() returns Doctor[]|error {
        Doctor[] doctors = [];

        // Call PineValley backend
        PineValleyRequest payload = {doctorType: doctorType};
        DoctorsResponse pineValleyResponse = check pineValleyEp->post("/doctors", message = payload, headers = {"Content-Type":"application/json"});
        doctors.push(...pineValleyResponse.doctors.doctor);

        // Call GrandOak backend
        DoctorsResponse grandOakResponse = check grandOakEp->get("/doctors/" + doctorType);
        doctors.push(...grandOakResponse.doctors.doctor);

        return doctors;
    }
}

service /DoctorBookingAgent on new ai:Listener(9100) {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {

        string stringResult = check _DoctorBookingAgent->run(request.message, request.sessionId);
        return {message: stringResult};
    }
}
