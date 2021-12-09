CREATE OR REPLACE DIRECTORY IMAGES AS 'C:\Users\yuli_\Documents\carlos\BD\proyecto\media\images';
CREATE OR REPLACE DIRECTORY VIDEOS AS 'C:\Users\yuli_\Documents\carlos\BD\proyecto\media\videos';
GRANT READ, WRITE ON DIRECTORY IMAGES TO system;
GRANT READ, WRITE ON DIRECTORY VIDEOS TO system;
