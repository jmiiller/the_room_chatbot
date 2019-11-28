% This file inclues all of our code that handles the natural language processing aspect of the chatbot.

% Definite Context Grammar used to define the Context Free Grammar accepted by our program.
% We accept three kinds of sentences: a single noun phrase, a single verb phrase, and a noun phrase followed by a verb phrase.
s(s(NP,VP))  -->  np(NP),vp(VP).
s(s(NP))  -->  np(NP).
s(s(VP))  -->  vp(VP).

np(np(DET,N))  -->  det(DET),n(N).
np(np(N))  -->  n(N).

vp(vp(V,NP))  -->  v(V),np(NP).
vp(vp(V))  -->  v(V).

det(det(Word)) --> [Word], {lex(Word, det)}.
n(n(Word)) --> [Word], {lex(Word, n)}.
v(v(Word)) --> [Word], {lex(Word, v)}.

% Searches for a noun in the parse tree generated by the definite clause grammar clauses.
% In this case, we successfully found the noun.
search_input(Input,_, Ans) :- parsenoun(Input, Ans).

% In this case, we are unable to find the noun. Thus, we print a randomized error message and then
% return to the previously asked question.
search_input(Input, State, Ans) :-
   \+ parsenoun(Input, Ans),
   nl,
   random_between(1, 10, Random),
   error_messages(Random, ErrorMsg),
   write(ErrorMsg),
   nl, nl,
   write("I did not understand what you said!"),
   nl,nl,
   gather_data(State).

% To search for a noun, first generate the parse tree of the supplied input, then search for the noun in the tree.
parsenoun(Input,Ans) :- s(Tree,Input,[]), search_noun(Tree,Ans).

% Search for the noun in the different types of possible sentences generated by the Definite Context Grammar.
search_noun(s(np(_,n(N)),_), N) :- dif(N,'I'), dif(N,'How'), dif(N,'Who'), dif(N,'Where'), dif(N,'How'), dif(N,'Why').
search_noun(s(np(n(N)),_), N) :- dif(N,'I'), dif(N,'How'), dif(N,'Who'), dif(N,'Where'), dif(N,'How'), dif(N,'Why').
search_noun(s(np(n(N))), N) :- dif(N,'I'), dif(N,'How'), dif(N,'Who'), dif(N,'Where'), dif(N,'How'), dif(N,'Why').
search_noun(s(_,vp(_,NP)),N) :- search_noun(NP,N).
search_noun(np(_,n(N)),N) :- dif(N,'I'), dif(N,'How'), dif(N,'Who'), dif(N,'Where'), dif(N,'How'), dif(N,'Why').
search_noun(np(n(N)),N) :- dif(N,'I'), dif(N,'How'), dif(N,'Who'), dif(N,'Where'), dif(N,'How'), dif(N,'Why').
search_noun(vp(_,n(N)),N) :- dif(N,'I'), dif(N,'How'), dif(N,'Who'), dif(N,'Where'), dif(N,'How'), dif(N,'Why').
search_noun(vp(_,NP),N) :- search_noun(NP,N).

% Used for the chat at the end. Parse input for commands. Return identifier that signifies which command
% has been entered.
parse_input([bye|_],_,bye).
parse_input([quit|_],_,quit).
parse_input([help|_],_,help).
parse_input([how,are,you|_],_,how_are_you).
parse_input(Input,Object,Ans) :-
    s(Tree,Input,[]),
    search_content(Tree,Ans),
    search_noun(Tree,Object).
parse_input(_, _, error).



% search_content(s(np(_,n(how)),vp(are,np(_,n(you)))), how_are_you).
% search_content(s(np(_,n(how)),vp(are,np(n(you)))), how_are_you).
% search_content(s(np(n(how)),vp(are,np(n(you)))), how_are_you).
% search_content(s(np(n(how)),vp(are,np(_,n(you)))), how_are_you).
% search_content(s(np(n('How')),vp(are,np(n(you)))), how_are_you).
% search_content(s(np(n('How')),vp(are,np(_,n(you)))), how_are_you).
% search_content(s(np(_,n(how)),vp(are,np(_,n(things)))), how_are_you).
% search_content(s(np(_,n(how)),vp(are,np(n(things)))), how_are_you).
% search_content(s(np(n('How')),vp(are,np(n(things)))), how_are_you).
% search_content(s(np(n('How')),vp(are,np(_,n(things)))), how_are_you).

% search_content(s(vp('Tell'),_), tell_me).
% search_content(s(_,vp(v(tell),_)), tell_me).

% search_content(s(np(_,n(who)),vp(is,_)), who_is).
% search_content(s(np(_,n(who)),vp(is,_)), who_is).
% search_content(s(np(n('Who')),vp(is,_)), who_is).
% search_content(s(np(n('Who')),vp(is,_)), who_is).

% The lexicon of all the words accepted by our chat bot.
% Each lex entrie includes the word and its type.
lex(the, det).
lex('The', det).
lex(a, det).
lex('Who', n).
lex('What', n).
lex('Where', n).
lex('When', n).
lex('Why', n).
lex('How', n).
lex(who, n).
lex(what, n).
lex(where, n).
lex(when, n).
lex(why, n).
lex(how, n).
lex(woman, n).
lex(man, n).
lex(boy, n).
lex(girl, n).
lex(person, n).
lex(i, n).
lex('I', n).
lex(football, n).
lex(soccer, n).
lex(volleyball, n).
lex(hockey, n).
lex(basketball, n).
lex(lacrosse, n).
lex(bowling, n).
lex(chess, n).
lex(swimming, n).
lex(lifting, n).
lex(wrestling, n).
lex(tennis, n).
lex(polo, n).
lex(curling, n).
lex(rugby, n).
lex(hacking, n).
lex(hunting, n).
lex(soccer, n).
lex(building, n).
lex(house, n).
lex(apartment, n).
lex(cellphone, n).
lex(phone, n).
lex(sex, n).
lex(fiance, n).
lex(girlfriend, n).
lex(boyfriend, n).
lex(husband, n).
lex(wife, n).
lex(money, n).
lex(yes,n).
lex('Yes',n).
lex(yeah, n).
lex('Yeah', n).
lex(yep, n).
lex(no,n).
lex('No', n).
lex(nah,n).
lex(never, n).
lex('Never', n).
lex(nope, n).
lex(things,n).
lex(thing, n).
lex(bye, n).
lex(goodbye, n).
lex(quit, n).
lex(help, n).
lex(shoots, v).
lex(is, v).
lex('Is', v).
lex(are, v).
lex('Are', v).
lex(am, v).
lex('Am', v).
lex(was, v).
lex(love, v).
lex(like, v).
lex(adore, v).
lex(would, v).
lex(will, v).
lex(do, v).
lex(does, v).
lex(did, v).
lex(tell, v).
lex(can, v).
lex('Tell', v).
lex('Can', v).
