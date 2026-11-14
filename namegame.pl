:- dynamic letter/1.





start :-

  retractall(letter(_)),

  assertz(letter(a)),

  assertz(letter(b)),

  assertz(letter(c)),

  nl,

  write('Hi. This is the "Name Game".'), nl,

  write('You will be given the letters a, b, and c.'), nl,

  menu.



menu :-

  nl,

  write('Choose from the following:'), nl,

  write('1- Display the current set of letters'), nl,

  write('2- Add a letter'), nl,

  write('3- Add a letter at the top'), nl,

  write('4- Add a letter at the bottom'), nl,

  write('5- Delete a letter'), nl,

  write('6- Delete all letters'), nl,

  write('7- Exit'), nl,

  write('Enter your choice: '),

  read(Choice),

  perform(Choice).



perform(1) :-

  !,

  display_letters,

  menu.

perform(2) :-

  !,

  get_letter(Letter),

  write('Where do you want to add it? (1 = top, 2 = bottom): '),

  read(Position),

  add_at_position(Position, Letter),

  menu.

perform(3) :-

  !,

  get_letter(Letter),

  asserta(letter(Letter)),

  write('Letter added at the top.'), nl,

  menu.

perform(4) :-

  !,

  get_letter(Letter),

  assertz(letter(Letter)),

  write('Letter added at the bottom.'), nl,

  menu.

perform(5) :-

  !,

  get_letter(Letter),

  ( retract(letter(Letter)) ->

    write('The first matching letter was deleted.'), nl

  ;

    write('The letter was not found.'), nl

  ),

  menu.

perform(6) :-

  !,

  retractall(letter(_)),

  write('All letters have been deleted.'), nl,

  menu.

perform(7) :-

  !,

  write('Goodbye!'), nl.

perform(_) :-

  write('Invalid choice. Please enter a number from 1 to 7.'), nl,

  menu.



display_letters :-

  findall(Letter, letter(Letter), Letters),

  write('Current letters: '),

  write(Letters), nl.



get_letter(Letter) :-

  write('Enter a letter (a, b, or c): '),

  read(Letter),

  ( member(Letter, [a, b, c]) ->

    true

  ;

    write('Invalid letter. Please enter a, b, or c.'), nl,

    get_letter(Letter)

  ).



add_at_position(1, Letter) :-

  !,

  asserta(letter(Letter)),

  write('Letter added at the top.'), nl.

add_at_position(2, Letter) :-

  !,

  assertz(letter(Letter)),

  write('Letter added at the bottom.'), nl.

add_at_position(_, Letter) :-

  write('Invalid position. Letter added at the bottom.'), nl,

  assertz(letter(Letter)