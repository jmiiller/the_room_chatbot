% Basic NLP structure and chatbot process
% based on Poole and Mackworth's "Artificial Intelligence 2E: Foundations of Computational Agents"

% question([is|L0],Ind) :- noun_phrase(L0,L1,Ind),mp(L1,[],Ind).
% question([who,is|L0],Ind) :- mp(L0,[],Ind).
% question([who,is|L],Ind) :- noun_phrase(L,[],Ind).
% question([who,is|L],Ind) :- adjectives(L,[],Ind).
% question([which|L0],Ind) :- noun_phrase(L0,[is|L1],Ind),mp(L1,[],Ind).

%ask(Q,A) :- question(Q,[],A).
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

parsenoun(Input,Ans) :- s(Tree,Input,[]), search(Tree,Ans).

search(s(np(_,n(N)),_), N) :- dif(N,'I').
search(s(np(n(N)),_), N) :- dif(N,'I').
search(s(np(n(N))), N) :- dif(N,'I').
search(s(_,vp(_,NP)),N) :- search(NP,N).
search(np(_,n(N)),N) :- dif(N,'I').
search(np(n(N)),N) :- dif(N,'I').

lex(the, det).
lex(a, det).
lex(woman, n).
lex(man, n).
lex(boy, n).
lex(girl, n).
lex(person, n).
lex(i, n).
lex(football, n).
lex(building, n).
lex(phone, n).
lex(sex, n).
lex(fiance, n).
lex(girlfriend, n).
lex(boyfriend, n).
lex(husband, n).
lex(wife, n).
lex(money, n).
lex(yes,n).
lex(no,n).
lex(shoots, v).
lex(is, v).
lex(love, v).
% lex(shoots, v) :- shoot.
% lex(shoots, v) :- shot.
% lex(cheat, v) :- cheat.
% lex(cheat, v) :- cheated.
% lex(cheat, v) :- cheats.
% lex(betray, v) :- betray.
% lex(betray, v) :- betrays.
% lex(betray, v) :- betrayed.
