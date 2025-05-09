// Created by Bryan Keller on 7/15/20.
// Copyright © 2020 Airbnb Inc. All rights reserved.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

// MARK: - AnyCalendarItemModel

/// A type-erased calendar item model.
///
/// Useful for working with types conforming to `CalendarItemModel` without knowing the underlying concrete type.
public protocol AnyCalendarItemModel {

  /// A type that helps `ItemViewReuseManager` determine which views are compatible with one another and can therefore be
  /// recycled / reused.
  ///
  /// - Note: There is no reason to access this property from your feature code; it should only be accessed internally.
  var _itemViewDifferentiator: _CalendarItemViewDifferentiator { get }

  /// Builds an instance of `ViewType` by invoking its initializer with `invariantViewProperties`.
  ///
  /// - Note: There is no reason to invoke this function from your feature code; it should only be invoked internally.
  func _makeView() -> UIView

  /// Updates the content on an instance of `ViewType` by invoking `setContent`.
  ///
  /// - Note: There is no reason to invoke this function from your feature code; it should only be invoked internally.
  func _setContent(onViewOfSameType view: UIView)

  /// Compares the contents of two `CalendarItemModel`s for equality.
  ///
  /// - Note: There is no reason to invoke this function from your feature code; it should only be invoked internally.
  func _isContentEqual(toContentOf other: AnyCalendarItemModel) -> Bool

  // TODO: Remove this in the next major release.
  mutating func _setSwiftUIWrapperViewContentIDIfNeeded(_ id: AnyHashable)

}

// MARK: - _CalendarItemViewDifferentiator

/// A type that helps `ItemViewReuseManager` determine which views are compatible with one another and can therefore be
/// recycled / reused.
///
/// - Note: There is no reason to create an instance of this enum from your feature code; it should only be invoked internally.
public struct _CalendarItemViewDifferentiator: Hashable {
  let viewType: ObjectIdentifier
  let invariantViewProperties: AnyHashable
}
