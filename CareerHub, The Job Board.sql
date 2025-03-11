CREATE DATABASE CareerHub;
USE CareerHub;

CREATE TABLE companies (
    CompanyID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyName VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL
);

INSERT INTO companies (CompanyName, Location) VALUES
('TCS', 'Mumbai'),
('Infosys', 'Bangalore'),
('Wipro', 'Hyderabad'),
('HCL', 'Chennai'),
('Tech Mahindra', 'Pune');

SELECT * FROM companies;

CREATE TABLE jobs (
    JobID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyID INT,
    JobTitle VARCHAR(255) NOT NULL,
    JobDescription TEXT,
    JobLocation VARCHAR(255),
    Salary DECIMAL(10,2) CHECK (Salary >= 0),
    JobType ENUM('Full-time', 'Part-time', 'Contract'),
    PostedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CompanyID) REFERENCES companies(CompanyID) ON DELETE CASCADE
);

INSERT INTO jobs (CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate) VALUES
(1, 'Software Engineer', 'Develop and maintain Java applications.', 'Mumbai', 800000, 'Full-time', NOW()),
(2, 'Data Analyst', 'Analyze business data for insights.', 'Bangalore', 700000, 'Full-time', NOW()),
(3, 'System Administrator', 'Manage IT infrastructure and security.', 'Hyderabad', 600000, 'Full-time', NOW()),
(4, 'Cloud Engineer', 'Deploy and maintain cloud solutions.', 'Chennai', 900000, 'Full-time', NOW()),
(5, 'AI/ML Engineer', 'Develop AI models for business applications.', 'Pune', 1200000, 'Full-time', NOW());

SELECT * FROM jobs;

CREATE TABLE applicants (
    ApplicantID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(20) UNIQUE NOT NULL,
    Resume TEXT
);

INSERT INTO Applicants (FirstName, LastName, Email, Phone, Resume) VALUES
('Amit', 'Sharma', 'amit.sharma@gmail.com', '9876543210', 'Experienced Java Developer'),
('Priya', 'Rao', 'priya.rao@gmail.com', '9876543211', 'Data Analyst with expertise in Python'),
('Rahul', 'Verma', 'rahul.verma@gmail.com', '9876543212', 'IT Administrator with network security skills'),
('Sneha', 'Patil', 'sneha.patil@gmail.com', '9876543213', 'Cloud Engineer with AWS and Azure expertise'),
('Vikram', 'Singh', 'vikram.singh@gmail.com', '9876543214', 'AI/ML Engineer with deep learning specialization');
INSERT INTO Applicants (FirstName, LastName, Email, Phone, Resume) 
VALUES ('Rohan', 'Gupta', 'rohan.gupta@gmail.com', '9876543215', 'Experienced Full Stack Developer');

SELECT * FROM applicants;

CREATE TABLE applications (
    ApplicationID INT PRIMARY KEY AUTO_INCREMENT,
    JobID INT,
    ApplicantID INT,
    ApplicationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    CoverLetter TEXT,
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID) ON DELETE CASCADE,
    FOREIGN KEY (ApplicantID) REFERENCES applicants(ApplicantID) ON DELETE CASCADE
);

INSERT INTO Applications (JobID, ApplicantID, ApplicationDate, CoverLetter) VALUES
(1, 1, NOW(), 'I am an experienced Java Developer applying for this role.'),
(2, 2, NOW(), 'I have strong analytical skills and am interested in this role.'),
(3, 3, NOW(), 'I have extensive experience in IT infrastructure.'),
(4, 4, NOW(), 'I am passionate about cloud computing and wish to contribute to your team.'),
(5, 5, NOW(), 'I have experience in AI and deep learning, and I am excited about this opportunity.');

SELECT * FROM applicants;

SELECT COUNT(ApplicationID), JobTitle
FROM jobs j
LEFT OUTER join applications a
ON j.JobID = a.JobID
GROUP BY j.JobTitle;

SELECT JobTitle, CompanyName, Location, Salary
FROM jobs j
LEFT OUTER JOIN companies c
ON j.CompanyID = c.CompanyID
WHERE j.salary BETWEEN  700000 AND  900000;

SELECT j.JobTitle, c.CompanyName, a.ApplicationDate
FROM applications a
JOIN jobs j
ON j.JobID = a.JobID
JOIN companies c
ON c.CompanyID = j.CompanyID
WHERE a.ApplicationID = 2;

SELECT AVG(Salary)
FROM jobs
WHERE salary > 0;

SELECT CompanyName, Count(JobID)
FROM companies c
JOIN jobs j 
ON c.CompanyID = j.CompanyID
GROUP BY CompanyName;

SELECT a.ApplicantID, a.FirstName, a.LastName, a.Email
FROM applicants a
JOIN applications ap ON a.ApplicantID = ap.ApplicantID
JOIN jobs j ON j.JobID = ap.JobID
JOIN companies c ON c.CompanyID = j.CompanyID
WHERE c.Location = 'Mumbai';

SELECT DISTINCT JobTitle, Salary
FROM jobs
WHERE Salary BETWEEN 600000 AND 800000;

SELECT j.JobTitle
FROM jobs j
JOIN applications a ON j.JobID = a.JobID
WHERE a.ApplicationID IS NULL;

SELECT a.ApplicantID, a.FirstName, a.LastName, a.Email, c.CompanyName, j.JobTitle
FROM applicants a
JOIN applications ap ON ap.ApplicantID = a.ApplicantID
JOIN jobs j ON ap.JobID = j.JobID
JOIN companies c ON j.CompanyID = c.CompanyID;

SELECT a.ApplicantID, a.FirstName, a.LastName, a.Email, c.CompanyName, j.JobTitle
FROM applicants a
LEFT JOIN applications ap ON ap.ApplicantID = a.ApplicantID
LEFT JOIN jobs j ON ap.JobID = j.JobID
LEFT JOIN companies c ON j.CompanyID = c.CompanyID;

SELECT DISTINCT c.CompanyName, j.salary
FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
WHERE j.Salary > (SELECT AVG(Salary) FROM Jobs);

SELECT CONCAT(Firstname, ' ', LastName) AS FullName
FROM Applicants;

SELECT JobTitle, JobDescription,JobLocation, Salary
FROM jobs
WHERE JobTitle LIKE '%Engineer%' OR JobTitle LIKE '%Developer%';

SELECT a.FirstName, a.LastName, j.JobTitle
FROM Applicants a
LEFT JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
LEFT JOIN Jobs j ON ap.JobID = j.JobID;

SELECT a.FirstName, a.LastName, c.CompanyName
FROM Applicants a, Companies c
WHERE c.Location = 'Chennai';