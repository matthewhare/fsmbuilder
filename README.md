Finite State Machine(FSM) Builder 
=================================

[![Build Status](https://buildhive.cloudbees.com/job/matthewhare/job/fsmbuilder/badge/icon)](https://buildhive.cloudbees.com/job/matthewhare/job/fsmbuilder/)

Finite State Machine builder. Design and build a Finite State Machine, then generate the code directly to the project.

The app detects which framework you the project is using, and builds the code specificially for that framework.

More changes for pull request demo


***Objectives***

Below are listed the fundemental objectives.

- create or update an existing MVC(S) project in a given language + framwork
- create state machine for it
- design and edit state machine logic
- access the source of the project, for assistance to the user
- generate code for project
- allow open source development to add support for other languages + frameworks

The GUI must be able to create and reference exising commands, that the state machine calls.

***Initial Application***

The initial GUI will be built to harness ActionScript, and Robotlegs state machines.


***Design***


FSMBuilder allows a developer/product manager to design the flow of an application, from "startup", through different other individual states and specify which states are accessable to them. These are known are "Transitions".

***Code Generation***

Code is generated easily from the design, which can be viewed by clicking on the relevant tab. This code is generated via a "Writer" class, which implements the IWriter interface. It simply takes the FSMModel, and parses it.

Currently only Actionscript > Robotlegs > Enchanced FSM is supported. But any other FSM would be could be easily integrated.

