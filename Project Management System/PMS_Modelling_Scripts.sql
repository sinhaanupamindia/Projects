create schema modelling;
use modelling;


CREATE TABLE Company
(
  Name INT NOT NULL,
  Company_Id INT NOT NULL,
  Website INT NOT NULL,
  PRIMARY KEY (Company_Id)
);

CREATE TABLE Project_Member
(
  Project_member_id INT NOT NULL,
  Project_member_name INT NOT NULL,
  PRIMARY KEY (Project_member_id)
);

CREATE TABLE Department
(
  dept_name INT NOT NULL,
  dept_id INT NOT NULL,
  dept_location INT NOT NULL,
  Company_Id INT NOT NULL,
  PRIMARY KEY (dept_id),
  FOREIGN KEY (Company_Id) REFERENCES Company(Company_Id)
);

CREATE TABLE Company_Email_Id
(
  Email_Id INT NOT NULL,
  Company_Id INT NOT NULL,
  PRIMARY KEY (Email_Id, Company_Id),
  FOREIGN KEY (Company_Id) REFERENCES Company(Company_Id)
);

CREATE TABLE Company_Contact_No
(
  Contact_No INT NOT NULL,
  Company_Id INT NOT NULL,
  PRIMARY KEY (Contact_No, Company_Id),
  FOREIGN KEY (Company_Id) REFERENCES Company(Company_Id)
);

CREATE TABLE Project_Member_Project_member_contact
(
  Project_member_contact INT NOT NULL,
  Project_member_id INT NOT NULL,
  PRIMARY KEY (Project_member_contact, Project_member_id),
  FOREIGN KEY (Project_member_id) REFERENCES Project_Member(Project_member_id)
);

CREATE TABLE Project_Member_project_member_email
(
  project_member_email INT NOT NULL,
  Project_member_id INT NOT NULL,
  PRIMARY KEY (project_member_email, Project_member_id),
  FOREIGN KEY (Project_member_id) REFERENCES Project_Member(Project_member_id)
);

CREATE TABLE Project
(
  Project_id INT NOT NULL,
  Project_name INT NOT NULL,
  Start_date INT NOT NULL,
  End_date INT NOT NULL,
  dept_id INT NOT NULL,
  PRIMARY KEY (Project_id),
  FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Project_Category
(
  Category_id INT NOT NULL,
  Category_name INT NOT NULL,
  c_description INT NOT NULL,
  Project_id INT NOT NULL,
  PRIMARY KEY (Category_id, Project_id),
  FOREIGN KEY (Project_id) REFERENCES Project(Project_id)
);

CREATE TABLE Project_Manager
(
  PM_id INT NOT NULL,
  PM_name INT NOT NULL,
  Project_id INT NOT NULL,
  PRIMARY KEY (PM_id),
  FOREIGN KEY (Project_id) REFERENCES Project(Project_id)
);

CREATE TABLE Project_Update
(
  Update_id INT NOT NULL,
  Date_of_update INT NOT NULL,
  Description_of_update INT NOT NULL,
  Project_id INT NOT NULL,
  PRIMARY KEY (Project_id),
  FOREIGN KEY (Project_id) REFERENCES Project(Project_id)
);

CREATE TABLE Project_task
(
  task_id INT NOT NULL,
  task_details INT NOT NULL,
  Project_id INT NOT NULL,
  PRIMARY KEY (task_id, Project_id),
  FOREIGN KEY (Project_id) REFERENCES Project(Project_id)
);

CREATE TABLE done_by
(
  task_id INT NOT NULL,
  Project_id INT NOT NULL,
  Project_member_id INT NOT NULL,
  PRIMARY KEY (task_id, Project_id, Project_member_id),
  FOREIGN KEY (task_id, Project_id) REFERENCES Project_task(task_id, Project_id),
  FOREIGN KEY (Project_member_id) REFERENCES Project_Member(Project_member_id)
);

CREATE TABLE gives
(
  Project_member_id INT NOT NULL,
  Project_id INT NOT NULL,
  PRIMARY KEY (Project_member_id, Project_id),
  FOREIGN KEY (Project_member_id) REFERENCES Project_Member(Project_member_id),
  FOREIGN KEY (Project_id) REFERENCES Project_Update(Project_id)
);

CREATE TABLE Project_Manager_PM_contact_no
(
  PM_contact_no INT NOT NULL,
  PM_id INT NOT NULL,
  PRIMARY KEY (PM_contact_no, PM_id),
  FOREIGN KEY (PM_id) REFERENCES Project_Manager(PM_id)
);

CREATE TABLE Project_Manager_PM_Email_id
(
  PM_Email_id INT NOT NULL,
  PM_id INT NOT NULL,
  PRIMARY KEY (PM_Email_id, PM_id),
  FOREIGN KEY (PM_id) REFERENCES Project_Manager(PM_id)
);