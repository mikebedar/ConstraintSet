### ***Contents***:
* #### ConstraintSet
A simple class to manage a set of `NSLayoutConstraint` instances; a set which can be activated, deactivated, or prioritized with a single command. This class is meant to be extended but can be useful on it's own, especially when the active state of an arbitrary sets of constraints needs to be toggled. Three subclasses add functionality for specific scenarios of constraining one view to another. 

* #### ViewEdgeConstraintSet
Adds named constraint properties to support constraining the sides of one view to another, with an optional inset. 

* #### ViewDimensionalConstraintSet
Adds named constraint properties to support constraining the size of one view to another, with an optional inset. 

* #### ViewCenteringConstraintSet
Adds named constraint properties to support constraining the center of one view to another, with an optional offset. 

* #### UIView Extension
Adds a set of convenience functions to automate constraining one view to another. For example, `pinEdgesToSuperView` will create a set of side constraints to the superview, if found, and return them as a `ViewEdgeConstraintSet`.

 ### ***Status***:
This represents a step toward formalizing a bit of utility code that I have been using in my personal projects for a good while now. It is certainly not a new idea, but over time I hope to grow this into a more robust library. 

