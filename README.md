fsmbuilder
==========

Finite State Machine builder. Design and build a Finite State Machine, then generate the code. AS3 / RobotLegs only right now.


Description
===========

Design
======

FSMBuilder allows a developer/designer/product manager to design the flow of an application, from start up, through different individual states and specfy which states are accesible from each states. These are known are "Transitions".

Code Generation
===============

Code is generated easily from the design, which can be viewed by clicking on the relevant tab. This code is generated via a "Writer" class, which implements the IWriter interface. It simply takes the FSMModel, and parses it.

Currently only Actionscript > Robotlegs > Enchanced FSM is supported. But any other FSM would be could be easily integrated.

