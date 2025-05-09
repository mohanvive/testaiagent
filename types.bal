type Doctor record {
    string name;
    string time;
    string hospital;
};

type DoctorsList record {
    Doctor[] doctor;
};

type DoctorsResponse record {
    DoctorsList doctors;
};

type PineValleyRequest record {
    string doctorType;
};