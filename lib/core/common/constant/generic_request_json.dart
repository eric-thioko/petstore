class GenericRequestJson {
  const GenericRequestJson._();

  static final classScheduleData = {
    "columns": [
      {"data": "id", "sortable": false, "searchable": false},
      // {"data": "class_type_name", "sortable": true, "searchable": true},
      {"data": "class_instructor_name", "sortable": true, "searchable": true},
      {"data": "class_date", "sortable": true, "searchable": true},
      {"data": "start_time", "sortable": true, "searchable": true},
      {"data": "end_time", "sortable": true, "searchable": true},
      {"data": "quota", "sortable": true, "searchable": true},
      {"data": "price", "sortable": true, "searchable": true},
    ],
    "order": {"column": "class_date", "dir": "asc"},
    "page": 1,
    "perPage": 10,
    // "filter": [
    //   {"column": "class_date", "value": "2025-05-01", "operator": "gte"},
    // ],
  };

  static final personalTrainerData = {
    "columns": [
      {"data": "id", "sortable": false, "searchable": false},
      {"data": "username", "sortable": true, "searchable": true},
      {"data": "name", "sortable": true, "searchable": true},
      {"data": "email", "sortable": true, "searchable": true},
      {"data": "role_name", "sortable": true, "searchable": true},
      {"data": "active", "sortable": true, "searchable": false},
      {"data": "bio", "sortable": false, "searchable": false},
      // {
      //   "data": "is_personal_trainer_of_member",
      //   "sortable": false,
      //   "searchable": false,
      // },
    ],
    // "order": {"column": "is_personal_trainer_of_member", "dir": "asc"},
    "page": 1,
    "perPage": 10,
    "filter": [
      {
        "column": "active_role_list",
        "value": "personal-trainer",
        "operator": "contains",
      },
    ],
  };

  static final reservationPtData = {
    "columns": [
      {"data": "id", "sortable": false, "searchable": false},
      {"data": "reservation_date", "sortable": true, "searchable": true},
      {"data": "start_time", "sortable": true, "searchable": true},
      {"data": "end_time", "sortable": true, "searchable": true},
      {"data": "member_name", "sortable": true, "searchable": true},
      {"data": "personal_trainer_name", "sortable": true, "searchable": true},
    ],
    // "order": {"column": "reservation_datetime", "dir": "asc"},
    "page": 1,
    "perPage": 10,
    // "filter": [
    //   {
    //     "column": "member_id",
    //     "value": "9a112381-044a-4b43-94f3-9ad83115e277",
    //     "operator": "eq",
    //   },
    // ],
  };

  static final leaveRequestData = {
    "columns": [
      {"data": "id", "sortable": false, "searchable": false},
      {"data": "member_name", "sortable": true, "searchable": true},
      {"data": "start_date", "sortable": true, "searchable": true},
      {"data": "end_date", "sortable": true, "searchable": true},
      {"data": "status", "sortable": true, "searchable": true},
      {"data": "description", "sortable": true, "searchable": true},
    ],
    // "filter": [
    //   {
    //     "column": "member_id",
    //     "value": "9a112381-044a-4b43-94f3-9ad83115e277",
    //     "operator": "eq",
    //   },
    // ],
    "page": 1,
    "perPage": 100,
  };

  static final classBookingData = {
    "columns": [
      {"data": "member_id"},
      {"data": "class_schedule_id"},
      {"data": "id"},
      {"data": "is_present"},
    ],
    "order": {"column": "id", "dir": "asc"},
    "filter": [
      {
        "column": "member_id",
        "value": "9a112381-044a-4b43-94f3-9ad83115e277",
        "operator": "eq",
      },
    ],
    "page": 1,
    "perPage": 10,
  };
}
