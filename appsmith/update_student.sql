UPDATE students
SET 
  school_name = '{{Input1.text}}',
  class = {{Input2.text}},
  section = '{{Input3.text}}',
  student_name = '{{Input4.text}}',
  roll_number = '{{Input5.text}}'
WHERE id = {{Table1.selectedRow.id}};
