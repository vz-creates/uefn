# Copyright Epic Games, Inc. All Rights Reserved.
#################################################
# Generated Digest of Verse API
# DO NOT modify this manually!
# Generated from build: ++Fortnite+Release-39.10-CL-48971054
#################################################

# Module import path: /Verse.org/Assets
Assets<public> := module {
  using { /Verse.org/Simulation }
  animation_sequence<native><public> := class<computes><final><epic_internal> {}

  # Interface that provides an icon.
  has_icon<public> := interface {
    @editable
    var<protected> Icon<public>: texture
  }

  input_action<native><public>(t: type) := class<computes><epic_internal> {
    (/Verse.org/Assets/input_action:)Assets_input_action_Variance<private>: ?type { _(): tuple(t) } = external {}
  }

  input_mapping<native><public> := class<computes><epic_internal> {}

  material<native><public> := class<epic_internal> {}

  mesh<native><public> := class<computes><epic_internal> {}

  particle_system<native><public> := class<computes><final><epic_internal> {}

  sound_wave<native><public> := class<computes><final><epic_internal> {}

  texture<native><public> := class<computes><final><epic_internal> {}
}

# Module import path: /Verse.org/Colors
Colors<public> := module {
  @available { MinUploadedAtFNVersion := 3800 }
  # Makes a new `color_alpha` from individual `R`, `G`, `B`, `A` component values.
  MakeColorAlpha<public>(R: float, G: float, B: float, ?A: float = external {})<computes>: color_alpha = external {}

  # Makes an ACES 2065-1 `color` from `Hue`, `Saturation`, and `Value` components.
  # Components use the HSV color model in the sRGB color space. Expected ranges:
  #  * `0.0 <= Hue <= 360.0`
  #  * `0.0 <= Saturation <= 1.0`
  #  * `0.0 <= Value <= 1.0`
  # Values out of expected ranges will undergo range reduction and conversion.
  MakeColorFromHSV<native><public>(Hue: float, Saturation: float, Value: float)<converges>: color

  # Makes an ACES 2065-1 `color` from a CSS-style sRGB `hexString`. Supported formats are:
  #  * RGB
  #  * RRGGBB
  #  * RRGGBBAA
  #  * #RGB
  #  * #RRGGBB
  #  * #RRGGBBAA
  # An invalid hex string will return `Black`.
  MakeColorFromHex<native><public>(hexString: string)<converges>: color

  # Makes an ACES 2065-1 `color` from sRGB components `Red`, `Green`, and `Blue`.
  # Normal sRGB component values are between `0.0` and `1.0`, but this can handle larger values.
  MakeColorFromSRGB<native><public>((local:)Red: float, (local:)Green: float, (local:)Blue: float)<converges>: color

  # Makes an ACES 2065-1 `color` from the integer sRGB components `Red`, `Green`, and `Blue`.
  # Valid sRGB component values are between '0' and '255', inclusive.
  MakeColorFromSRGBValues<native><public>((local:)Red: int, (local:)Green: int, (local:)Blue: int)<converges>: color

  # Makes an ACES 2065-1 `color` from the chromaticity of a blackbody radiator at `Temperature` Kelvin.
  # `Temperature` is clamped such that `0 <= Temperature`.
  MakeColorFromTemperature<native><public>(Temperature: float)<converges>: color

  # Makes an HSV `tuple` by converting `InColor` from an ACES 2065-1 `color` to sRGB and applying the HSV color model.
  MakeHSVFromColor<native><public>(InColor: color): tuple(float, float, float)

  # Makes an sRGB `tuple` by converting `InColor` from an ACES 2065-1 `color` to sRGB.
  MakeSRGBFromColor<native><public>(InColor: color)<converges>: tuple(float, float, float)

  # Module import path: /Verse.org/Colors/NamedColors
  # Color presets from CSS Color Module 3 Extended color keywords.
  NamedColors<public> := module {
    AliceBlue<public>: color = external {}

    AntiqueWhite<public>: color = external {}

    Aqua<public>: color = external {}

    Aquamarine<public>: color = external {}

    Azure<public>: color = external {}

    Beige<public>: color = external {}

    Bisque<public>: color = external {}

    Black<public>: color = external {}

    BlanchedAlmond<public>: color = external {}

    Blue<public>: color = external {}

    BlueViolet<public>: color = external {}

    Brown<public>: color = external {}

    Burlywood<public>: color = external {}

    CadetBlue<public>: color = external {}

    Chartreuse<public>: color = external {}

    Chocolate<public>: color = external {}

    Coral<public>: color = external {}

    CornflowerBlue<public>: color = external {}

    Cornsilk<public>: color = external {}

    Crimson<public>: color = external {}

    Cyan<public>: color = external {}

    DarkBlue<public>: color = external {}

    DarkCyan<public>: color = external {}

    DarkGoldenrod<public>: color = external {}

    DarkGray<public>: color = external {}

    DarkGreen<public>: color = external {}

    DarkGrey<public>: color = external {}

    DarkKhaki<public>: color = external {}

    DarkMagenta<public>: color = external {}

    DarkOliveGreen<public>: color = external {}

    DarkOrange<public>: color = external {}

    DarkOrchid<public>: color = external {}

    DarkRed<public>: color = external {}

    DarkSalmon<public>: color = external {}

    DarkSeaGreen<public>: color = external {}

    DarkSlateBlue<public>: color = external {}

    DarkSlateGray<public>: color = external {}

    DarkSlateGrey<public>: color = external {}

    DarkTurquoise<public>: color = external {}

    DarkViolet<public>: color = external {}

    DeepPink<public>: color = external {}

    DeepSkyBlue<public>: color = external {}

    DimGray<public>: color = external {}

    DimGrey<public>: color = external {}

    DodgerBlue<public>: color = external {}

    Firebrick<public>: color = external {}

    FloralWhite<public>: color = external {}

    ForestGreen<public>: color = external {}

    Fuchsia<public>: color = external {}

    Gainsboro<public>: color = external {}

    GhostWhite<public>: color = external {}

    Gold<public>: color = external {}

    Goldenrod<public>: color = external {}

    Gray<public>: color = external {}

    Green<public>: color = external {}

    GreenYellow<public>: color = external {}

    Grey<public>: color = external {}

    Honeydew<public>: color = external {}

    Hotpink<public>: color = external {}

    IndianRed<public>: color = external {}

    Indigo<public>: color = external {}

    Ivory<public>: color = external {}

    Khaki<public>: color = external {}

    Lavender<public>: color = external {}

    LavenderBlush<public>: color = external {}

    LawnGreen<public>: color = external {}

    LemonChiffon<public>: color = external {}

    LightBlue<public>: color = external {}

    LightCoral<public>: color = external {}

    LightCyan<public>: color = external {}

    LightGoldenrodYellow<public>: color = external {}

    LightGray<public>: color = external {}

    LightGreen<public>: color = external {}

    LightGrey<public>: color = external {}

    LightPink<public>: color = external {}

    LightSalmon<public>: color = external {}

    LightSeaGreen<public>: color = external {}

    LightSkyBlue<public>: color = external {}

    LightSlateGray<public>: color = external {}

    LightSlateGrey<public>: color = external {}

    LightSteelBlue<public>: color = external {}

    LightYellow<public>: color = external {}

    Lime<public>: color = external {}

    LimeGreen<public>: color = external {}

    Linen<public>: color = external {}

    Magenta<public>: color = external {}

    Maroon<public>: color = external {}

    MediumAquamarine<public>: color = external {}

    MediumBlue<public>: color = external {}

    MediumOrchid<public>: color = external {}

    MediumPurple<public>: color = external {}

    MediumSeaGreen<public>: color = external {}

    MediumSlateBlue<public>: color = external {}

    MediumSpringGreen<public>: color = external {}

    MediumTurquoise<public>: color = external {}

    MediumVioletRed<public>: color = external {}

    MidnightBlue<public>: color = external {}

    MintCream<public>: color = external {}

    MistyRose<public>: color = external {}

    Moccasin<public>: color = external {}

    NavajoWhite<public>: color = external {}

    Navy<public>: color = external {}

    OldLace<public>: color = external {}

    Olive<public>: color = external {}

    OliveDrab<public>: color = external {}

    Orange<public>: color = external {}

    OrangeRed<public>: color = external {}

    Orchid<public>: color = external {}

    PaleGoldenrod<public>: color = external {}

    PaleGreen<public>: color = external {}

    PaleTurquoise<public>: color = external {}

    PaleVioletred<public>: color = external {}

    PapayaWhip<public>: color = external {}

    PeachPuff<public>: color = external {}

    Peru<public>: color = external {}

    Pink<public>: color = external {}

    Plum<public>: color = external {}

    PowderBlue<public>: color = external {}

    Purple<public>: color = external {}

    Red<public>: color = external {}

    RosyBrown<public>: color = external {}

    RoyalBlue<public>: color = external {}

    SaddleBrown<public>: color = external {}

    Salmon<public>: color = external {}

    SandyBrown<public>: color = external {}

    SeaGreen<public>: color = external {}

    SeaShell<public>: color = external {}

    Sienna<public>: color = external {}

    Silver<public>: color = external {}

    SkyBlue<public>: color = external {}

    SlateBlue<public>: color = external {}

    SlateGray<public>: color = external {}

    SlateGrey<public>: color = external {}

    Snow<public>: color = external {}

    SpringGreen<public>: color = external {}

    SteelBlue<public>: color = external {}

    (/Verse.org/Colors/NamedColors:)Tan<public>: color = external {}

    Teal<public>: color = external {}

    Thistle<public>: color = external {}

    Tomato<public>: color = external {}

    Turquoise<public>: color = external {}

    Violet<public>: color = external {}

    Wheat<public>: color = external {}

    White<public>: color = external {}

    WhiteSmoke<public>: color = external {}

    Yellow<public>: color = external {}

    YellowGreen<public>: color = external {}
  }

  @available { MinUploadedAtFNVersion := 3800 }
  # Blend colors `CA1` and `CA2` with `CA1` over `CA2` using two non-premultiplied `color_alpha` values.
  # Alpha components are clamped between `0.0` and `1.0`. Fails if the value of both clamped Alpha components are `0.0`.
  Over<public>(CA1: color_alpha, CA2: color_alpha)<reads><decides>: color_alpha = external {}

  using { /Verse.org/Native }
  using { /Verse.org/Simulation }
  # Represents colors as RGB triples in the ACES 2065-1 color space.
  # Component values are linear (i.e. `*gamma* = 1.0`).
  color<native><public> := struct<concrete><computes><persistable> {
    @editable
    # Blue component of this `color`.
    B<native><public>: float = external {}

    @editable
    # Green component of this `color`.
    G<native><public>: float = external {}

    @editable
    # Red component of this `color`.
    R<native><public>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 3800 }
  # Represents colors as RGB triples in the ACES 2065-1 color space with an additional alpha channel A.
  # This reasons about the `Color` and alpha (`A`) as separate concepts instead of as a single concept.
  # All values are stored strictly as unopinionated floats but, when interpreted as a color with alpha,
  # ranges for `A` are `0.0` (transparent) to `1.0` (opaque). Color values are not premultiplied.
  # Component values are linear (i.e. `*gamma* = 1.0`).
  color_alpha<native><public> := struct<concrete><computes><persistable> {
    @editable
    # Alpha component of this `color_alpha`.
    A<native><public>: float = external {}

    @editable
    # `Color` component of this `color_alpha`.
    Color<native><public>: color = external {}
  }

  # Makes an ACES 2065-1 `color` from the component-wise product of `c0` and `c1`.
  (/Verse.org/Colors:)operator'*'<native><public>(c0: color, c1: color)<converges>: color

  # Makes an ACES 2065-1 `color` from each component of `c` scaled by `factor`.
  (/Verse.org/Colors:)operator'*'<native><public>(c: color, factor: float)<converges>: color

  # Makes an ACES 2065-1 `color` from each component of `c` scaled by `factor`.
  (/Verse.org/Colors:)operator'*'<native><public>(c: color, factor: int)<converges>: color

  # Makes an ACES 2065-1 `color` from each component of `c` scaled by `factor`.
  (/Verse.org/Colors:)operator'*'<native><public>(factor: float, c: color)<converges>: color

  # Makes an ACES 2065-1 `color` from each component of `c` scaled by `factor`.
  (/Verse.org/Colors:)operator'*'<native><public>(factor: int, c: color)<converges>: color

  # Makes an ACES 2065-1 `color` from the component-wise sum of `c0` and `c1`.
  (/Verse.org/Colors:)operator'+'<native><public>(c0: color, c1: color)<converges>: color

  # Makes an ACES 2065-1 `color` from the component-wise difference of `c0` and `c1`.
  (/Verse.org/Colors:)operator'-'<native><public>(c0: color, c1: color)<converges>: color

  # Makes an ACES 2065-1 `color` from each component of `c` divided by `factor`.
  (/Verse.org/Colors:)operator'/'<native><public>(c: color, factor: float)<decides><converges>: color

  # Makes an ACES 2065-1 `color` from each component of `c` divided by `factor`.
  (/Verse.org/Colors:)operator'/'<native><public>(c: color, factor: int)<decides><converges>: color
}

# Module import path: /Verse.org/Concurrency
Concurrency<public> := module {
  awaitable<public>() := awaitable(void)

  # A parametric interface implemented by events with a `payload` that can be waited on. Matched with `signalable.`
  awaitable<public>(payload: type) := interface {
    # Suspends the current task until resumed by a matching call to `signalable.Signal`. Returns the event `payload`.
    Await<public>()<suspends>: payload

    (/Verse.org/Concurrency/awaitable:)Concurrency_awaitable_Variance<private>: ?type { _(): tuple(payload) } = external {}
  }

  task<native><public>(t: type) := class<abstract><final>(awaitable(t)) {
    Await<native><override>()<suspends>: t

    (/Verse.org/Concurrency/task:)Concurrency_task_Variance<private>: ?type { _(): tuple(t) } = external {}
  }
}

# Module import path: /Verse.org/Native
Native<public> := module {
  import_as<constructor><epic_internal>(ImportName: string)<computes>: import_as_attribute = external {}

  @attribscope_class
  @attribscope_struct
  @attribscope_enum
  @attribscope_interface
  @attribscope_module
  import_as_attribute<epic_internal> := class<computes><internal>(attribute) {}
}

Presentation<public> := module {
  using { /Verse.org/Simulation }
  # Interface that provides descriptive names or text.
  has_description<public> := interface {
    @editable
    # Full description.
    var<protected> Description<public>: message

    @editable
    # Name.
    var<protected> Name<public>: message

    @editable
    # Short description with only the essential information.
    var<protected> ShortDescription<public>: message
  }
}

# Module import path: /Verse.org/Random
Random<public> := module {
  # Returns a random `float` between `Low` and `High`, inclusive.
  GetRandomFloat<native><public>(Low: float, High: float)<transacts>: float

  # Returns a uniformly distributed, cryptographically-secure random `int` between `Low` and `High`, inclusive. (`Low` and `High` can be out of order.)
  GetRandomInt<native><public>(Low: int, High: int)<transacts>: int

  # Makes an `array` with the same elements as `Input` shuffled in a random order.
  Shuffle<public>(Input: []t where t: type)<transacts>: []t = external {}
}

SceneGraph<public> := module {
  @available { MinUploadedAtFNVersion := 2930 }
  # Find all objects in the scene that currently overlap this entity.
  (Entity: entity).FindOverlapHits<public>()<transacts>: generator(overlap_hit) = external {}

  @available { MinUploadedAtFNVersion := 2930 }
  # Find all objects in the scene that would overlap this entity if it were placed at GlobalTransform.
  (Entity: entity).FindOverlapHits<public>(GlobalTransform: (/Verse.org/SpatialMath:)transform)<transacts>: generator(overlap_hit) = external {}

  @available { MinUploadedAtFNVersion := 2930 }
  # Find all objects in the scene that would overlap Volume if they were placed at GlobalTransform. NOTE: This entity defines the context(scene) for the query but does not otherwise take part in the sweep.
  (Entity: entity).FindOverlapHits<public>(
    GlobalTransform: (/Verse.org/SpatialMath:)transform,
    Volume: collision_volume
  )<transacts>: generator(overlap_hit) = external {}

  @available { MinUploadedAtFNVersion := 2930 }
  # Find objects in the scene that would intersect this entity if it were swept from its location along the Displacement vector. Returns the first object interacting as collision_interaction.Block, and all objects interacting as collision_interaction.Overlap encountered before the first block. Hits are sorted by hit distance, so the blocking hit will be last.
  (Entity: entity).FindSweepHits<public>(Displacement: (/Verse.org/SpatialMath:)vector3)<transacts>: generator(sweep_hit) = external {}

  @available { MinUploadedAtFNVersion := 2930 }
  # Find objects in the scene that would intersect this entity if it were swept from GlobalTransform along the Displacement vector. Returns the first object interacting as collision_interaction.Block, and all objects interacting as collision_interaction.Overlap encountered before the first block. Hits are sorted by hit distance, so the blocking hit will be last.
  (Entity: entity).FindSweepHits<public>(
    Displacement: (/Verse.org/SpatialMath:)vector3,
    StartGlobalTransform: (/Verse.org/SpatialMath:)transform
  )<transacts>: generator(sweep_hit) = external {}

  @available { MinUploadedAtFNVersion := 2930 }
  # Find all objects in the scene that would intersect Volume if they were swept from GlobalTransform along the Displacement vector Hits are sorted by hit distance. NOTE: This entity defines the context(scene) for the query but does not otherwise take part in the sweep.
  (Entity: entity).FindSweepHits<public>(
    Displacement: (/Verse.org/SpatialMath:)vector3,
    StartGlobalTransform: (/Verse.org/SpatialMath:)transform,
    Volume: collision_volume
  )<transacts>: generator(sweep_hit) = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  # Get the players that this entity is currently be presented to. False = presentable to everyone, array = presentable to no one.
  (Entity: entity).GetPresentableToPlayers<native><public>()<transacts>: ?[]player

  @available { MinUploadedAtFNVersion := 3800 }
  # Assign the players that this entity will be presented to. False = presentable to everyone, array = presentable to no one.
  (Entity: entity).SetPresentableToPlayers<native><public>(Players: ?[]player): void

  @available { MinUploadedAtFNVersion := 3200 }
  # Finds all components attached to ancestor entities to `InEntity` of type `component_type`.
  # The order of the returned components is unspecified and subject to change.
  (InEntity: entity).FindAncestorComponents<native><public>(component_type: castable_subtype(component))<transacts>: generator(component_type)

  @available { MinUploadedAtFNVersion := 3200 }
  # Finds all ancestor entities to `InEntity` of type `entity_type`.
  # The order of the returned entities is unspecified and subject to change.
  (InEntity: entity).FindAncestorEntities<native><public>(entity_type: castable_subtype(entity))<transacts>: generator(entity_type)

  @available { MinUploadedAtFNVersion := 3200 }
  # Finds all ancestor entities to `InEntity` containing a component of type `component_type`.
  # The order of the returned entities is unspecified and subject to change.
  (InEntity: entity).FindAncestorEntitiesWithComponent<native><public>(component_type: castable_subtype(component))<transacts>: generator(entity)

  @available { MinUploadedAtFNVersion := 2930 }
  @experimental
  # Finds all ancestor entities to `InEntity` with `Tag` present in their `tag_component`.
  # The order of the returned entities is unspecified and subject to change.
  (InEntity: entity).FindAncestorEntitiesWithTag<native><public>(Tag: tag)<transacts>: generator(entity)

  @available { MinUploadedAtFNVersion := 3200 }
  # Finds all components attached to descendant entities to and including `InEntity` of type `component_type`.
  # The order of the returned components is unspecified and subject to change.
  (InEntity: entity).FindDescendantComponents<native><public>(component_type: castable_subtype(component))<transacts>: generator(component_type)

  using { /Verse.org/Native }
  @available { MinUploadedAtFNVersion := 3200 }
  # Finds all descendant entities including `InEntity` of type `entity_type`.
  # The order of the returned entities is unspecified and subject to change.
  (InEntity: entity).FindDescendantEntities<native><public>(entity_type: castable_subtype(entity))<transacts>: generator(entity_type)

  @available { MinUploadedAtFNVersion := 3200 }
  # Finds all descendant entities including `InEntity` containing a component of type `component_type`.
  # The order of the returned entities is unspecified and subject to change.
  (InEntity: entity).FindDescendantEntitiesWithComponent<native><public>(component_type: castable_subtype(component))<transacts>: generator(entity)

  @available { MinUploadedAtFNVersion := 2930 }
  @experimental
  # Finds all descendant entities including `InEntity` with `Tag` present in their `tag_component`.
  # When querying from the simulation entity, the simulation entity itself is not included in the results.
  # The order of the returned entities is unspecified and subject to change.
  (InEntity: entity).FindDescendantEntitiesWithTag<native><public>(Tag: tag)<transacts>: generator(entity)

  # Returns the global transform of this entity, in the case the entity does not have a transform_component it will return the transform of the first parent that has a transform
  (InEntity: entity).GetGlobalTransform<native><public>()<transacts>: (/Verse.org/SpatialMath:)transform

  # Returns the local transform of this entity, in the case the entity does not have a transform_component it will return identity
  (InEntity: entity).GetLocalTransform<native><public>()<transacts>: (/Verse.org/SpatialMath:)transform

  # Returns the origin of the entity in any, in the case the entity does not have a transform_component the method will fail
  (InEntity: entity).GetOrigin<native><public>()<transacts><decides>: origin

  # Returns the simulation entity parent for this entity.
  #   * The simulation entity is the rootmost entity in an experience.
  #   * Fails if this entity is not currently in the scene.
  (InEntity: entity).GetSimulationEntity<native><public>()<transacts><decides>: entity

  # Resets the origin of this entity, which will now default to its parent
  (InEntity: entity).ResetOrigin<native><public>()<transacts>: void

  # Sets the global transform of this entity, in the case the entity does not have a transform_component it will create one and set its global transform
  (InEntity: entity).SetGlobalTransform<native><public>(NewGlobalTransform: (/Verse.org/SpatialMath:)transform)<transacts>: void

  # Sets the local transform of this entity, in the case the entity does not have a transform_component it will create one and set its local transform
  (InEntity: entity).SetLocalTransform<native><public>(NewLocalTransform: (/Verse.org/SpatialMath:)transform)<transacts>: void

  # Sets the origin of this entity, in the case the entity does not have a transform_component it will create one and set its origin. This method fails if it recognized dependency recursion.
  (InEntity: entity).SetOrigin<native><public>(NewOrigin: origin)<transacts>: void

  # Module import path: /Verse.org/SceneGraph/CollisionChannels
  # The set of built-in collision_channels. This is a closed set for now.
  CollisionChannels<public> := module {
    avatar<native><public> := class(collision_channel) {}

    camera<native><public> := class(collision_channel) {}

    dynamic<native><public> := class(collision_channel) {}

    physics<native><public> := class(collision_channel) {}

    stationary<native><public> := class(collision_channel) {}

    visibility<native><public> := class(collision_channel) {}
  }

  # Module import path: /Verse.org/SceneGraph/CollisionProfiles
  # A set of useful collision profiles. New profiles can be created in Verse code
  CollisionProfiles<public> := module {
    # Dynamic collision channel, Block all channels
    DynamicBlockAll<public>: collision_profile = external {}

    # Dynamic collision channel, Ignore all channels
    DynamicIgnoreAll<public>: collision_profile = external {}

    # Dynamic collision channel, Overlap all channels
    DynamicOverlapAll<public>: collision_profile = external {}

    # Stationary collision channel, Block all channels
    StationaryBlockAll<public>: collision_profile = external {}

    # Stationary collision channel, Block all channels except visibility (used for e.g., invisible wall, glass)
    StationaryBlockVisible<public>: collision_profile = external {}

    # Stationary collision channel, Ignore all channels
    StationaryIgnoreAll<public>: collision_profile = external {}

    # Stationary collision channel, Overlap all channels
    StationaryOverlapAll<public>: collision_profile = external {}

    # Visibility collision channel, Overlap all channel (used for e.g., visibility testing)
    VisibilityOverlapAll<public>: collision_profile = external {}
  }

  # Module import path: /Verse.org/SceneGraph/KeyframedMovement
  # Animate Scene Graph entities with keyframes.
  KeyframedMovement<public> := module {
    # Cubic bezier easing function. See CubicBezierEasingFunctions for some basic easing values.
    cubic_bezier_easing_function<native><public> := class<concrete><computes><epic_internal>(easing_function) {
      Evaluate<native><override>(Input: float): float

      X0<native><public>: float = external {}

      X1<native><public>: float = external {}

      Y0<native><public>: float = external {}

      Y1<native><public>: float = external {}
    }

    # `Ease` animations start slowly, speed up, then end slowly. The speed of the animation is slightly slower at the end than the start.
    ease_cubic_bezier_easing_function<native><public> := class<final><concrete><computes>(cubic_bezier_easing_function) {
      X0<override>: float = external {}

      X1<override>: float = external {}

      Y0<override>: float = external {}

      Y1<override>: float = external {}
    }

    # `EaseIn` animations start slow, then speed up towards the end.
    ease_in_cubic_bezier_easing_function<native><public> := class<final><concrete><computes>(cubic_bezier_easing_function) {
      X0<override>: float = external {}

      X1<override>: float = external {}

      Y0<override>: float = external {}

      Y1<override>: float = external {}
    }

    # `EaseInOut` animations are similar to `Ease` but the start and end animation speed is symmetric.
    ease_in_out_cubic_bezier_easing_function<native><public> := class<final><concrete><computes>(cubic_bezier_easing_function) {
      X0<override>: float = external {}

      X1<override>: float = external {}

      Y0<override>: float = external {}

      Y1<override>: float = external {}
    }

    # `EaseOut` animations start fast, then slow down towards the end.
    ease_out_cubic_bezier_easing_function<native><public> := class<final><concrete><computes>(cubic_bezier_easing_function) {
      X0<override>: float = external {}

      X1<override>: float = external {}

      Y0<override>: float = external {}

      Y1<override>: float = external {}
    }

    using { /Verse.org/Simulation }
    using { /Verse.org/SpatialMath }
    # Base class for an animation easing function.
    easing_function<native><public> := class<abstract><computes><epic_internal> {
      Evaluate<native><public>(Input: float): float
    }

    # Provides teleportation and simple keyframe-based animation for an entity. Animations play back in the Pre-Physics tick phase. When animating an entity with a parent_constraint, animation will be relative to the parent entity.
    keyframed_movement_component<native><public> := class<final><final_super>(component) {
      # Get the event that fires when the animations ends, failing if the animation is of infinite duration
      FinishedEvent<native><public>: listenable(tuple()) = external {}

      # Is there a valid set of playable keyframes?
      HasValidAnimation<native><public>()<reads><decides>: void

      # Is the animation paused?
      IsPaused<native><public>()<reads><decides>: void

      # Is the animation currently playing?
      IsPlaying<native><public>()<reads><decides>: void

      # Signaled when any keyframe is reached. (Keyframe:int, IsReversed:logic).
      KeyframeReachedEvent<native><public>: listenable(tuple(int, logic)) = external {}

      # Pause movement. Subsequently calling Play() will resume from the point in the animation when it was paused.
      Pause<native><public>(): void

      # Get the event that fires when the animation is Paused.
      PausedEvent<native><public>: listenable(tuple()) = external {}

      # Begin or resume playback.
      Play<native><public>(): void

      # Get the event that fires when the animation begins or resumes Playing.
      PlayedEvent<native><public>: listenable(tuple()) = external {}

      # Stop any ongoing animation, sets the animation path and rebases it relative to the actor's current transform. Does not start playing until you call Play().
      SetKeyframes<native><public>(
        RelativeKeyframes: []keyframed_movement_delta,
        PlaybackMode: keyframed_movement_playback_mode
      ): void

      # Stop and reset transform to the initial state. Subsequently calling Play() will begin the animation anew.
      Stop<native><public>(BlendOutTime: float): void

      # Stop and reset transform to the initial state. Subsequently calling Play() will begin the animation anew.
      Stop<public>(): void = external {}

      # Get the event that fires when the animation is Stopped.
      StoppedEvent<native><public>: listenable(tuple()) = external {}

      # Gets the duration in seconds this keyframed movement will take. Fails if a fixed duration is not known (ex: looping animations).
      var<private> Duration<native><public>: ?float = external {}
    }

    # Represents a change in pose and scale over a duration.
    keyframed_movement_delta<native><public> := class<final><concrete> {
      @editable_number(float) { MinValue := option { 0.000000 } }
      # Duration of this keyframe in seconds.
      Duration<native><public>: float = external {}

      @editable
      # Easing function to use for playback.
      Easing<native><public>: easing_function = external {}

      @editable
      # Represents a change in the transform relative to the previous keyframe or initial animation position. Translation and Scale are interpreted additively.
      Transform<native><public>: (/Verse.org/SpatialMath:)transform = external {}
    }

    # Controls how the animation plays back.
    keyframed_movement_playback_mode<native><public> := class<abstract><computes><epic_internal> {}

    # `Linear` animations move at a constant speed.
    linear_easing_function<native><public> := class<final><concrete><computes>(cubic_bezier_easing_function) {
      X0<override>: float = external {}

      X1<override>: float = external {}

      Y0<override>: float = external {}

      Y1<override>: float = external {}
    }

    # Play once and repeat indefinitely.
    loop_keyframed_movement_playback_mode<native><public> := class<final><concrete><computes>(keyframed_movement_playback_mode) {}

    # Play once and stop.
    oneshot_keyframed_movement_playback_mode<native><public> := class<final><concrete><computes>(keyframed_movement_playback_mode) {}

    # Play continuously reversing direction at each end.
    pingpong_keyframed_movement_playback_mode<native><public> := class<final><concrete><computes>(keyframed_movement_playback_mode) {}
  }

  using { /Verse.org/Simulation }
  # An interactable component with a composable feature set.
  basic_interactable_component<native><public> := class(interactable_component) {
    # Attempt to cancel an interaction. Fails if the supplied agent is not currently interacting with the component.
    Cancel<native><public>(Agent: agent)<transacts><decides>: void

    @editable
    # Cooldowns begin elapsing on successful interactions. A cooldown which applies for all attempts to interact on this component.
    Cooldown<native><public>: ?interactable_cooldown = external {}

    @editable
    # Cooldowns begin elapsing on successful interactions. A cooldown which applies for future attempts to interact on this component by the agent which succeeded.
    CooldownPerAgent<native><public>: ?interactable_cooldown_per_agent = external {}

    # Get the remaining cooldown of the interactable for the supplied agent. This returns the duration left in seconds of either the shared or per agent cooldown, whichever is greater. Returns the same value when called multiple times within a transaction.
    GetRemainingCooldownDurationAffectingAgent<native><public>(Agent: agent): float

    @editable
    # An interaction with a duration does not succeed until the duration has elapsed, and success is not guaranteed as it can be canceled while the duration is active.
    InteractableDuration<native><public>: ?interactable_duration = external {}

    # Attempt to succeed at an interaction. Success will also happen automatically after InteractDuration has elapsed after starting an interaction. Fails if the supplied agent is not currently interacting with the component.
    Succeed<native><public>(Agent: agent)<transacts><decides>: void

    @editable
    # Success limits prevent new interactions once the component has been successfully interacted with a specified number of times.
    SuccessLimit<native><public>: ?interactable_success_limit = external {}

    # The agents which are currently interacting with this interactable.
    var<private> InteractingAgents<native><public>: []agent = external {}
  }

  using { /Verse.org/Colors }
  using { /Verse.org/Simulation/Tags }
  using { /Verse.org/SpatialMath }
  # A `capsule_light_component` emits light in all directions into the scene from a capsule shaped source with a specified radius and length. A radius and length of 0 makes it a point light. You can use these
  # to simulate any kind of light sources that emit in all directions and need an elongated source shape, such as a long light bulb.
  capsule_light_component<native><public> := class<final>(light_component) {
    # The bounds of the light's visible influence. This clamping of the light's influence is not physically correct but very important for performance,
    # larger lights cost more. The light falloff is based on Inverse Square law. Towards the tail end of the AttenuationRadius,
    # there is an additional smoothing factor to fade out the light contribution to 0 to avoid a hard cutoff.
    var AttenuationRadius<public>: ?float = external {}

    # Set the visible light intensity emitted in SI unit Candela.
    # Specified before ColorFilter (which multiplies each color component after the intensity calculation and can change the effective intensity of the light).
    var Intensity<public>: float = external {}

    # Length of the source capsule shape in centimeters along the local Z axis. Note that light shapes which intersect shadow casting geometry can cause shadowing artifacts.
    var SourceLength<public>: float = external {}

    # Radius of the source capsule shape in centimeters around the local Z axis. Note that light shapes which intersect shadow casting geometry can cause shadowing artifacts.
    var SourceRadius<public>: float = external {}
  }

  # An axis-aligned collision box.
  collision_box<native><public> := class(collision_element) {
    var Extents<public>: (/Verse.org/SpatialMath:)vector3
  }

  # A collision capsule aligned along the Z axis.
  collision_capsule<native><public> := class(collision_element) {
    # The length of the capsule's cylindrical section (distance between the two end cap centers)
    var Length<public>: float = external {}

    # The radius of the capsule
    var Radius<public>: float = external {}
  }

  # Every volume has a collision channel as part of its collision_profile. It is used to determine how two volumes interact. See collision_profile.
  collision_channel<native><public> := class<concrete><epic_internal> {}

  # An alias for the function type used to map a collision_channel to a collision_interaction used by  collision_profile.
  collision_channel_to_interaction<public> := type { _(: collision_channel)<computes>: collision_interaction }

  # Base class for collision_volumes that consist of a single volume with a single collision_profile and collision_material for the whole volume. This covers most volume types used in queries and physics, except compound types like a mesh. A query will always return an element rather than a general volume. For example when colliding with a mesh, the element will be a collision_triangle, which is a collision_element and has a single material, rather than a collision_triangle_mesh, which is not an element and has a material palette.
  collision_element<native><public> := class<abstract>(collision_volume) {
    # The collision_profile for this volume.
    var CollisionProfile<public>: collision_profile = external {}
  }

  # Specifies how a collision volume pair should interact. See collision_profile.
  collision_interaction<native><public> := enum {
    # The pair will be detected by Overlap and Sweep queries. The pair will collide in the physics simulation.
    Block

    # The pair will not be detected by Overlap and Sweep queries. The pair will not collide in the physics simulation.
    Ignore

    # The pair will be detected by Overlap and Sweep queries. The pair will not collide in the physics simulation.
    Overlap
  }

  # A collision point.
  collision_point<native><public> := class<concrete>(collision_element) {}

  # A collision profile determines how a volume interacts with other volumes for Overlap queries, Sweep queries, and physics simulation. When two volumes are being tested to see how they interact, the algorithm looks like this:
  #    GetInteraction(A:collision_profile, B:collision_profile):collision_interaction =
  #        InteractionA = B.GetChannelInteraction(A.Channel)
  #        InteractionB = A.GetChannelInteraction(B.Channel)
  #        return Min(InteractionA, InteractionB)
  collision_profile<native><public> := class<concrete> {
    # The collision channel for the owning object.
    Channel<native><public>: collision_channel = external {}

    # How the owning object should interact with other objects.GetChannelInteraction is a function which maps a collision_channel to a collision_interaction. It can be implemented as an simple sequence of if statements. For example, to block all channels except camera:
    #     BlockAllIgnoreCamera(Channel:collision_channel)<computes>:collision_interaction =
    #         if (CollisionChannels.camera[Channel]):
    #             return collision_interaction.Ignore
    #         return collision_interaction.Block
    #     MyProfile<public>:collision_profile = MakeCollisionProfile(CollisionChannels.dynamic, BlockAllIgnoreCamera)
    GetChannelInteraction<native><public>: collision_channel_to_interaction = external {}
  }

  # A collision sphere.
  collision_sphere<native><public> := class(collision_element) {
    # The radius of the sphere
    var Radius<public>: float = external {}
  }

  # Collision Volumes represent the collision shapes of meshes. They can be detected by Overlap and Sweep queries and generate collisions in the physics simulation.
  collision_volume<native><public> := class<abstract> {
    # Get the transform of this volume in the space of its owner (usually a component on an entity)
    GetLocalTransform<public>()<transacts>: (/Verse.org/SpatialMath:)transform = external {}

    # Set the transform of this volume in the space of its owner (usually a component on an entity)
    SetLocalTransform<public>(NewLocalTransform: (/Verse.org/SpatialMath:)transform)<transacts>: void = external {}

    # Enable/disable collision on this volume.
    var Collidable<public>: logic = external {}

    # Enable/disable spatial queries against this volume.
    var Queryable<public>: logic = external {}
  }

  # Base class for authoring logic and data in the SceneGraph. Using components you
  # can author re-usable building blocks of logic and data which can then be added to
  # entities in the scene.
  #
  # Components are a very low level building block which can be used in many ways.
  # For example:
  #   * Exposing engine level concepts like mesh or sound
  #   * Adding gameplay capabilities like damage or interaction
  #   * Storing an inventory for a character in the game
  #
  # As components are generic there is no specific way that they must be used.
  # It is up to the needs of your experience if you use one big game component
  # or if you break up logic into many small components.
  #
  # Classes deriving from component must also specify `<final_super>` to be added
  # to entities. This ensures the class will always derive directly from `component`.
  # Further subclassing of the initial derived component is allowed and does not require
  # specifying `<final_super>` on the derived classes.
  #
  # Only one instance of a component from each subclass group can be added to an entity
  # at a time. For example, given this group of components, only one light_component can
  # exist on a single entity. To create multiple lights you should use multiple entities.
  #
  #   light_component             := class<final_super>(component){}
  #   capsule_light_component     := class<final>(light_component){}
  #   directional_light_component := class<final>(light_component){}
  #   spot_light_component        := class<final>(light_component){}
  #   sphere_light_component      := class<final>(light_component){}
  #   rect_light_component        := class<final>(light_component){}
  #
  # ==============================================================================
  # Component Lifetime
  #
  #   Components move through a series of lifetime functions as they are added
  #   to entities, added to the scene, and begin running in the simulation. Components
  #   should override these methods to perform setup and run their simulation.
  #
  #   As a component shuts down it will then move through shutdown version of these
  #   functions, giving users the opportunity to clean up any retained state on the
  #   component before it is disposed
  # .
  #   Lifetime Methods:
  #      OnAddedToScene
  #        OnBeginSimulation -> OnSimulate<suspends>
  #        OnEndSimulation
  #      OnRemovingFromScene
  # ==============================================================================
  component<native><public> := class<abstract><unique><castable><final_super_base> {
    # The parent entity of this component.
    #   * Components must have a parent entity pointer provided when being constructed.
    #   * Components cannot be moved between parents.
    Entity<native><public>: entity

    # Succeeds if the component is currently in the scene.
    #   * After `OnAddedToScene` is called this call succeeds.
    #   * After `OnRemovingFromScene` is called this call fails.
    IsInScene<native><final><public>()<reads><decides>: void

    # Succeeds if the component is currently simulating.
    #   * After `OnBeginSimulation` is called this call succeeds.
    #   * After `OnEndSimulation` is called this call fails.
    IsSimulating<native><final><public>()<reads><decides>: void

    # Called when the component is added to the scene by parenting it under the simulation entity or another entity already in the scene.
    #   * Querying for components in the scene is valid after this phase completes.
    OnAddedToScene<native><native_callable><protected>(): void

    # Called when the component begins simulating within the scene.
    #   * Use this to set up TickEvent callbacks or other setup that must be guaranteed to complete immediately.
    #   * `OnAddedToScene` is guaranteed to run before `OnBeginSimulation`.
    OnBeginSimulation<native><native_callable><protected>(): void

    # Called when the component ends simulation within the scene.
    #   * Simulation ends on a component when the experience resets, the parent entity is removed from the scene.
    #   * Cached TickEvents cancelables should be canceled in `OnEndSimulation`.
    #   * `OnSimulate` task will be canceled before `OnEndSimulation` is called.
    #   * `OnEndSimulation` is only called on components that have already had `OnBeginSimulation` called.
    OnEndSimulation<native><native_callable><protected>(): void

    # Called when the component is about to be removed from the scene.
    #   * Components are removed from a scene when the parent entity is removed from the scene.
    #   * `OnRemovingFromScene` is only called on components that have already had `OnAddedToScene` called.
    OnRemovingFromScene<native><native_callable><protected>(): void

    # Called when the component begins simulating within the scene.
    #   * Use this to add asynchronous/suspends update logic for a component.
    #   * `OnBeginSimulation` is guaranteed to run before `OnSimulate`.
    #   * `OnSimulate` will be cancelled before `OnEndSimulation`
    OnSimulate<native_callable><protected>()<suspends>: void = external {}

    # Removes the component from the entity.
    #   * Removed components are removed from the scene and can only be added back to the same entity.
    #   * Flows through `OnEndSimulation`-> `OnRemovingFromScene`.
    RemoveFromEntity<native><final><public>(): void

    @experimental
    # Send a scene event to this component.  Return true to consume the event and halt propogation.
    SendDown<native><native_callable><public>(SceneEvent: scene_event): logic

    # Set callbacks to `TickEvents.PrePhysics` and `TickEvents.PostPhysics` to receive per-frame updates before and after physics is updated on your object.
    var<private> TickEvents<protected>: tick_events = external {}
  }

  # A `directional_light_component` simulates light that is being emitted from a source that is infinitely far away. This means that all shadows cast by this light will be parallel, making this the ideal choice for simulating sunlight.
  directional_light_component<native><public> := class<final>(light_component) {
    # Intensity of the light hitting the surface. In Lux (Lumen per square meter).
    var Illuminance<public>: float = external {}

    # Angle subtended by light source in degrees (also known as angular diameter). Defaults to 0.5357 which is the angle for our sun.
    var SourceAngleDegrees<public>: float = external {}
  }

  # Entities are the base object in the SceneGraph.
  #   * Objects in experiences are constructed of one or more entities.
  #   * Entities are hierarchical. You can query your parent using `GetParent` and add child entities using `AddEntities`.
  #   * Behavior is added to entities through `component`s. You can add new components using `AddComponents`.
  #   * The structure and content of entities is dynamic and be changed at any time through your experience
  # .
  # ==============================================================================
  # Deriving from entity
  #
  #   In the SceneGraph system a class that derives from `entity` is also known as a prefab. Prefabs are useful when you
  #   want to spawn/re-use a collection of entities and components many times within your game. Primarily prefabs are
  #   authored through the editor, with their Verse classes generated as part of the build into the projects
  #   Assets.digest.verse file.
  #
  #   While you can create base prefabs for common game object types like a vehicle or character, we highly recommended
  #   that you do not add code directly to the entity class, and instead keep logic in components. Keeping logic and data in
  #   components allows you to restructure your prefabs throughout production of your experience, without needing to massively
  #   refactor your class structure.
  entity<native><public> := class<concrete><unique><transacts><castable> {
    # Adds the provided components to the entity.
    #   * If a component is not allowed to be added to this entity it is skipped.
    #   Note: When called during the AddedToScene or BeginSimulation phase, it will make sure the added component has achieved the corresponding phase.
    #   * Components are added following these rules:
    #       1. All components are added to the entity child list.
    #       2. All components have `OnAddedToScene` called (if this entity is in the scene).
    #       3. All components have `OnBeginSimulation` called (if this entity is simulating).
    AddComponents<native><final><public>(Components: []component): void

    # Adds the provided entities as children of this entity.
    #   * If child entity already has a parent, removes the entity from its current parent and adds it to the new one.
    #   * Added child entities will move through their lifetime methods until they match the state of the new parent.
    AddEntities<native><final><public>(NewChildEntities: []entity): void

    @available { MinUploadedAtFNVersion := 3200 }
    # Succeeds and returns the child component of type `component_type` if it exists and is accessible from the calling context.
    #   Note: When called during the AddedToScene or BeginSimulation phase, it will make sure the returned component has achieved the corresponding phase.
    #   Fails if no component of `component_type` exists or can be accessed.
    GetComponent<native><final><public>(component_type: castable_subtype(component))<reads><decides>: component_type

    # Returns the child components belonging to this entity which are accessible from the calling context.
    GetComponents<native><final><public>()<reads>: []component

    # Returns the child entities belonging to this entity which are accessible from the calling context.
    #   * This method only gets the direct entity children. To query multiple levels down the entity structure use
    #     the Find* query methods instead.
    GetEntities<native><final><public>()<reads>: []entity

    # Returns the parent entity of this entity.
    #   * The parent entity controls the lifetime of its child entities and components. When an entity
    #     is removed from the scene, all its child entities and components will be removed as well.
    #   * Method fails if there is currently no parent entity.
    GetParent<native><final><public>()<reads><decides>: entity

    # Removes this entity from its parent. This is used to remove entities from the scene.
    #   * Components on this entity and its children will run through `OnEndSimulation` -> `OnRemovingFromScene`.
    #   * Entity can be added back later by using `NewParent.AddEntities`.
    RemoveFromParent<native><final><public>(): void

    @experimental
    # Send a scene event to this entity and then down the hierarchy. First, SendDown will be invoked on each component on this entity. Next, SendDown will be invoked on each child entity.  Consuming the event at any point will halt propogation. Returns true if any participant consumed the event.
    SendDown<native><native_callable><public>(SceneEvent: scene_event): logic

    @experimental
    # Send a scene event to this entity and then up the hierarchy. First, SendDown will be invoked on each component on this entity. Next, SendUp will be invoked on this entity's parent. Consuming the event at any point will halt propogation. Returns true if any participant consumed the event.
    SendUp<native><native_callable><public>(SceneEvent: scene_event): logic
  }

  @available { MinUploadedAtFNVersion := 3200 }
  # class to provide alternative origin to the 'transform_component' as an entity
  entity_origin<native><public> := class<final>(origin) {
    @editable
    Entity<native><public>: entity

    GetTransform<override>()<transacts>: (/Verse.org/SpatialMath:)transform = external {}
  }

  # Reference type to editor defined prefab. Only generated digest code should reference this type.
  entity_prefab<native><public> := class<computes><epic_internal> {}

  # Users to subscribe to, or await on, a DeltaTime based callback from one of the phases in a component's `TickEvents` object.
  execution_listenable<native><public> := class<epic_internal>(listenable(float)) {
    # Suspends the current task until resumed by a matching call to `signalable.Signal`. Returns the event `payload`.
    Await<native><override>()<suspends>: float

    # Subscribe a callback function to this TickEvent phase. The input parameter to your function (DeltaTime) is the time that has passed between the last update and the current update.
    Subscribe<native><override>(Callback: type { _(: float): void })<transacts>: cancelable
  }

  @experimental
  # A range with a minimum and maximum value. For a value to fall inside of this range, the min value must be less than or equal to the max value.
  float_range<native><public> := struct<concrete> {
    @editable
    Maximum<native><public>: float = external {}

    Minimum<native><public>: float = external {}
  }

  # Used to handle general interaction.
  interactable_component<native><public> := class<final_super>(component, enableable) {
    # Returns whether the specified agent can interact.
    CanInteract<native><native_callable><public>(Agent: agent)<reads><decides>: void

    # Event fires when an interaction has ended before completing successfully. Sends the formerly interacting agent. interactable_component cannot be canceled, this event is provided for subclasses to fire where appropriate.
    CanceledEvent<native><public>: listenable(agent) = external {}

    # Disable interaction with the component. Disabled components do not provide interaction prompts.
    Disable<native><override>(): void

    # Enable interaction with the component.
    Enable<native><override>(): void

    # Returns an appropriate message to display to players to communicate the current state of the interactable.
    InteractMessage<native><native_callable><public>(Agent: agent)<reads><decides>: message

    # Succeeds if the component is enabled, fails if it’s disabled.
    IsEnabled<native><override>()<transacts><decides>: void

    # Called from Start if CanInteract pass successfully to start the interaction. Overriding this function will allow you to create a custom interaction behaviour.
    OnStarted<native><native_callable><protected>(Agent: agent)<transacts><decides>: void

    # Fires the CanceledEvent event.
    SignalCancelEvent<native><protected>(Agent: agent)<transacts>: void

    # Fires the StartedEvent event.
    SignalStartEvent<native><protected>(Agent: agent)<transacts>: void

    # Fires the SucceededEvent event.
    SignalSucceedEvent<native><protected>(Agent: agent)<transacts>: void

    # Attempt to start an interaction. Fails if the agent does not pass the CanInteract function.
    Start<native><final><public>(Agent: agent)<transacts><decides>: void

    # Event fires when a successful interaction starts. Sends the interacting agent. InteractDuration at or below 0 makes this event identical to InteractSucceededEvent.
    StartedEvent<native><public>: listenable(agent) = external {}

    # Event fires when an interaction has completed successfully. Sends the formerly interacting agent. InteractDuration at or below 0 makes this event identical to InteractStartedEvent.
    SucceededEvent<native><public>: listenable(agent) = external {}
  }

  # Used to set a cooldown when interacted.
  interactable_cooldown<native><public> := class<concrete> {
    # Event which fires when the shared cooldown expires.
    ExpiredEvent<native><public>: listenable(tuple()) = external {}

    @editable
    # The number of seconds after a successful interaction, before being able to initiate a subsequent interaction for anyone.
    # This is only used if duration is greater than 0.0. Modifying this does not affect the RemainingDuration.
    # When a cooldown starts on the component all other interactions are canceled.
    var Duration<native><public>: float = external {}

    # The remaining cooldown, in seconds, before new interactions can be initiated on this component.
    var<public> RemainingDuration<public>: float = external {}
  }

  # Used to set a cooldown per agent when interacted.
  interactable_cooldown_per_agent<native><public> := class<concrete> {
    # Event which fires when the per agent cooldown expires. Sends the agent which was previously affected by the cooldown.
    ExpiredEvent<native><public>: listenable(agent) = external {}

    @editable
    # The duration in seconds after a successful interaction, before the interacting agent can initiate a subsequent interaction.
    # This is only used if the duration is greater than 0.0. Modifying this does not affect any RemainingPerAgentCooldownDuration.
    # This property gives other agents time to interact, when there is a limited number of Simultaneous Interactors.
    var Duration<native><public>: float = external {}

    # The cooldown remaining, in seconds, before a particular agent is able to initiate an interaction on this component.
    var<private> RemainingDuration<native><public>: [agent]float = external {}
  }

  # Used to set an interaction duration.
  interactable_duration<native><public> := class<concrete> {
    # Returns an agent’s remaining duration, in seconds, for interaction. Fails if the agent is not interacting with this component.Returns the same value when called multiple times within a transaction.
    GetRemainingInteractDurationForAgent<final><native><public>(Agent: agent)<reads><decides>: float

    # Sets an agent’s remaining duration, in seconds, for interaction. Fails if the agent is not interacting with this component.
    SetRemainingInteractDurationForAgent<final><native><public>(Agent: agent, RemainingDuration: float)<transacts>: void

    @editable
    # The number of seconds an agent must spend interacting with the object to successfully complete an interaction.
    # 0.0 or less results in an immediate successful interaction.
    # If set during an interaction, the value given will be used for the next interaction and the remaining duration will be updated subtracting the new given value with the current time elapsed.
    # If the subtraction were zero or less it will immediately conclude.
    var InteractDuration<public>: float = external {}

    @editable
    # The max number of simultaneous interactors. A value of false is unlimited.  This value represents how many agents may have active interactions.
    # If this changes to a value less than the current number of active interactions, those interactions are not canceled but new interactions will not start.
    var MaxSimultaneousInteractors<public>: ?int = external {}
  }

  # Used to set a limit of times to interact.
  interactable_success_limit<native><public> := class<concrete> {
    # Resets the counter for the times this component has had a successful interaction.
    ClearSuccessfulInteractionCount<native><public>()<transacts>: void

    # The number of times the component can be successfully interacted with. A value of false is unlimited.
    # When SuccessfulInteractionCount reaches MaxSuccessfulInteractions all active interactions are canceled, and the component cannot be interacted with.
    var MaxSuccessfulInteractions<public>: ?int = external {}

    # The number of times this component has had a successful interaction.
    var SuccessfulInteractionCount<public>: int = external {}
  }

  # Base class for light components in the SceneGraph.
  #
  # Dependencies:
  #   * `transform_component` on the entity positions the light.
  #
  # Examples of components implementing `light_component`:
  #   * `directional_light_component`
  #   * `capsule_light_component`
  #   * `sphere_light_component`
  #   * `rect_light_component`
  #   * `spot_light_component`
  light_component<native><public> := class<abstract><final_super><epic_internal>(component, enableable) {
    # Disables rendering of this light.
    Disable<native><override>(): void

    # Enables rendering of this light.
    Enable<native><override>(): void

    # Succeeds if the component is enabled, fails if it's disabled.
    IsEnabled<native><override>()<transacts><decides>: void

    # Whether the light should cast any shadows.
    var CastShadows<public>: logic = external {}

    # Set the filter color of the light. This acts as a colored filter in front of the light source. Note that this can change the light's effective intensity. In normalized range 0-1.
    var ColorFilter<public>: color = external {}

    # Multiplier on diffuse lighting. Any value besides 1.0 is not physical. 0.0 means no diffuse contribution from this light.
    var DiffuseScale<public>: float = external {}

    # Multiplier on specular highlights. Can be used to artistically remove highlights mimicking polarizing filters or photo touch up. Any value besides 1.0 is not physical. 0.0 means no specular contribution from this light.
    var SpecularScale<public>: float = external {}
  }

  # Used to render a `mesh` at the location of this entity. A mesh is a set of polygons that can be used to represent shapes in the world such as:
  #   * foliage and terrain decorations
  #   * movers (for example, doors and lifts)
  #   * procedurally created buildings
  #
  # Dependencies:
  #   * `transform_component` on the entity positions the mesh.
  mesh_component<native><public> := class<final_super><epic_internal>(component, enableable) {
    # Disables rendering of this mesh.
    Disable<native><override>(): void

    # Enables rendering of this mesh.
    Enable<native><override>(): void

    # Triggered at the beginning of each tick when another entity first overlaps this entity.
    EntityEnteredEvent<native><public>: listenable(entity) = external {}

    # Triggered at the beginning of each tick when another entity is no longer overlapping this entity
    EntityExitedEvent<native><public>: listenable(entity) = external {}

    # Succeeds if the component is enabled, fails if it's disabled.
    IsEnabled<native><override>()<transacts><decides>: void

    # Enable/disable collision on this mesh. If enabled, meshes may collide in the physics simulation.
    var Collidable<public>: logic = external {}

    # Enable/disable spatial queries against this mesh. Disabling this field will also disable EntityEnteredEvent/EntityExitedEvent.
    var Queryable<public>: logic = external {}

    # Enable/disable visibility of this mesh.
    var Visible<public>: logic = external {}
  }

  # Interface to provide alternative origin to an entity which is defaulted to its parent. See `transform_component`
  origin<native><public> := interface<epic_internal> {
    GetTransform<native_callable><public>()<transacts>: (/Verse.org/SpatialMath:)transform
  }

  # The results of an overlap query. See entity.FindOverlapHits(). We will get one overlap_hit for each intersection of any volume in SourceVolumes with any other volume.
  overlap_hit<native><public> := struct<epic_internal> {
    # The source component and volume (query input). For compound inputs (like an entity hierarchy) this will be a component/volume in that hierarchy. The SourceTransform is the transform of SourceVolume used for the overlap test. For single volume inputs like a sphere, the Source volume and transform are just the inputs to the overlap test, and the component is false.
    SourceComponent<native><public>: ?component

    # The source volume transform
    SourceGlobalTransform<native><public>: (/Verse.org/SpatialMath:)transform

    # The source volume (query input)
    SourceVolume<native><public>: collision_volume

    # The component that was hit by SourceVolume
    TargetComponent<native><public>: component

    # The volume that was hit by SourceVolume
    TargetVolume<native><public>: collision_element
  }

  # Used to spawn a `particle_system` at the location of this entity. The `particle_system` will simulate while the `particle_system_component` is in the scene.
  #
  # Dependencies:
  #   * `transform_component` on the entity positions the `particle_system`.
  particle_system_component<native><public> := class<final_super><epic_internal>(component, enableable) {
    # Disables the simulation and rendering of this `particle_system`.
    Disable<override><native>(): void

    # Enables the simulation and rendering of this `particle_system`.
    Enable<override><native>(): void

    # Succeeds if the component is enabled, fails if it’s disabled.
    IsEnabled<override><native>()<transacts><decides>: void

    Play<native><public>(): void

    Stop<native><public>(): void

    @editable
    # Controls if the `particle_system_component` should play the simulation automatically when added to the scene, or when enabled from a disabled state.
    var<private> AutoPlay<native><public>: logic = external {}

    @editable
    # Controls if the `particle_system_component` should start enabled.
    var<private> Enabled<native><public>: logic = external {}
  }

  # A `rect_light_component` emits light into the scene from a rectangular plane with a specified width and height. You can use these
  # to simulate any kind of light sources that have rectangular areas, such as televisions or monitor screens, overhead lighting
  # fixtures, or wall sconces.
  rect_light_component<native><public> := class<final>(light_component) {
    # The bounds of the light's visible influence, in centimeters. This clamping of the light's influence is not physically correct but very important for performance,
    # larger lights cost more. The light falloff is based on Inverse Square law. Towards the tail end of the AttenuationRadius,
    # there is an additional smoothing factor to fade out the light contribution to 0 to avoid a hard cutoff.
    var AttenuationRadius<public>: ?float = external {}

    # The angle of the barn door in degrees attached to the light source rect. Clamped between 0.0 and 90.0 degrees.
    var BarnDoorAngleDegrees<public>: float = external {}

    # The length of the barn door attached to the light source rect, in centimeters.
    var BarnDoorLength<public>: float = external {}

    # Set the visible light intensity emitted in SI unit Candela.
    # Specified before ColorFilter (which multiplies each color component after the intensity calculation and can change the effective intensity of the light).
    var Intensity<public>: float = external {}

    # The height of the light source rect, in centimeters. Note that light source's shapes which intersect shadow casting geometry can cause shadowing artifacts.
    var SourceHeight<public>: float = external {}

    # The width of the light source rect, in centimeters. Note that light source shapes which intersect shadow casting geometry can cause shadowing artifacts.
    var SourceWidth<public>: float = external {}
  }

  @experimental
  # An event which can be sent through the scene graph.
  scene_event<native><public> := interface {}

  sound_component<native><public> := class<abstract><final_super><epic_internal>(component, enableable) {
    # Disable the sound component.
    Disable<override><native>(): void

    # Enable the sound component.
    Enable<override><native>(): void

    # Succeeds if the sound component is enabled, fails if it is disabled.
    IsEnabled<override><native>()<transacts><decides>: void

    # Play the sound asset
    Play<native><public>(): void

    # Stop the sound asset
    Stop<native><public>(): void

    @editable
    var<private> AutoPlay<native><public>: logic = external {}

    @editable
    var<private> Enabled<native><public>: logic = external {}
  }

  # A `sphere_light_component` emits light in all directions into the scene from a spherical source shape with a specified radius. A radius of 0 makes it a point light. You can use these
  # to simulate any kind of light sources that emit in all directions, such as a light bulb.
  sphere_light_component<native><public> := class<final>(light_component) {
    # The bounds of the light's visible influence, in centimeters. This clamping of the light's influence is not physically correct but very important for performance,
    # larger lights cost more. The light falloff is based on Inverse Square law. Towards the tail end of the AttenuationRadius,
    # there is an additional smoothing factor to fade out the light contribution to 0 to avoid a hard cutoff.
    var AttenuationRadius<public>: ?float = external {}

    # Set the visible light intensity emitted in SI unit Candela.
    # Specified before ColorFilter (which multiplies each color component after the intensity calculation and can change the effective intensity of the light).
    var Intensity<public>: float = external {}

    # Radius of the source shape, in centimeters. Note that light shapes which intersect shadow casting geometry can cause shadowing artifacts.
    var SourceRadius<public>: float = external {}
  }

  # A `spot_light_component` emits light from a single point in a cone shape. The shape of the light is defined by two cones: the `InnerConeAngleDegrees`
  # and `OuterConeAngleDegrees`. Within the `InnerConeAngleDegrees` the light achieves full brightness. As you go from the extent of the inner radius to the
  # extents of the `OuterConeAngleDegrees` a falloff takes place, creating a penumbra, or softening around the `spot_light_component`'s disc of
  # illumination. The Radius of the light defines the length of the cones. More simply, this will work like a flash light or stage can light.
  spot_light_component<native><public> := class<final>(light_component) {
    # The bounds of the light's visible influence, in centimeters. This clamping of the light's influence is not physically correct but very important for performance,
    # larger lights cost more. The light falloff is based on Inverse Square law. Towards the tail end of the AttenuationRadius,
    # there is an additional smoothing factor to fade out the light contribution to 0 to avoid a hard cutoff.
    var AttenuationRadius<public>: ?float = external {}

    # The light's inner cone shaped angle in degrees. Clamped between 0.0 and 80.0.
    var InnerConeAngleDegrees<public>: float = external {}

    # Set the visible light intensity emitted in SI unit Candela.
    # Specified before ColorFilter (which multiplies each color component after the intensity calculation and can change the effective intensity of the light).
    var Intensity<public>: float = external {}

    # The light's outer cone shaped angle in degrees. Clamped between 1.0 and 80.0.
    var OuterConeAngleDegrees<public>: float = external {}

    # Radius of the source shape, in centimeters. Note that light shapes which intersect shadow casting geometry can cause shadowing artifacts.
    var SourceRadius<public>: float = external {}
  }

  # The results of a sweep query. See entity.FindSweepHits(). We will get one sweep_hit for each intersection of any volume in SourceVolumes with any other volume.
  sweep_hit<native><public> := struct<epic_internal> {
    # If TargetVolume is a polygonal object (mesh, convex hull, etc.) and the contact point is on an edge or vertex, this is the most-opposing face normal of the faces that share that edge or vertex. Otherwise it is the same as HitNormal.
    ContactFaceNormal<native><public>: (/Verse.org/SpatialMath:)vector3 = external {}

    # The normal on TargetVolume at the HitPosition.
    ContactNormal<native><public>: (/Verse.org/SpatialMath:)vector3 = external {}

    # The point of contact between SourceVolume and TargetVolume.
    ContactPosition<native><public>: (/Verse.org/SpatialMath:)vector3 = external {}

    # The source component and volume (query input). For compound inputs (like an entity hierarchy) this will be a component/volume in that hierarchy. The SourceGlobalTransform is the transform of SourceVolume at the start of the sweep. For single volume inputs like a sphere, the volume and transform are just the inputs to the sweep, and the component is false.
    SourceComponent<native><public>: ?component

    # The Distance along the sweep at which SourceVolume touches TargetVolume.
    SourceHitDistance<native><public>: float = external {}

    # The world-space translation (relative to SourceStartGlobalTransform) of SourceVolume when it touches TargetVolume.
    SourceHitTranslation<native><public>: (/Verse.org/SpatialMath:)vector3 = external {}

    # The source volume transform at the start of the sweep.
    SourceStartGlobalTransform<native><public>: (/Verse.org/SpatialMath:)transform

    # The source volume (query input).
    SourceVolume<native><public>: collision_volume

    # The component that was hit by SourceVolume.
    TargetComponent<native><public>: component

    # The volume that was hit by SourceVolume.
    TargetVolume<native><public>: collision_element
  }

  @experimental
  # Used to add tags to an entity. Tagged entities can then be queried using `entity.FindDescendantEntitiesWithTag` and `entity.FindAncestorEntitiesWithTag`.
  #   * Finding entities from the simulation entity for tagged entities only considers any `tag_component` that has run `OnAddedToScene`.
  tag_component<native><public> := class<final><final_super>(component, tag_view) {
    # Adds a tag to this component. Returns `true` if the tag was not present before being added.
    AddTag<native><public>(TagToAdd: tag)<transacts>: logic

    # Determine if TagToCheck is present in this container, also checking against parent tags {"A.1"}.Has("A") will return True, {"A"}.Has("A.1") will return False If TagToCheck is not Valid it will always return False.
    Has<native><override>(TagToCheck: tag)<reads><decides>: void

    # Checks if this container contains ALL of the tags in the specified container, also checks against parent tags {"A.1","B.1"}.HasAll({"A","B"}) will return True, {"A","B"}.HasAll({"A.1","B.1"}) will return False If InTags is empty/invalid it will always return True, because there were no failed checks.
    HasAll<native><override>(InTags: []tag)<reads><decides>: void

    # Checks if this container contains ANY of the tags in the specified container, also checks against parent tags {"A.1"}.HasAny({"A","B"}) will return True, {"A"}.HasAny({"A.1","B"}) will return False If InTags is empty/invalid it will always return False.
    HasAny<native><override>(InTags: []tag)<reads><decides>: void

    # Removes a tag from this component. Returns `true` if the tag was present before being removed.
    RemoveTag<native><public>(TagToRemove: tag)<transacts>: logic
  }

  # Describes discrete phases of a frame update. Subscribe to members of the tick_events object to run code before or after the physics system has updated your object, allowing you to affect or react to these updates.
  tick_events<native><public> := class<epic_internal> {
    # Listen `PostPhysics` to run your code after the physics system has updated your object this frame.
    PostPhysics<native><public>: execution_listenable = external {}

    # Listen `PrePhysics` to run your code before the physics system has updated your object this frame.
    PrePhysics<native><public>: execution_listenable = external {}
  }

  # Stores the transforms for an entity, which are used to position the entity.
  transform_component<native><public> := class<final><final_super>(component) {
    # Current transform of the entity, globally referenced. Any value set at construction will be overrridden with the calculation from the Local Transform
    var GlobalTransform<public>: (/Verse.org/SpatialMath:)transform = external {}

    # LocalTransform to its parent/origin
    var LocalTransform<public>: (/Verse.org/SpatialMath:)transform = external {}

    # alternate origin than the default parent entity
    var Origin<public>: ?origin = external {}
  }
}

Simulation<public> := module {
  @available { MinUploadedAtFNVersion := 3800 }
  (Session: session).Environment<native><public>()<transacts>: session_environment

  # Returns the `session` corresponding to the current round.  The result can be used with `weak_map` to implement global variables.
  # Note: may be changed in a future release to return a single instance per game. Round-local behavior should not be relied upon.
  GetSession<native><public>()<reads>: session

  # Get the seconds that have elapsed since the world began simulating
  GetSimulationElapsedTime<native><public>()<transacts>: float

  (/Verse.org/Simulation:)MakeLocalizableValue<epic_internal>(Agent: agent): localizable_agent = external {}

  # Waits specified number of seconds and then resumes. If `Seconds` = 0.0 then it waits until next tick/frame/update. If `Seconds` = Inf then it waits forever and only calls back if canceled - such as via `race`. If `Seconds` < 0.0 then it completes immediately and does not yield to other aysnc expressions.
  # Waiting until the next update (0.0) is especially useful in a loop of a coroutine that needs to do some work every update and this yields to other coroutines so that it doesn't hog a processor's resources.
  # Waiting forever (Inf) will have any expression that follows never be evaluated. Occasionally it is desireable to have a task never complete such as the last expression in a `race` subtask where the task must never win the race though it still may be canceled earlier.
  # Immediately completing (less than 0) is useful when you want programmatic control over whether an expression yields or not.
  Sleep<native><public>(Seconds: float)<suspends>: void

  # Module import path: /Verse.org/Simulation/Tags
  Tags<public> := module {
    # A single gameplay tag, which represents a hierarchical name of the form x.y that is registered in the GameplayTagsManager You can filter the gameplay tags displayed in the editor.
    tag<native><public> := class<abstract><castable> {}

    # Advanced tag search criteria
    tag_search_criteria<native><public> := class {
      # Tags that may NOT be on the object. All items with these tags are excluded from the search.
      ExclusionTags<native><public>: []tag = external {}

      # Tags that are used if no required tags are specified. These are treated as if any of them will do.
      PreferredTags<native><public>: []tag = external {}

      # Tags required to be on the object.
      RequiredTags<native><public>: []tag = external {}

      # Flag to request sorting the results by tag.
      SortType<native><public>: tag_search_sort_type = external {}
    }

    tag_search_sort_type<native><public> := enum {
      Sorted

      Unsorted
    }

    # A queryable collection of gameplay tags.
    tag_view<native><public> := interface<epic_internal> {
      # Determine if TagToCheck is present in this container, also checking against parent tags {"A.1"}.Has("A") will return True, {"A"}.Has("A.1") will return False If TagToCheck is not Valid it will always return False.
      Has<public>(TagToCheck: tag)<reads><decides>: void

      # Checks if this container contains ALL of the tags in the specified container, also checks against parent tags {"A.1","B.1"}.HasAll({"A","B"}) will return True, {"A","B"}.HasAll({"A.1","B.1"}) will return False If InTags is empty/invalid it will always return True, because there were no failed checks.
      HasAll<public>(InTags: []tag)<reads><decides>: void

      # Checks if this container contains ANY of the tags in the specified container, also checks against parent tags {"A.1"}.HasAny({"A","B"}) will return True, {"A"}.HasAny({"A.1","B"}) will return False If InTags is empty/invalid it will always return False.
      HasAny<public>(InTags: []tag)<reads><decides>: void
    }
  }

  using { /Verse.org/SceneGraph }
  agent<native><public> := class<unique><epic_internal>(entity) {}

  @attribscope_class
  @attribscope_struct
  @attribscope_data
  @customattribhandler
  editable<public> := class<computes>(attribute) {
    # The categories displayed in the editor.
    Categories<public>: []message = external {}

    # The tooltip displayed in the editor.
    ToolTip<public>: message = external {}
  }

  @attribscope_class
  @attribscope_struct
  @attribscope_data
  @customattribhandler
  editable_container<public> := class<final><computes>(editable) {
    # If true, allows reordering of the container elements in the editor.
    AllowReordering<public>: logic = external {}
  }

  @attribscope_class
  @attribscope_struct
  @attribscope_data
  @customattribhandler
  editable_number<public>(t: type) := class<final><computes>(editable) {
    # The maximum value the editor allows.
    MaxValue<public>: ?t = external {}

    # The minimum value the editor allows.
    MinValue<public>: ?t = external {}

    (/Verse.org/Simulation/editable_number:)Simulation_editable_number_Variance<private>: ?type { _(): tuple(t) } = external {}

    # Snap the spinbox to the nearest delta.
    SpinBoxDelta<public>: ?t = external {}
  }

  @attribscope_class
  @attribscope_struct
  @attribscope_data
  @customattribhandler
  editable_slider<public>(t: type) := class<final><computes>(editable) {
    # The maximum value of the editor slider.
    MaxValue<public>: ?t = external {}

    # The minimum value of the editor slider.
    MinValue<public>: ?t = external {}

    # Used to change how sensitive the field value is when moving the slider via mouse cursor.
    MouseLinearDeltaSensitivity<public>: float = external {}

    MouseShiftMovePixelPerDelta<public>: float = external {}

    (/Verse.org/Simulation/editable_slider:)Simulation_editable_slider_Variance<private>: ?type { _(): tuple(t) } = external {}

    # The amount the slider moves for each step.
    SliderDelta<public>: ?t = external {}

    # Used to scale a slider exponentially. Common values are found within the range of 1-20.
    SliderExponent<public>: ?t = external {}
  }

  @attribscope_class
  @attribscope_struct
  @attribscope_data
  @customattribhandler
  editable_text_box<public> := class<final><computes>(editable) {
    # The maximum length of the text.
    MaxLength<public>: int = external {}

    # True if the editor text box should support multiple lines.
    MultiLine<public>: logic = external {}
  }

  @attribscope_class
  @attribscope_struct
  @attribscope_data
  @customattribhandler
  editable_vector_number<public>(t: type) := class<final><computes>(editable) {
    # The maximum value allowed for each vector element.
    MaxComponentValue<public>: ?t = external {}

    # The minimum value allowed for each vector element.
    MinComponentValue<public>: ?t = external {}

    # Show the button that allows normalizing the vector.
    ShowNormalize<public>: logic = external {}

    # Show the button that allows locking the vector aspect ratio.
    ShowPreserveRatio<public>: logic = external {}

    (/Verse.org/Simulation/editable_vector_number:)Simulation_editable_vector_number_Variance<private>: ?type { _(): tuple(t) } = external {}

    # Snap the spinbox to the nearest delta.
    SpinBoxDelta<public>: ?t = external {}
  }

  @attribscope_class
  @attribscope_struct
  @attribscope_data
  @customattribhandler
  editable_vector_slider<public>(t: type) := class<final><computes>(editable) {
    # The maximum value allowed for each vector element.
    MaxComponentValue<public>: ?t = external {}

    # The minimum value allowed for each vector element.
    MinComponentValue<public>: ?t = external {}

    # Used to change how sensitive the field value is when moving the slider via mouse cursor.
    MouseLinearDeltaSensitivity<public>: float = external {}

    MouseShiftMovePixelPerDelta<public>: float = external {}

    # Show the button that allows normalizing the vector.
    ShowNormalize<public>: logic = external {}

    # Show the button that allows locking the vector aspect ratio.
    ShowPreserveRatio<public>: logic = external {}

    (/Verse.org/Simulation/editable_vector_slider:)Simulation_editable_vector_slider_Variance<private>: ?type { _(): tuple(t) } = external {}

    # The amount the slider moves for each step.
    SliderDelta<public>: ?t = external {}

    # Used to scale a slider exponentially. Common values are found within the range of 1-20.
    SliderExponent<public>: ?t = external {}
  }

  localizable_agent<native><epic_internal> := class(localizable_value) {}

  player<native><public> := class<unique><persistent><module_scoped_var_weak_map_key><epic_internal>(agent) {
    # Succeeds when this `player` may be used as a module-scoped `var` `weak_map` key. This coincides with the corresponding player having joined the game and not yet left. Using a `player` as a module-scope `var` `weak_map` key when this method fails results in a runtime error.
    IsActive<native><public>()<reads><decides>: void
  }

  using { /Verse.org/Native }
  # Type for which there is a single instance per round.  Use `GetSession` to get the current round's `session` instance. May be used with `weak_map` to implement global variables.
  # Note: may be changed in a future release to a single instance per game. Round-local behavior should not be relied upon.
  session<native><public> := class<unique><module_scoped_var_weak_map_key><epic_internal> {}

  # Specifies what type of environment the current session is in.
  session_environment<native><public> := enum {
    # The current session is in an Edit environment for an experience, such as a session started within UEFN.
    Edit

    # The current session is in a Live environment for an experience.
    Live

    # The current session is in a Private environment for an experience, such as a playtest.
    Private
  }

  team<native><public> := class<unique><epic_internal> {}
}

# Module import path: /Verse.org/SpatialMath
SpatialMath<public> := module {
  # Returns `Rotation` if it does not contain `NaN`, `Inf` or `-Inf`.
  (Rotation: rotation).(/Verse.org/SpatialMath:)IsFinite<native><public>()<decides><converges>: rotation

  @available { MinUploadedAtFNVersion := 3600 }
  # Degrees version of GetAngleRadians
  (Rotation: rotation).GetAngleDegrees<public>()<reads>: float = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  @vm_no_effect_token
  # Returns the radians of right-handed `rotation` around the axis of `rotation`. See also `GetAxis`.
  (Rotation: rotation).GetAngleRadians<native><public>()<reads><converges>: float

  @vm_no_effect_token
  # Makes a `vector3` from the axis of `rotation` for an right-handed angle.
  # If `rotation` is nearly identity, this will return the +Forward axis. See also `GetAngleRadians`.
  (Rotation: rotation).GetAxis<native><public>()<reads><converges>: vector3

  @available { MinUploadedAtFNVersion := 3600 }
  # Degrees version of `GetEulerRadians`.
  (Rotation: rotation).GetEulerDegrees<public>()<reads>: tuple(float, float, float) = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  @vm_no_effect_token
  # Makes a `tuple(float, float, float)` with three elements:
  #  * *left axis* `rotation` in radians
  #  * *up axis* of `rotation` in radians
  #  * *forward axis* of `rotation` in radians
  # using the conventions of `MakeRotationEulerRadians`.
  (Rotation: rotation).GetEulerRadians<native><public>()<reads><converges>: tuple(float, float, float)

  # Makes a unit `vector3` pointing in the *forward* rotated direction.
  # This is equivalent to: `vector3{Forward:=1.0, Left:=0.0, Up:=0.0} * Rotation`.
  (Rotation: rotation).GetForwardAxis<public>()<reads>: vector3 = external {}

  # Makes a unit `vector3` pointing in the *left* rotated direction.
  # This is equivalent to: `vector3{Forward:=0.0, Left:=1.0, Up:=0.0} * Rotation`.
  (Rotation: rotation).GetLeftAxis<public>()<reads>: vector3 = external {}

  # Makes a unit `vector3` pointing in the *up* rotated direction.
  # This is equivalent to: `vector3{Forward:=0.0, Left:=0.0, Up:=1.0} * Rotation`.
  (Rotation: rotation).GetUpAxis<public>()<reads>: vector3 = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  @vm_no_effect_token
  # Degrees version of `GetYawPitchRollRadians`.
  (Rotation: rotation).GetYawPitchRollDegrees<native><public>()<reads><converges>: tuple(float, float, float)

  @available { MinUploadedAtFNVersion := 3600 }
  # Makes a `tuple(float, float, float)` with three elements:
  #  * *yaw* of `rotation` in radians
  #  * *pitch* of `rotation` in radians
  #  * *roll* of `rotation` in radians
  # using the conventions of `MakeRotationFromYawPitchRollRadians`.
  (Rotation: rotation).GetYawPitchRollRadians<public>()<reads>: tuple(float, float, float) = external {}

  @vm_no_effect_token
  # Makes a `rotation` by inverting `Rotation` such that `ApplyRotation(Rotation, Rotation.Invert())) = IdentityRotation`.
  (Rotation: rotation).Invert<native><public>()<reads><converges>: rotation

  # Succeeds when each component of `V` is within `AbsoluteTolerance` of `0.0`.
  (V: vector3).(/Verse.org/SpatialMath:)IsAlmostZero<public>(AbsoluteTolerance: float)<computes><decides>: void = external {}

  # Returns `V` if all components are finite.
  # Fails if any of the components are not finite.
  (V: vector3).(/Verse.org/SpatialMath:)IsFinite<public>()<computes><decides>: vector3 = external {}

  # Returns the length of `V`.
  (V: vector3).Length<public>()<reads>: float = external {}

  # Returns the length of `V` as if `V.Up = 0.0`.
  (V: vector3).LengthForwardLeft<public>()<reads>: float = external {}

  # Returns the squared length of `V`.
  (V: vector3).LengthSquared<public>()<computes>: float = external {}

  # Returns the squared length of `V` as if `V.Up = 0.0`.
  (V: vector3).LengthSquaredForwardLeft<public>()<reads>: float = external {}

  # Makes a unit length `vector3` pointing in the same direction of `V`.
  (V: vector3).MakeUnitVector<public>()<reads>: vector3 = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  # Degrees version of `AngularDistanceRadians`.
  AngularDistanceDegrees<public>(Rotation1: rotation, Rotation2: rotation)<reads>: float = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  @vm_no_effect_token
  # Returns the smallest angular distance between `Rotation1` and `Rotation2` in radians.
  AngularDistanceRadians<native><public>(Rotation1: rotation, Rotation2: rotation)<reads><converges>: float

  @available { MinUploadedAtFNVersion := 3600 }
  # Returns the right-handed cross product of `V1` and `V2`.
  CrossProduct<public>(V1: vector3, V2: vector3)<reads>: vector3 = external {}

  # Returns the left-handed cross product of `V1` and `V2`.
  CrossProductLeftHanded<public>(V1: vector3, V2: vector3)<reads>: vector3 = external {}

  # Returns radians from `Degrees`.
  DegreesToRadians<public>(Degrees: float)<reads>: float = external {}

  @vm_no_effect_token
  # Returns the distance between `Rotation1` and `Rotation2`. The result will be between:
  #  * `0.0`, representing equivalent rotations and
  #  * `1.0` representing rotations which are 180 degrees apart (i.e., the shortest rotation between them is 180 degrees around some axis).
  Distance<native><public>(Rotation1: rotation, Rotation2: rotation)<reads><converges>: float

  # Returns the Euclidean distance between `V1` and `V2`.
  Distance<public>(V1: vector3, V2: vector3)<reads>: float = external {}

  # Returns the 2-D Euclidean distance between `V1` and `V2` by ignoring the difference in `Up`.
  DistanceForwardLeft<public>(V1: vector3, V2: vector3)<reads>: float = external {}

  # Returns the squared Euclidean distance between `V1` and `V2`.
  DistanceSquared<public>(V1: vector3, V2: vector3)<reads>: float = external {}

  # Returns the squared 2-D Euclidean distance between `V1` and `V2` by ignoring their difference in `Up`.
  DistanceSquaredForwardLeft<public>(V1: vector3, V2: vector3)<reads>: float = external {}

  # Returns the dot product of `V1` and `V2`.
  DotProduct<public>(V1: vector3, V2: vector3)<reads>: float = external {}

  # Makes the identity `rotation`.
  IdentityRotation<native><public>()<converges>: rotation

  # Succeeds when each component of `V1` and `V2` are within `AbsoluteTolerance` of each other.
  (/Verse.org/SpatialMath:)IsAlmostEqual<public>(V1: vector3, V2: vector3, AbsoluteTolerance: float)<computes><decides>: void = external {}

  # Used to linearly interpolate/extrapolate between `From` (when `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that all arguments are finite.
  # Returns `From*(1 - Parameter) + To*Parameter`.
  (/Verse.org/SpatialMath:)Lerp<public>(From: vector3, To: vector3, Parameter: float)<reads>: vector3 = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  # Degrees version of `MakeRotationRadians`
  MakeRotationDegrees<public>(Axis: vector3, Angle: float)<reads>: rotation = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  # Degrees version of `MakeRotationFromEulerRadians`
  MakeRotationFromEulerDegrees<public>(
    LeftAxisAngle: float,
    UpAxisAngle: float,
    ForwardAxisAngle: float
  )<reads>: rotation = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  @vm_no_effect_token
  # Makes a `rotation` by applying a post-rotation of `LeftAxisAngle` followed by `UpAxisAngle` and then `ForwardAxisAngle `in that order. Right-handed convention (e.g. a positive rotation around Up takes +Forward to Left).
  MakeRotationFromEulerRadians<native><public>(
    LeftAxisAngle: float,
    UpAxisAngle: float,
    ForwardAxisAngle: float
  )<reads><converges>: rotation

  @vm_no_effect_token
  # Degrees version of `MakeRotationFromYawPitchRollRadians`
  MakeRotationFromYawPitchRollDegrees<native><public>(
    YawAngle: float,
    PitchAngle: float,
    RollAngle: float
  )<reads><converges>: rotation

  @available { MinUploadedAtFNVersion := 3600 }
  # Makes a `rotation` by applying a pre-rotation of `YawAngle` followed by `PitchAngle` and then `RollAngle`, in that order:
  #  * *yaw* is right-handed rotation about the Down axis,
  #  * *pitch* is right-handed rotation about the Right axis,
  #  * *roll* is right-handed rotation about the Forward axis.
  MakeRotationFromYawPitchRollRadians<public>(
    YawAngle: float,
    PitchAngle: float,
    RollAngle: float
  )<reads>: rotation = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  @vm_no_effect_token
  # Makes a `rotation` from `Axis` and `Angle` in radians using a right-handed sign convention (e.g. a positive rotation around Up takes Forward to Left).
  MakeRotationRadians<native><public>(Axis: vector3, Angle: float)<reads><converges>: rotation

  @vm_no_effect_token
  # Makes the smallest angular `rotation` from `InitialVector` to `FinalVector` two vectors of arbitrary length such that:
  # `InitialVector * MakeShortestRotationBetween(InitialVector, FinalVector) = FinalVector` and
  # `MakeShortestRotationBetween(InitialVector, FinalVector)?.GetAngleRadians()` is as small as possible.
  MakeShortestRotationBetween<native><public>(InitialVector: vector3, FinalVector: vector3)<reads><converges>: rotation

  # Returns degrees from `Radians`.
  RadiansToDegrees<public>(Radians: float)<reads>: float = external {}

  # Makes a `vector3` by inverting the `SurfaceNormal` component of `Direction`.
  ReflectVector<public>(Direction: vector3, SurfaceNormal: vector3)<reads>: vector3 = external {}

  @vm_no_effect_token
  # Used to perform spherical linear interpolation between `From` (when `Ratio = 0.0`) and `To` (when `Ratio = 1.0`). Expects `0.0 <= Ratio <= 1.0`.
  Slerp<native><public>(InitialRotation: rotation, FinalRotation: rotation, Ratio: float)<reads><converges>: rotation

  # Makes a `string` representation of `InTransform` where the result is on the form.
  # `"{Translation = {ToString(`InTransform.Translation`)}, Rotation = {ToString(`InTransform.Rotation`)}, Scale = {ToString(`InTransform.Scale`)}}".
  (/Verse.org/SpatialMath:)ToString<public>(InTransform: transform)<reads>: string = external {}

  # Makes a `string` representation of `rotation` in axis/degrees format with a right-handed sign convention.
  # `ToString(MakeRotationRadians(vector3{Left:=0.0, Up:=0.0, Forward:=1.0}, PiFloat/2.0))` produces the string: `"{Axis = {Left=0.000000, Up=0.000000, Forward=1.000000}, Angle = 90.000000}"`.
  (/Verse.org/SpatialMath:)ToString<public>(Rotation: rotation)<reads>: string = external {}

  # Makes a `string` representation of `V`.
  (/Verse.org/SpatialMath:)ToString<public>(V: vector3)<reads>: string = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  @vm_no_effect_token
  # Apply a `PreRotation` to `PostRotation` as `v * PreRotation * PostRotation`.
  (/Verse.org/SpatialMath:)operator'*'<native><public>(PreRotation: rotation, PostRotation: rotation)<reads><converges>: rotation

  @vm_no_effect_token
  # Makes a `vector3` by applying `Rotation` to `Vector`.
  (/Verse.org/SpatialMath:)operator'*'<native><public>(Vector: vector3, Rotation: rotation)<reads><converges>: vector3

  # Makes a `vector3` by applying `InTransform` to `InVector`.
  (/Verse.org/SpatialMath:)operator'*'<public>(InVector: vector3, InTransform: transform)<reads>: vector3 = external {}

  # Makes a `vector3` by multiplying the components of `Right` by `Left`.
  (/Verse.org/SpatialMath:)operator'*'<public>(Left: float, Right: vector3)<computes>: vector3 = external {}

  # Makes a `vector3` by multiplying the components of `Left` by `Right`.
  (/Verse.org/SpatialMath:)operator'*'<public>(Left: vector3, Right: float)<computes>: vector3 = external {}

  # Makes a `vector3` by component-wise multiplication of `Left` and `Right`.
  (/Verse.org/SpatialMath:)operator'*'<public>(Left: vector3, Right: vector3)<computes>: vector3 = external {}

  # Makes a `vector3` by component-wise addition of `Left` and `Right`.
  (/Verse.org/SpatialMath:)operator'+'<public>(Left: vector3, Right: vector3)<computes>: vector3 = external {}

  # Makes a `vector3` by component-wise subtraction of `Right` from `Left`.
  (/Verse.org/SpatialMath:)operator'-'<public>(Left: vector3, Right: vector3)<computes>: vector3 = external {}

  # Makes a `vector3` by dividing the components of `Left` by `Right`.
  (/Verse.org/SpatialMath:)operator'/'<public>(Left: vector3, Right: float)<computes>: vector3 = external {}

  # Makes a `vector3` by component-wise division of `Left` by `Right`.
  (/Verse.org/SpatialMath:)operator'/'<public>(Left: vector3, Right: vector3)<computes>: vector3 = external {}

  # Makes a `vector3` by inverting the signs of `Operand`.
  (/Verse.org/SpatialMath:)prefix'-'<public>(Operand: vector3)<computes>: vector3 = external {}

  using { /Verse.org/Native }
  using { /Verse.org/Simulation }
  @import_as("/*.FVRotation")
  rotation<native><public> := struct<concrete> {}

  @import_as("/*.FVTransform")
  # A combination of scale, rotation, and translation, applied in that order.
  transform<native><public> := struct<concrete><computes> {
    @editable
    # The rotation of this `transform`.
    Rotation<public>: rotation = external {}

    @editable
    # The scale of this `transform`.
    Scale<public>: vector3 = external {}

    @editable
    # The location of this `transform`.
    Translation<public>: vector3 = external {}
  }

  @import_as("/*.FVVector3")
  # 3-dimensional vector with `float` components.
  vector3<native><public> := struct<concrete><computes><persistable> {
    @editable
    # The Forward (was X) component of this vector.
    Forward<public>: float = external {}

    @editable
    # The Left (was -Y) component of this vector.
    Left<public>: float = external {}

    @editable
    # The Up (was Z) component of this vector.
    Up<public>: float = external {}
  }
}

Verse<public> := module {
  @available { MinUploadedAtFNVersion := 3800 }
  @experimental
  # Succeeds if `element_type` is present in `InSet`.
  (
    InSet: classifiable_subset(t) where t: castable_subtype(k),
    k: type
  ).Contains<public>(element_type: castable_subtype(k))<reads><decides>: void = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  @experimental
  # Succeeds if all the `element_types` are present in `InSet`.
  (
    InSet: classifiable_subset(t) where t: castable_subtype(k),
    k: type
  ).ContainsAll<public>(element_types: []castable_subtype(k))<reads><decides>: void = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  @experimental
  # Succeeds if any of the `element_types` are present in `InSet`.
  (
    InSet: classifiable_subset(t) where t: castable_subtype(k),
    k: type
  ).ContainsAny<public>(element_types: []castable_subtype(k))<reads><decides>: void = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  @experimental
  # Returns a new set that contains all the elements in `InSet` that are of type `element_type`.
  (
    InSet: classifiable_subset(t) where t: castable_subtype(k),
    k: type
  ).FilterByType<native><public>(element_type: castable_subtype(k))<transacts>: classifiable_subset(t)

  # Returns the first index whose element in `Input` equals `ElementToFind`.
  # Fails if ElementToFind does not exist in the array.
  (Input: []t where t: subtype(comparable)).Find<public>(ElementToFind: t)<computes><decides>: int = external {}

  # Makes an `array` by removing all elements that equal `ElementToRemove` from `Input`.
  (Input: []t where t: subtype(comparable)).RemoveAllElements<public>(ElementToRemove: t)<computes>: []t = external {}

  # Makes an `array` by removing the element at the lowest index that equals `ElementToRemove` from `Input`.
  # Fails if `Input` did not contain any instances of `ElementToRemove`.
  (Input: []t where t: subtype(comparable)).RemoveFirstElement<public>(ElementToRemove: t)<computes><decides>: []t = external {}

  # Makes an `array` by replacing all ranges of elements that equal `ElementsToReplace` with `Replacement` in `Input`.
  # When there are multiple overlapping instances of `ElementsToReplace` in `Input`, only the position with the lowest index is replaced.
  (Input: []t where t: subtype(comparable)).ReplaceAll<public>(
    ElementsToReplace: []t,
    Replacement: []t
  )<transacts>: []t = external {}

  # Makes an `array` by replacing all elements that equal `ElementToReplace` with `ElementToReplaceWith` in `Input`.
  (Input: []t where t: subtype(comparable)).ReplaceAllElements<public>(
    ElementToReplace: t,
    ElementToReplaceWith: t
  )<computes>: []t = external {}

  # Makes an `array` by replacing the element at the lowest index that equals `ElementToReplace` with `ElementToReplaceWith` in `Input`.
  # Fails if `Input` did not contain any instances of `ElementToReplace`.
  (Input: []t where t: subtype(comparable)).ReplaceFirstElement<public>(
    ElementToReplace: t,
    ElementToReplaceWith: t
  )<computes><decides>: []t = external {}

  # Makes an `array` by inserting `ElementsToInsert` into `Input` such that the first element of `ElementsToInsert` is at `InsertionIndex`.
  (Input: []t where t: type).Insert<public>(
    InsertionIndex: int,
    ElementsToInsert: []t
  )<computes><decides>: []t = external {}

  # Makes an `array` by removing `Input`'s elements from `StartIndex` to `StopIndex-1`.
  # Succeeds if `0 <= StartIndex <= StopIndex <= Input.Length`.
  (Input: []t where t: type).Remove<public>(StartIndex: int, StopIndex: int)<computes><decides>: []t = external {}

  # Makes an `array` by removing the element at `IndexToRemove` from `Input`.
  # Succeeds if `0 <= IndexToRemove <= Input.Length-1`.
  (Input: []t where t: type).RemoveElement<public>(IndexToRemove: int)<computes><decides>: []t = external {}

  # Makes an `array` by replacing the element at `IndexToReplace` with `ElementToReplaceWith` in `Input`.
  # Succeeds if `0 <= IndexToReplace <= Input.Length-1`.
  (Input: []t where t: type).ReplaceElement<public>(
    IndexToReplace: int,
    ElementToReplaceWith: t
  )<computes><decides>: []t = external {}

  # Makes an `array` containing `Input`'s elements from `StartIndex` to `Input.Length-1`.
  # Succeeds if `0 <= StartIndex <= Input.Length`.
  (Input: []t where t: type).Slice<public>(StartIndex: int)<computes><decides>: []t = external {}

  # Makes an `array` containing `Input`'s elements from `StartIndex` to `StopIndex-1`.
  # Fails unless `0 <= StartIndex <= StopIndex <= Input.Length`.
  (Input: []t where t: type).Slice<public>(StartIndex: int, StopIndex: int)<computes><decides>: []t = external {}

  # Succeeds if `Val` is within `AbsoluteTolerance` of `0.0`.
  (Val: float).IsAlmostZero<public>(AbsoluteTolerance: float)<computes><decides>: void = external {}

  # Returns `X` if `X` is finite.
  # Fails if `X` is one of:`
  #  * `+Inf`
  #  * `-Inf`
  #  * `NaN`
  (X: float).IsFinite<public>()<computes><decides>: float = external {}

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the inverse hyperbolic cosine of `X` if `1.0 <= X`.
  ArCosh<native><public>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the inverse hyperbolic sine of `X` if `IsFinite(X)`.
  ArSinh<native><public>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the inverse hyperbolic tangent of `X` if `IsFinite(X)`.
  ArTanh<native><public>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the inverse cosine (arccosine) of `X` if `-1.0 <= X <= 1.0`.
  ArcCos<native><public>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the inverse sine (arcsine) of `X` if `-1.0 <= X <= 1.0`.
  ArcSin<native><public>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the inverse tangent (arctangent) of `X` such that:`-PiFloat/2.0 <= ArcTan(x) <= PiFloat/2.0`.
  ArcTan<native><public>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the angle in radians at the origin between a ray pointing to `(X, Y)` and the positive `X` axis such that `-PiFloat < ArcTan(Y, X) <= PiFloat`.
  # Returns 0.0 if `X=0.0 and Y=0.0`.
  ArcTan<native><public>(Y: float, X: float)<reads>: float

  # Returns the smallest `int` that is greater than or equal to `Val`.
  # Fails if `not IsFinite(Val)`.
  Ceil<native><public>(Val: float)<reads><decides>: int

  @rtfm_always_open
  # Constrains the value of `Val` between `A` and `B`. Robustly handles different argument orderings.
  # Returns the median of `Val`, `A`, and `B`.
  Clamp<native><public>(Val: int, A: int, B: int)<computes>: int

  # Constrains the value of `Val` between `A` and `B`. Robustly handles different argument orderings.
  # Returns the median of `Val`, `A`, and `B`, such that comparisons with `NaN` operate as if `NaN > +Inf`.
  Clamp<public>(Val: float, A: float, B: float)<computes>: float = external {}

  using { /Verse.org/Concurrency }
  using { /Verse.org/Native }
  # Makes a flattened `array` by concatenating the elements of `Arrays`.
  Concatenate<public>(Arrays: [][]t where t: type)<computes>: []t = external {}

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the cosine of `X` if `IsFinite(X)`.
  # Returns `NaN` if `not IsFinite(X)
  Cos<native><public>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the hyperbolic cosine of `X`.
  Cosh<native><public>(X: float)<reads>: float

  # Halts the Verse runtime with error `Message`.
  Err<native><public>(Message: string)<computes>: false

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the natural exponent of `X`.
  Exp<native><public>(X: float)<reads>: float

  # Returns the largest `int` that is less than or equal to `Val`.
  # Fails if `not IsFinite(Val)`.
  Floor<native><public>(Val: float)<reads><decides>: int

  # Returns the number of seconds since January 1, 1970 UTC, ignoring leap seconds. I.e, this function implements Unix time. This function always returns the same value within the same transaction.
  GetSecondsSinceEpoch<native><public>()<reads>: float

  # Returns the `int` that equals `Val` without the fractional part.
  # Fails if `not IsFinite(val)`.
  Int<native><public>(Val: float)<reads><decides>: int

  # Succeeds if `Val1` and `Val2` are within `AbsoluteTolerance` of each other.
  IsAlmostEqual<public>(Val1: float, Val2: float, AbsoluteTolerance: float)<computes><decides>: void = external {}

  # Makes a `string` by concatenating `Separator` between the elements of `Strings`.
  Join<native><public>(Strings: []string, Separator: string)<computes>: string

  @vm_no_effect_token
  @rtfm_always_open
  # Used to linearly interpolate/extrapolate between `From` (when `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that all arguments are finite.
  # Returns `From*(1 - Parameter) + To*Parameter`.
  Lerp<native><public>(From: float, To: float, Parameter: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the natural logarithm of `X`.
  Ln<native><public>(X: float)<reads>: float

  # Makes a `string` by localizing `Message` based on the current `locale`.
  Localize<native><public>(Message: message)<reads>: string

  # Returns the base `B` logarithm of `X`.
  Log<public>(B: float, X: float)<reads>: float = external {}

  @experimental
  # Constructs a `classifiable_subset` containing the `InElements`.
  MakeClassifiableSubset<native><public>(InElements: []t where t: type)<reads><converges>: classifiable_subset(t)

  @available { MinUploadedAtFNVersion := 3800 }
  MakeError<public>(Result: error_type where error_type: type): result(false, error_type) = external {}

  MakeLocalizableValue<epic_internal>(V: float): localizable_float = external {}

  MakeLocalizableValue<epic_internal>(V: int): localizable_int = external {}

  MakeLocalizableValue<epic_internal>(V: message): localizable_message = external {}

  MakeLocalizableValue<epic_internal>(V: string): localizable_string = external {}

  MakeMessageInternal<native><epic_internal>(K: string, D: string, S: [string]localizable_value)<converges>: message

  @available { MinUploadedAtFNVersion := 3800 }
  MakeSuccess<public>(Result: success_type where success_type: type): result(success_type, false) = external {}

  # Returns the maximum of `X` and `Y` unless either are `NaN`.
  # Returns `NaN` if either `X` or `Y` are `NaN`.
  Max<public>(X: float, Y: float)<computes>: float = external {}

  # Returns the maximum of `X` and `Y`.
  Max<public>(X: int, Y: int)<computes>: int = external {}

  # Returns the minimum of `X` and `Y` unless either are `NaN`.
  # Returns `NaN` if either `X` or `Y` are `NaN`.
  Min<public>(X: float, Y: float)<computes>: float = external {}

  # Returns the minimum of `X` and `Y`.
  Min<public>(X: int, Y: int)<computes>: int = external {}

  @rtfm_always_open
  # Returns the remainder of `X/Y` as defined by Euclidean division, i.e.:
  #  * `Mod[X,Y] = X - Quotient(X/Y)*Y`
  #  * `0 <= Mod[X,Y] < Abs(Y)`
  # Fails if `Y=0`.
  Mod<native><public>(X: int, Y: int)<computes><decides>: int

  # Pi, the ratio of the circumference of a circle to its diameter.
  PiFloat<public>: float = external {}

  @vm_no_effect_token
  @rtfm_always_open
  # Returns `A` to the power of `B`.
  Pow<native><public>(A: float, B: float)<reads>: float

  # Writes `Message` to a dedicated `Print` log while displaying it in `Color` on the client screen for `Duration` seconds. By default, `Color` is `NamedColors.White` and `Duration` is `2.0` seconds.
  Print<native><public>(Message: message, ?Duration: float = external {}, ?Color: color = external {})<transacts>: void

  using { /Verse.org/Colors }
  # Writes `Message` to a dedicated `Print` log while displaying it in `Color` on the client screen for `Duration` seconds. By default, `Color` is `NamedColors.White` and `Duration` is `2.0` seconds.
  Print<native><public>(Message: string, ?Duration: float = external {}, ?Color: color = external {})<transacts>: void

  # Writes `Message` to a dedicated `Print` log while displaying it in `Color` on the client screen for `Duration` seconds. By default, `Color` is `NamedColors.White` and `Duration` is `2.0` seconds.
  Print<public>(
    Message: diagnostic,
    ?Duration: float = external {},
    ?Color: color = external {}
  )<transacts>: void = external {}

  @rtfm_always_open
  # Returns the quotient `X/Y` as defined by Euclidean division, i.e.:
  #  * `Quotient[X/Y] = Floor[X/Y]` when `Y > 0`
  #  * `Quotient[X/Y] = Ceil[X/Y]` when `Y < 0`
  #  * `Quotient[X/Y] * Y + Mod[X,Y] = X`
  # Fails if `Y = 0`.
  Quotient<native><public>(X: int, Y: int)<computes><decides>: int

  # Returns `Val` rounded to the nearest `int`. When the fractional part of `Val` is `0.5`, rounds to the nearest *even* `int` (per the IEEE-754 default rounding mode).
  # Fails if `not IsFinite(Val)`.
  Round<native><public>(Val: float)<reads><decides>: int

  # Returns the sign of `Val`:
  #  * `1.0` if `Val > 0.0`
  #  * `0.0` if `Val = 0.0`
  #  * `-1.0` if `Val < 0.0`
  #  * `NaN` if `Val = NaN`
  Sgn<public>(Val: float)<computes>: float = external {}

  # Returns the sign of `Val`:
  #   * `1` if `Val > 0`
  #  * `0` if `Val = 0`
  #  * `-1` if `Val < 0`
  Sgn<public>(Val: int)<computes>: int = external {}

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the sine of `X` if `IsFinite(X)`.
  # Returns `NaN` if `not IsFinite(X)
  Sin<native><public>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the hyperbolic sine of `X`.
  Sinh<native><public>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the square root of `X` if `X >= 0.0`.
  # Returns `NaN` if `X < 0.0`.
  Sqrt<native><public>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the tangent of `X` if `IsFinite(X)`.
  # Returns `NaN` if `not IsFinite(X).
  Tan<native><public>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the hyperbolic tangent of `X`.
  Tanh<native><public>(X: float)<reads>: float

  # Converts any Verse value into an opaque diagnostic message.
  ToDiagnostic<native><public>(Value: any)<reads>: diagnostic

  # Makes a `string` from `Character`.
  ToString<native><public>(Character: char)<computes>: string

  # Makes a `string` representation of `Val`.
  ToString<native><public>(Val: float)<reads>: string

  # Makes a printable `string` representation of `Val`.
  ToString<native><public>(Val: int)<computes>: string

  # Returns `String` without modification.
  ToString<public>(String: string)<computes>: string = external {}

  # Implemented by classes that allow users to cancel an operation. For example, calling `subscribable.Subscribe` with a callback returns a `cancelable` object. Calling `Cancel` on the return object unsubscribes the callback.
  cancelable<native><public> := interface {
    # Prevents any current or future work from completing.
    Cancel<native_callable><public>()<transacts>: void
  }

  @experimental
  # A `classifiable_subset` is a container that holds a set of elements. A classifiable_subset can hold multiple elements of the same type.
  classifiable_subset<native><public>(element_type: type) := class<final><reads><internal> {
    # Temporary function for constraining variance correctly.
    CovarianceConstraint<protected>(): ?element_type = external {}

    (/Verse.org/Verse/classifiable_subset:)Verse_classifiable_subset_Variance<private>: ?type { _(): tuple(element_type) } = external {}
  }

  # An opaque diagnostic message that only shows up in diagnostic logs. The format of the diagnostic may change at any time without warning and may not be inspected by Verse code.
  diagnostic<native><public> := class<computes><epic_internal> {}

  # Implemented by classes whose instances have limited lifetimes.
  disposable<native><public> := interface {
    # Cleans up this object.
    Dispose<public>(): void
  }

  # Implemented by classes whose instances can be enabled and disabled.
  enableable<native><public> := interface<public> {
    # Disable this object.
    Disable<public>(): void

    # Enable this object.
    Enable<public>(): void

    # Succeeds if the object is enabled, fails if it’s disabled.
    IsEnabled<public>()<transacts><decides>: void
  }

  # A *recurring*, successively signaled parametric `event` with a `payload` allowing a simple mechanism to coordinate between concurrent tasks.
  event<native><public>(t: type) := class(signalable(t), awaitable(t)) {
    # Suspends the current task until another task calls `Signal`.
    # If called during another invocation of `Signal`, the the task will still suspend and resume during the next call to `Signal`.
    Await<native><override>()<suspends>: t

    # Concurrently resumes the tasks that were suspended by `Await` calls before this call to `Signal`.
    #
    # Tasks are resumed in the order they were suspended. Each task will perform as much work as it can until it encounters a blocking call, whereupon it will transfer control to the next suspended task.
    Signal<native><override>(Val: t): void

    (/Verse.org/Verse/event:)Verse_event_Variance<private>: ?type { _(: t): tuple(t) } = external {}
  }

  # A *recurring*, successively signaled event allowing a simple mechanism to coordinate between concurrent tasks.
  event<public>() := event(tuple())

  # Implemented by classes whose instances can become invalid at runtime.
  invalidatable<native><public> := interface(disposable) {
    # Succeeds if this object is still valid.
    IsValid<public>()<transacts><decides>: void
  }

  # A parameterless interface combining `awaitable` and `subscribable`.
  listenable<public>() := listenable(tuple())

  # A parametric interface combining `awaitable` and `subscribable`.
  listenable<public>(payload: type) := interface(awaitable(payload), subscribable(payload)) {
    (/Verse.org/Verse/listenable:)Verse_listenable_Variance<private>: ?type { _(): tuple() } = external {}
  }

  # Used for message localization.
  locale<native><public> := struct<epic_internal> {}

  localizable_float<native><epic_internal> := class<internal>(localizable_value) {}

  localizable_int<native><epic_internal> := class<internal>(localizable_value) {}

  localizable_message<native><epic_internal> := class<internal>(localizable_value) {}

  localizable_string<native><epic_internal> := class<internal>(localizable_value) {}

  localizable_value<native><epic_internal> := class {}

  # A localizable text message.
  message<native><public> := class<epic_internal> {}

  @experimental
  # Returns a new set that is the union of all elements in `InSetL` set and `InSetR`.
  operator'+'<native><public>((
    InSetL: classifiable_subset(t),
    InSetR: classifiable_subset(t)
  ) where t: type)<transacts>: classifiable_subset(t)

  # Concatenates two diagnostic messages.
  operator'+'<public>(Lhs: diagnostic, Rhs: diagnostic)<computes>: diagnostic = external {}

  # Concatenates a diagnostic message with a normal string, yielding a diagnostic message.
  operator'+'<public>(Lhs: diagnostic, Rhs: string)<computes>: diagnostic = external {}

  # Concatenates a normal string with a diagnostic message, yielding a diagnostic message.
  operator'+'<public>(Lhs: string, Rhs: diagnostic)<computes>: diagnostic = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  # Implemented by classes that provide a result for an operation, which can fail or be successful
  result<public>(success_type: type, error_type: type) := interface<internal> {
    # Returns the error data of the specified type.
    GetError<native_callable><public>()<computes><decides>: error_type

    # Returns the success data of the specified type.
    GetSuccess<native_callable><public>()<computes><decides>: success_type

    (/Verse.org/Verse/result:)Verse_result_Variance<private>: ?type { _(): tuple(success_type, error_type) } = external {}
  }

  @available { MinUploadedAtFNVersion := 3800 }
  # Implemented by classes whose instances can change visibility to be shown or hidden.
  showable<native><public> := interface {
    # Set this value to hide or show the class.
    var Show<public>: logic
  }

  # A parametric interface implemented by events with a `payload` that can be signaled.
  # Can be used with `awaitable`, `subscribable`, or both (see: `listenable`).
  signalable<public>(payload: type) := interface {
    # Concurrently resumes the tasks waiting for this event in `awaitable.Await` and synchronously invokes any callbacks added to this event by `subscribable.Subscribe`.
    Signal<native_callable><public>(Val: payload): void

    (/Verse.org/Verse/signalable:)Verse_signalable_Variance<private>: ?type { _(: payload): tuple() } = external {}
  }

  # A parameterless interface implemented by events that can be subscribed to.
  subscribable<public>() := subscribable(tuple())

  # A parametric interface implemented by events with a `payload` that can be subscribed to.
  # Matched with `signalable.`
  subscribable<public>(t: type) := interface {
    # Registers `Callback` to be invoked on matching calls to `signable.Signal`.
    # Returns an unsubscriber object. Call `cancelable.Cancel` on the unsubscriber to unregister `Callback`.
    Subscribe<public>(Callback: type { _(: t): void })<transacts>: cancelable

    (/Verse.org/Verse/subscribable:)Verse_subscribable_Variance<private>: ?type { _(): tuple(t) } = external {}
  }
}