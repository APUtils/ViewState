# Change Log
All notable changes to this project will be documented in this file.
`ViewState` adheres to [Semantic Versioning](http://semver.org/).


## [2.0.0](https://github.com/APUtils/ViewState/releases/tag/2.0.0)
Released on `2023-01-30`

#### Added
- Allow to specify default animation duration using `UIView.ViewStateConstants.defaultAnimationDuration`
- `.didDetach` state

#### Changed
- Min OS versions increase
- `isAnimatable` logic adjust

#### Fixed
- UIView isAnimatable fix


## [1.2.3](https://github.com/APUtils/ViewState/releases/tag/1.2.3)
Released on 11/17/2021.

#### Added
- Routable logs
- UIView .animateIfNeeded(layout:duration:delay:options:animations:completion:)
- UIView .animateTransitionIfNeeded(layout:duration:delay:options:animations:completion:)
- UIView.animateIfNeeded(view:layout:duration:delay:options:animations:completion:)
- UIView.animateTransitionIfNeeded(view:layout:duration:delay:options:animations:completion:)

#### Changed
- Improve UIView .isAnimatable

#### Fixed
- Fixed simultaneous work with other gesture recognizers for keyboard dismiss recognizer
- Did attach state fix for iOS 15.0


## [1.2.0](https://github.com/APUtils/ViewState/releases/tag/1.2.0)
Released on 07/04/2021.

#### Added
- tvOS support


## [1.1.1](https://github.com/APUtils/ViewState/releases/tag/1.1.1)
Released on 07/04/2021.

#### Added
- Swift Package Manager Support [[@trusk89](https://github.com/trusk89)]


## [1.1.0](https://github.com/APUtils/ViewState/releases/tag/1.1.0)
Released on 04/04/2020.

#### Fixed
- UIViewController `.flashScrollIndicatorsOnViewDidAppear`
- UITableView `.reloadDataWhenPossible()`
- UIViewController `.hideKeyboardOnTouch` for button tap


## [1.0.0](https://github.com/APUtils/ViewState/releases/tag/1.0.0)
Released on 01/03/2020.

#### Added
- Initial release of ViewState.
  - Added by [Anton Plebanovich](https://github.com/anton-plebanovich).
