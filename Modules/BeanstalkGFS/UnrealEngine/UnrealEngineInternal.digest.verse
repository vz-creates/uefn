<#
Copyright Epic Games, Inc. All Rights Reserved.
#################################################
Generated Digest of Verse API
DO NOT modify this manually!
Generated from build: ++Fortnite+Release-43.00-CL-59596594
#################################################
#>

AINavigation<public> := module {
  @experimental
  # Finds and returns the path between this entity's location and the
  # target location.
  (InEntity: entity).FindPath<epic_internal><native>(
    Destination: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
  )<suspends>: navigation_path

  @experimental
  # Finds and returns the path between this entity's location and the target
  # location, filtering the path using supplied Query
  (InEntity: entity).FindPath<epic_internal><native>(
    Destination: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
    Query: navigation_query
  )<suspends>: navigation_path

  # Result of a navigation request
  navigation_find_path_result<epic_internal><native> := enum {
    # The destination cannot be associated to the query's navigation_layer.
    DestinationNonNavigable

    # There is no path that connect the start and end location using the
    # query parameters.
    DestinationUnreachable

    # The request contains invalid or missing data.
    InvalidRequest

    # Search limit was reached before a path could be found. The path leads to
    # the closest location to the destination that the search had time to visit.
    PartialReachedLimit

    # The destination is unreachable. The path leads to the reachable location
    # closest to the destination.
    PartialUnreachable

    # A valid navigation path was found.
    PathFound

    # The origin location cannot be associated to the query's navigation_layer.
    StartLocationNonNavigable
  }

  # Navigation layers are various representations of the world that can be used
  # by agents of different shapes and abilities
  navigation_layer<epic_internal><native> := class<abstract>(asset) {}

  # Use the most granular air field available
  navigation_layer_air_auto<epic_internal><native> := class<final><concrete>(navigation_layer) {}

  # Auto select a ground layer based on the user's collision component
  navigation_layer_ground_auto<epic_internal><native> := class<final><concrete>(navigation_layer) {}

  # Contains the resulting path and status from a find path query.
  navigation_path<epic_internal><native> := class<epic_internal><final> {
    # Returns the points that form the path. Fails if the path is invalid.
    GetPathPoints<public><native>()<transacts><decides>: []navigation_path_point

    # Whether this path completed successfully or encountered a problem.
    Result<public><native>: navigation_find_path_result
  }

  # Describes the location and characteristics of a point along a
  # navigation path.
  navigation_path_point<epic_internal><native> := struct<concrete> {
    @editable
    # Position of the point in the world.
    Location<public><native>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}
  }

  @import_as("/Script/AINavigation.UCompositeNavigationQuery")
  # Defines the parameters of a navigation query such as finding a path or
  # projecting a point.
  navigation_query<epic_internal><native> := class<final><concrete> {}

  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /Verse.org/Assets }
  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  # Verse path: /UnrealEngine.com/AINavigation
  @experimental
  @hide_in_editor
  # This class adds the navigation system to the world simulation entity.
  # This class adds the navigation system to the world simulation entity.
  navigation_system_component<epic_internal><native> := class<final_super>(component) {}

  @experimental
  # Component that describes the navigation preferences of this entity and
  # offers helpers to find paths using those preferences.
  navigation_user_component<epic_internal><native> := class<final><final_super>(component) {
    @editable
    # Default navigation query parameters for this entity.
    DefaultNavigationQuery<public><native>: navigation_query

    OnAddedToScene<native><override>(): void

    OnRemovingFromScene<native><override>(): void
  }
}

Abilities<public> := module {
  @available { MinUploadedAtFNVersion := 4130 }
  # Lives in the scene graph and is the high level description of an ability.
  #  Knows if an ability can run, cooldowns, distance and targeting
  #  requirements etc...
  ability<public><native>(
    context_type: subtype(ability_context),
    ability_effect_type: subtype(ability_effect)
  ) := class<abstract>(has_icon) {
    (/UnrealEngine.com/Abilities/ability:)Abilities_ability_Variance<private>(
      : context_type,
      : ability_effect_type,
      : context_type,
      : context_type
    ): tuple(ability_effect_type, context_type, ability_effect_type) = external {}

    BeginUseEvent<public><native>: listenable(entity) = external {}

    CanUse<public>(AbilityEffectParent: entity, AbilityContext: context_type)<decides><reads>: void = external {}

    EndUseEvent<public><native>: listenable(entity) = external {}

    MakeAbility<public>()<transacts>: ability_effect_type

    MakeContext<public>()<transacts>: context_type

    Use<public><final><native_callable>(
      AbilityEffectParent: entity,
      AbilityContext: context_type
    ): ?ability_effect_type = external {}

    var (/UnrealEngine.com/Abilities/ability:)Abilities_ability_VarVariance<private>: ?tuple(
      ability_effect_type
    ) = external {}

    var Icon<override>: texture = external {}

    var<private> ActiveEffects<public><native>: []ability_effect_type = external {}
  }

  using { /Verse.org/Assets }
  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  # Verse path: /UnrealEngine.com/Abilities
  @available { MinUploadedAtFNVersion := 4130 }
  # Data passed on activation of an ability. Holds who fired, who helped, and
  # what got hit.
  #  Subclass to provide specific context for custom ability effects
  ability_context<public><native> := class<concrete> {
    var Instigator<public><native>: ?entity = external {}

    var Participants<public><native>: []entity = external {}

    var Targets<public><native>: []entity = external {}
  }

  @available { MinUploadedAtFNVersion := 4130 }
  # Prefab to provide a central location for handling desired ability and
  # gameplay logic.
  ability_effect<public><native> := class<concrete>(entity) {
    @field("Components")
    AbilityComponent<public><native>: ability_effect_component = external {}
  }

  @available { MinUploadedAtFNVersion := 4130 }
  # Guaranteed Ability component on Ability prefab entities. Handles
  # Ability lifecycle.
  ability_effect_component<public><native> := class<final_super>(component) {
    CanCancel<protected><native_callable>(Reason: cancel_reason)<transacts><decides>: void = external {}

    Cancel<public><final>(Reason: cancel_reason)<transacts><decides>: void = external {}

    EndUse<protected><final><native_callable>(Reason: ?cancel_reason)<transacts>: void = external {}

    OnBeginUse<protected><native_callable>()<transacts>: void = external {}

    OnEndUse<protected><native>(Reason: ?cancel_reason)<transacts>: void

    var<protected> Ability<public><native>: ?ability(ability_context, ability_effect) = external {}

    var<protected> Context<public><native>: ?ability_context = external {}
  }

  @available { MinUploadedAtFNVersion := 4130 }
  ability_ended<public> := class<castable>(cancel_reason) {}

  @available { MinUploadedAtFNVersion := 4130 }
  ability_removed_from_scene<public><native> := class(cancel_reason) {}

  @available { MinUploadedAtFNVersion := 4130 }
  # Lightweight tag explaining why an effect ended.
  cancel_reason<public><native> := class<abstract><castable> {}
}

# Verse path: /UnrealEngine.com
# Module import path: /UnrealEngine.com/Assets
(/UnrealEngine.com:)Assets<public> := module {
  PlaySound<epic_internal><native>(Asset: sound, ?StartDelay: float = external {})<transacts>: cancelable

  PlaySoundAtLocation<epic_internal><native>(
    Asset: sound,
    Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
    ?Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {},
    ?StartDelay: float = external {}
  )<transacts>: cancelable

  SpawnParticleSystem<epic_internal><native>(
    Asset: particle_system,
    Position: (/Verse.org/SpatialMath:)vector3,
    IntParams: [string]int,
    ?Rotation: (/Verse.org/SpatialMath:)rotation = external {},
    ?StartDelay: float = external {}
  )<transacts>: cancelable

  SpawnParticleSystem<public><native>(
    Asset: particle_system,
    Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
    ?Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {},
    ?StartDelay: float = external {}
  )<transacts>: cancelable

  SpawnParticleSystem<public><native>(
    Asset: particle_system,
    Position: (/Verse.org/SpatialMath:)vector3,
    ?Rotation: (/Verse.org/SpatialMath:)rotation = external {},
    ?StartDelay: float = external {}
  )<transacts>: cancelable

  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /Verse.org/Assets }
  using { /Verse.org/SpatialMath }
  play_sound_subscription<epic_internal><native> := class(cancelable) {
    Cancel<native><override>()<transacts>: void
  }

  spawn_particle_system_subscription<epic_internal><native> := class(cancelable) {
    Cancel<native><override>()<transacts>: void
  }
}

# Verse path: /UnrealEngine.com
# Module import path: /UnrealEngine.com/BasicShapes
BasicShapes<public> := module {
  cone<public> := class<public><final>(mesh_component) {
    Mesh<override>: mesh = external {}
  }

  using { /Verse.org/Assets }
  using { /Verse.org/SceneGraph }
  cube<public> := class<public><final>(mesh_component) {
    Mesh<override>: mesh = external {}
  }

  cylinder<public> := class<public><final>(mesh_component) {
    Mesh<override>: mesh = external {}
  }

  plane<public> := class<public><final>(mesh_component) {
    Mesh<override>: mesh = external {}
  }

  sphere<public> := class<public><final>(mesh_component) {
    Mesh<override>: mesh = external {}
  }
}

Character<public> := module {
  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  AlwaysPassFilter<epic_internal>(Ctx: character_context): logic = external {}

  # Module import path: /UnrealEngine.com/Character/CameraHelpers
  CameraHelpers<epic_internal> := module {
    ConvertInputVectorToWorldSpacePredicts<epic_internal><native>(
      Index: int,
      InputVector: (/Verse.org/SpatialMath:)vector3
    ): (/Verse.org/SpatialMath:)vector3

    using { /Verse.org/Native }
    using { /Verse.org/SceneGraph }
    using { /Verse.org/Simulation }
    using { /Verse.org/SpatialMath }
    @experimental
    (/UnrealEngine.com/Character/CameraHelpers:)GetPlayerByIndex<epic_internal><native>(
      Index: int
    )<transacts><decides>: player

    InitGameplayCameras<epic_internal><native>(Player: player)<transacts><decides>: void

    @available { MinUploadedAtFNVersion := 4110 }
    @experimental
    RegisterCameraToPlayer<epic_internal>(
      CameraComponent: camera_component,
      Player: player,
      ?Debug: logic = external {}
    ): void = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  FindSkeletalAnimation<epic_internal>(E: entity): ?has_skeletal_animation = external {}

  HasMovementIntent<epic_internal>(
    Intent: (/Verse.org/SpatialMath:)vector3
  )<computes><decides>: (/Verse.org/SpatialMath:)vector3 = external {}

  # Module import path: /UnrealEngine.com/Character/InputHelpers
  InputHelpers<epic_internal> := module {
    @experimental
    Crouch<epic_internal>: input_action(logic) = external {}

    @experimental
    Dodge<epic_internal>: input_action(logic) = external {}

    @experimental
    (/UnrealEngine.com/Character/InputHelpers:)GetPlayerByIndex<epic_internal><native>(
      Index: int
    )<decides><reads>: player

    @experimental
    Jump<epic_internal>: input_action(logic) = external {}

    @experimental
    Look<epic_internal>: input_action((/Verse.org/SpatialMath:)vector3) = external {}

    @experimental
    Move<epic_internal>: input_action((/Verse.org/SpatialMath:)vector3) = external {}

    using { /Verse.org/Assets }
    using { /Verse.org/Simulation }
    using { /Verse.org/SpatialMath }
    @experimental
    TraversalMapping<epic_internal>: input_mapping = external {}
  }

  # Module import path: /UnrealEngine.com/Character/NodeHierarchyHelpers
  NodeHierarchyHelpers<epic_internal> := module {
    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    ChainToTarget<epic_internal>(
      Target: subtype(fsm_state),
      NodeList: []node,
      Depth: int
    )<transacts><decides>: []int = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    DeepestActiveAncestor<epic_internal>(
      NodeList: []node,
      ChainIdx: []int,
      Active: []fsm_state
    ): ?fsm_state = external {}

    using { /Verse.org/Native }
    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    DescendantNodes<epic_internal>(NodeList: []node, ParentInst: fsm_state): []node = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    FindActiveState<epic_internal>(Node: node, Active: []fsm_state)<transacts><decides>: fsm_state = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    IsOnChain<epic_internal>(ChainIdx: []int, Index: int)<computes><decides>: void = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    ReorderChainFirst<epic_internal>(NodeList: []node, ChainIdx: []int): []node = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  PhaseName<epic_internal>(Phase: transition_phase): string = external {}

  # Module import path: /UnrealEngine.com/Character/StateMachineDebug
  StateMachineDebug<epic_internal> := module {
    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    DescribeTransition<epic_internal>(
      Fsm: character_state_machine,
      State: fsm_state,
      Transition: exit_transition,
      Phase: ?transition_phase
    ): string = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    StateName<epic_internal>(Fsm: character_state_machine, Target: subtype(fsm_state)): string = external {}

    using { /Verse.org/Native }
    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    Trace<epic_internal>(State: fsm_state, Message: string): void = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    TraceRefusal<epic_internal>(
      Fsm: character_state_machine,
      Target: subtype(fsm_state),
      Reason: string
    ): void = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    TraceStartPacks<epic_internal>(
      Debug: state_machine_debug_settings,
      Attachments: []attached_pack
    ): void = external {}
  }

  # Module import path: /UnrealEngine.com/Character/StateMachinePack
  StateMachinePack<epic_internal> := module {
    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    FindTemplate<epic_internal>(Nodes: []node, Target: subtype(fsm_state))<transacts><decides>: fsm_state = external {}

    using { /Verse.org/Native }
    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    IsAttached<epic_internal>(
      AttachedPacks: []attached_pack,
      Pack: hfsm_pack_component
    )<transacts><decides>: void = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    IsSameState<epic_internal>(
      Nodes: []node,
      LeftClass: subtype(fsm_state),
      RightClass: subtype(fsm_state)
    )<transacts><decides>: void = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    PackPrecedes<epic_internal>(Left: attached_pack, Right: attached_pack)<computes><decides>: void = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @experimental
    RebuildInjections<epic_internal>(
      Nodes: []node,
      AttachedPacks: []attached_pack,
      Debug: state_machine_debug_settings
    ): void = external {}
  }

  using { /UnrealEngine.com/Abilities }
  using { /Verse.org/Assets }
  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/SceneGraph/Movement }
  using { /Verse.org/Simulation }
  using { /Verse.org/SpatialMath }
  using { /Verse.org/StateMachine }
  # Verse path: /UnrealEngine.com/Character
  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  alive_state<epic_internal> := class<final_super>(fsm_state) {
    DebugName<override>: string = external {}

    Mode<override>: behavior_mode = external {}

    OnAction<override>(Event: character_action_request): character_action_result = external {}

    OnReceive<override>(Event: state_event): state_receive_result = external {}

    ParentId<override>: ?subtype(fsm_state) = external {}

    RegisterNode<override>(
      InStateMachine: character_state_machine,
      ?Pack: ?hfsm_pack_component = external {}
    ): void = external {}

    StateId<override>: subtype(fsm_state) = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  attached_pack<epic_internal> := struct {
    Pack: hfsm_pack_component

    Priority: int
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  behavior_mode<epic_internal> := enum {
    Concurrent

    Exclusive
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  character_action_request<epic_internal> := class<abstract>(state_event) {}

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  character_action_result<epic_internal> := enum {
    ContinuePropagation

    Processed

    StopCurrentBranch
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  character_context<epic_internal> := class {
    GetIsDead<public>()<reads>: logic = external {}

    GetSpeed<public>()<reads>: float = external {}

    Mover<epic_internal>: character_controller_component

    PrintDebug<public>(Message: string): void = external {}

    SetIsDead<public>(Dead: logic): void = external {}

    var EnableDebug<public>: logic = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  character_controller_component<public><native> := class<final_super>(component) {
    FinalizeSetup<protected>(): logic = external {}

    GetDesiredFacing<public>()<reads>: (/Verse.org/SpatialMath:)vector3 = external {}

    GetIntentVector<public>()<reads>: (/Verse.org/SpatialMath:)vector3 = external {}

    GetIsCrouching<public>()<decides><reads>: void = external {}

    GetIsDodgeRequested<public>()<decides><reads>: void = external {}

    GetIsDodging<public>()<decides><reads>: void = external {}

    GetIsJumpRequested<public>()<decides><reads>: void = external {}

    GetIsJumping<public>()<decides><reads>: void = external {}

    GetIsOnGround<public>()<decides><reads>: void = external {}

    GetMoveInput<public>()<reads>: (/Verse.org/SpatialMath:)vector3 = external {}

    GetVelocity<public>()<reads>: (/Verse.org/SpatialMath:)vector3 = external {}

    IsReady<protected>(): logic = external {}

    OnBeginSimulation<override>(): void = external {}

    OnBeginSimulationInternal<override>(): void = external {}

    RunStateMachine<epic_internal>(
      StateMachineComponent: character_state_machine_component,
      DeltaTime: float
    ): void = external {}

    SetDesiredFacing<public>(InFacing: (/Verse.org/SpatialMath:)vector3): void = external {}

    SetIntentVector<public>(InIntent: (/Verse.org/SpatialMath:)vector3): void = external {}

    SetIsCrouchRequested<public>(InIsCrouchRequested: logic): void = external {}

    SetIsDodgeRequested<public>(InIsDodgeRequested: logic): void = external {}

    SetIsJumpRequested<public>(InIsJumpRequested: logic): void = external {}

    SetMoveInput<public>(InMoveInput: (/Verse.org/SpatialMath:)vector3): void = external {}

    UpdateTick<protected>(DeltaTime: float): void = external {}

    var IsAuthority<protected>: logic = external {}
  }

  character_falling_mode<epic_internal><native> := class(character_movement_mode) {
    @editable
    AirControlPercentage<public><native>: float = external {}

    @editable
    ClampTerminalVerticalSpeed<public><native>: logic = external {}

    @editable
    FallingAngularFriction<public><native>: float = external {}

    @editable
    FallingDeceleration<public><native>: float = external {}

    @editable
    FallingLateralFriction<public><native>: float = external {}

    @editable
    IgnoreGravity<public><native>: logic = external {}

    @editable
    OverTerminalSpeedFallingDeceleration<public><native>: float = external {}

    @editable
    TerminalMovementPlaneSpeed<public><native>: float = external {}

    @editable
    TerminalVerticalSpeed<public><native>: float = external {}

    @editable
    VerticalFallingDeceleration<public><native>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  character_input_buffer<epic_internal><native> := class {
    (/UnrealEngine.com/Character/character_input_buffer:)HasMovementIntent<public>()<decides><reads>: void = external {}

    (/UnrealEngine.com/Character/character_input_buffer:)Reset<public>(): void = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  character_interact_request<epic_internal> := class(character_action_request) {}

  character_movement_component<epic_internal><native> := class(modal_movement_component) {
    @editable
    Acceleration<public><native>: float = external {}

    @editable
    BrakingFriction<public><native>: ?float = external {}

    @editable
    BrakingFrictionFactor<public><native>: float = external {}

    @editable
    Deceleration<public><native>: float = external {}

    GetMoveInput<public><native>()<reads>: (/Verse.org/SpatialMath:)vector3

    GetOrientationIntent<public><native>()<reads>: (/Verse.org/SpatialMath:)vector3

    @editable
    GroundFriction<public><native>: float = external {}

    IsCrouching<public><native>()<decides><reads>: void

    IsJumpPressed<public><native>()<decides><reads>: void

    IsJumping<public><native>()<decides><reads>: void

    IsOnGround<public><native>()<decides><reads>: void

    @editable
    MaxSpeed<public><native>: float = external {}

    @editable
    MaxStepHeight<public><native>: float = external {}

    @editable
    MaxWalkableSlopeAngle<public><native>: float = external {}

    OnInitializedInternal<native><override>(): void

    OnUninitializingInternal<native><override>(): void

    SetIsJumpPressed<public><native>(InJumpPressed: logic): void

    SetMoveInput<public><native>(InMove: (/Verse.org/SpatialMath:)vector3): void

    SetOrientationIntent<public><native>(InOrientationIntent: (/Verse.org/SpatialMath:)vector3): void

    SetPlayer<public><native>(InPlayer: ?player)<transacts>: void

    ToggleCrouch<public><native>(): void

    @editable
    TurningBoost<public><native>: float = external {}

    @editable
    TurningRate<public><native>: float = external {}
  }

  character_movement_mode<epic_internal><native> := class<abstract>(movement_mode) {
    @editable
    AccelerationOverride<public><native>: ?float = external {}

    @editable
    ApplyAngularVelocityToTarget<public><native>: logic = external {}

    ApplyMove<override>(FrameParams: frame_params, CumulativeMove: proposed_move)<reads>: move_result = external {}

    @editable
    MaxSpeedOverride<public><native>: ?float = external {}

    ProposeMove<override>(FrameParams: frame_params)<reads>: proposed_move = external {}

    @editable
    RemainUpright<public><native>: logic = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  character_orbit_camera_component<epic_internal> := class(perspective_camera_component) {
    GetAngleOffset<public>()<transacts>: float = external {}

    OnBeginSimulation<override>(): void = external {}

    OnLook<public>(LookDelta: (/Verse.org/SpatialMath:)vector3)<transacts>: void = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  character_orbit_camera_modifier<epic_internal> := class(internal_camera_modifier) {
    Evaluate<override>(InValue: camera_state)<reads>: camera_state = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  character_spawn_item_ability_component<epic_internal> := class(spawn_item_ability_component) {
    ResolveSpawnOrigin<override>()<transacts>: ?origin = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  character_state_machine<epic_internal> := class(state_machine) {
    AddNode<epic_internal>(Node: node): void = external {}

    AddPack<epic_internal>(Attachment: attached_pack): void = external {}

    AddPacks<epic_internal>(Attachments: []attached_pack): void = external {}

    Context<epic_internal>: character_context

    Debug<epic_internal>: state_machine_debug_settings

    Dispatch<public>(Event: state_event, ?ChildFirst: logic = external {}): logic = external {}

    FindActiveStateOfClass<epic_internal>(Target: subtype(fsm_state))<reads>: ?fsm_state = external {}

    FindFirstStateTemplate<epic_internal>(Target: subtype(fsm_state))<transacts><decides>: fsm_state = external {}

    (/UnrealEngine.com/Character/character_state_machine:)IsAttached<epic_internal>(
      Pack: hfsm_pack_component
    )<transacts><decides>: void = external {}

    PerformTransition<epic_internal>(
      State: fsm_state,
      Transition: exit_transition,
      ?Phase: ?transition_phase = external {}
    ): logic = external {}

    RegisterActiveState<epic_internal>(State: fsm_state): void = external {}

    RemovePack<epic_internal>(Owner: ?hfsm_pack_component): void = external {}

    ReselectChildrenOf<epic_internal>(ParentInst: fsm_state, ?ForceNew: logic = external {}): void = external {}

    ReselectRoots<epic_internal>(?ForceNew: logic = external {}): void = external {}

    RunStateTick<epic_internal>(State: fsm_state, DeltaTime: float): state_receive_result = external {}

    SendEventToTransitions<epic_internal>(State: fsm_state, Event: state_event): state_receive_result = external {}

    Start<epic_internal>(BaseStates: []fsm_state, Attachments: []attached_pack): void = external {}

    Tick<public>(DeltaTime: float): void = external {}

    TransitTo<epic_internal>(Target: subtype(fsm_state)): logic = external {}

    UnregisterActiveState<epic_internal>(State: fsm_state): void = external {}

    var AttachedPacks<epic_internal>: []attached_pack = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  character_state_machine_component<epic_internal><native> := class<final_super>(component, has_character_requests) {
    AttachPack<public>(Pack: hfsm_pack_component, ?RequestedPriority: int = external {}): void = external {}

    AttachPack<public>(PackEntity: entity, ?RequestedPriority: int = external {}): void = external {}

    Can<override>(Event: character_action_request): logic = external {}

    DetachPack<public>(Pack: hfsm_pack_component): void = external {}

    DetachPack<public>(PackEntity: entity): void = external {}

    Do<override>(Event: character_action_request): void = external {}

    IsStateActive<public>(StateType: subtype(fsm_state))<decides><reads>: void = external {}

    IsStateMachineRunning<public>()<decides><reads>: void = external {}

    RunStateMachine<public>(InputBuffer: character_input_buffer): void = external {}

    StartStateMachine<public>(): void = external {}
  }

  character_walking_mode<epic_internal><native> := class(character_movement_mode) {
    @editable
    MaintainHorizontalGroundVelocity<public><native>: logic = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  condition_by_predicate<epic_internal> := class<concrete>(entry_condition) {
    Evaluate<override>(Template: fsm_state, Ctx: character_context, Fsm: character_state_machine): logic = external {}

    GetDebugDetails<override>(): string = external {}

    @editable
    Predicate<epic_internal>: ?condition_predicate = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  condition_predicate<epic_internal> := class<abstract> {
    Evaluate<epic_internal>(Ctx: character_context, Fsm: character_state_machine): logic = external {}

    GetDebugInfo<epic_internal>(): string = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  dead_state<epic_internal> := class<final_super>(fsm_state) {
    DebugName<override>: string = external {}

    Mode<override>: behavior_mode = external {}

    OnEnter<override>(): void = external {}

    OnReceive<override>(Event: state_event): state_receive_result = external {}

    ParentId<override>: ?subtype(fsm_state) = external {}

    RegisterNode<override>(
      InStateMachine: character_state_machine,
      ?Pack: ?hfsm_pack_component = external {}
    ): void = external {}

    StateId<override>: subtype(fsm_state) = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  died_event<epic_internal> := class(state_event) {}

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  dodge_request<epic_internal> := class(character_action_request) {}

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  dodge_state<epic_internal> := class<final_super>(fsm_state) {
    DebugName<override>: string = external {}

    Mode<override>: behavior_mode = external {}

    OnAction<override>(Event: character_action_request): character_action_result = external {}

    OnEnter<override>(): void = external {}

    OnExit<override>(): void = external {}

    OnUpdate<override>(Ctx: character_context, DeltaTime: float): void = external {}

    ParentId<override>: ?subtype(fsm_state) = external {}

    RegisterNode<override>(
      InStateMachine: character_state_machine,
      ?Pack: ?hfsm_pack_component = external {}
    ): void = external {}

    StateId<override>: subtype(fsm_state) = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  entry_condition<epic_internal> := class<abstract>(state_rule) {
    Evaluate<epic_internal>(
      Template: fsm_state,
      Ctx: character_context,
      Fsm: character_state_machine
    ): logic = external {}

    @editable
    @display_priority("2")
    Target<epic_internal>: ?subtype(fsm_state) = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  example_game_npc_component<epic_internal> := class<final_super>(character_controller_component) {
    UpdateTick<override>(DeltaTime: float): void = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  example_game_player_component<epic_internal> := class<final_super>(local_character_controller_component) {
    UpdateTick<override>(DeltaTime: float): void = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  example_game_test_component<epic_internal> := class<final_super>(component) {
    OnSimulate<override>()<suspends>: void = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  exit_transition<epic_internal> := class<abstract>(state_rule) {
    @editable
    @display_priority("3")
    Destination<epic_internal>: ?subtype(fsm_state) = external {}

    Evaluate<epic_internal>(State: fsm_state, Ctx: character_context, Fsm: character_state_machine): logic = external {}

    @editable
    @display_priority("5")
    Execution<epic_internal>: ?transition_execution = external {}

    OnReceive<epic_internal>(
      State: fsm_state,
      Event: state_event,
      Ctx: character_context,
      Fsm: character_state_machine
    ): state_receive_result = external {}

    @editable
    @display_priority("4")
    Phase<epic_internal>: transition_phase = external {}

    PreTransit<epic_internal>(
      State: fsm_state,
      Ctx: character_context,
      Fsm: character_state_machine
    ): logic = external {}

    @editable
    @display_priority("2")
    Source<epic_internal>: ?subtype(fsm_state) = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  fall_state<epic_internal> := class<final_super>(fsm_state) {
    DebugName<override>: string = external {}

    Mode<override>: behavior_mode = external {}

    OnEnter<override>(): void = external {}

    OnExit<override>(): void = external {}

    OnUpdate<override>(Ctx: character_context, DeltaTime: float): void = external {}

    ParentId<override>: ?subtype(fsm_state) = external {}

    RegisterNode<override>(
      InStateMachine: character_state_machine,
      ?Pack: ?hfsm_pack_component = external {}
    ): void = external {}

    StateId<override>: subtype(fsm_state) = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  fsm_state<epic_internal> := class<final_super><abstract>(state) {
    CanEnter<epic_internal>()<transacts><decides>: void = external {}

    Context<epic_internal>: ?character_context = external {}

    DebugName<epic_internal>: string = external {}

    HasAncestor<epic_internal>(Target: subtype(fsm_state)): logic = external {}

    @editable
    Mode<epic_internal>: behavior_mode = external {}

    OnAction<epic_internal>(Event: character_action_request): character_action_result = external {}

    OnEnter<override>(): void = external {}

    OnExit<override>(): void = external {}

    OnReceive<override>(StateEvent: state_event): state_receive_result = external {}

    OnUpdate<epic_internal>(Ctx: character_context, DeltaTime: float): void = external {}

    Owner<epic_internal>: ?hfsm_pack_component = external {}

    OwningStateMachine<epic_internal>: ?character_state_machine = external {}

    Parent<override>: state_container = external {}

    @editable
    ParentId<epic_internal>: ?subtype(fsm_state) = external {}

    RegisterNode<epic_internal>(
      InStateMachine: character_state_machine,
      ?Pack: ?hfsm_pack_component = external {}
    ): void = external {}

    StateId<epic_internal>: subtype(fsm_state) = external {}

    TryReselectParent<public>(?ForceNew: logic = external {}): void = external {}

    TryReselectRoots<public>(?ForceNew: logic = external {}): void = external {}

    TryTransitTo<public>(Target: subtype(fsm_state)): logic = external {}

    var Rules<epic_internal>: ?state_rules = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  ground_state<epic_internal> := class<final_super>(fsm_state) {
    DebugName<override>: string = external {}

    Mode<override>: behavior_mode = external {}

    OnAction<override>(Event: character_action_request): character_action_result = external {}

    OnUpdate<override>(Ctx: character_context, DeltaTime: float): void = external {}

    ParentId<override>: ?subtype(fsm_state) = external {}

    RegisterNode<override>(
      InStateMachine: character_state_machine,
      ?Pack: ?hfsm_pack_component = external {}
    ): void = external {}

    StateId<override>: subtype(fsm_state) = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  has_character_requests<epic_internal> := interface {
    Can<public>(Event: character_action_request): logic

    Do<public>(Event: character_action_request): void
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  hfsm_attach_test_component<epic_internal> := class<final_super>(component) {
    OnSimulate<override>()<suspends>: void = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  hfsm_pack_component<epic_internal> := class<final_super>(component) {
    @editable
    DefaultPriority<epic_internal>: int = external {}

    @editable
    EntryConditions<epic_internal>: []entry_condition = external {}

    @editable
    ExitTransitions<epic_internal>: []exit_transition = external {}

    @editable
    PackName<public>: string = external {}

    @editable
    States<epic_internal>: []fsm_state = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  idle_state<epic_internal> := class<final_super>(fsm_state) {
    DebugName<override>: string = external {}

    Mode<override>: behavior_mode = external {}

    OnUpdate<override>(Ctx: character_context, DeltaTime: float): void = external {}

    ParentId<override>: ?subtype(fsm_state) = external {}

    RegisterNode<override>(
      InStateMachine: character_state_machine,
      ?Pack: ?hfsm_pack_component = external {}
    ): void = external {}

    StateId<override>: subtype(fsm_state) = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  in_air_state<epic_internal> := class<final_super>(fsm_state) {
    DebugName<override>: string = external {}

    Mode<override>: behavior_mode = external {}

    OnEnter<override>(): void = external {}

    OnExit<override>(): void = external {}

    ParentId<override>: ?subtype(fsm_state) = external {}

    RegisterNode<override>(
      InStateMachine: character_state_machine,
      ?Pack: ?hfsm_pack_component = external {}
    ): void = external {}

    StateId<override>: subtype(fsm_state) = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  jump_execution<epic_internal> := class<concrete>(transition_execution) {
    Execute<override>(State: fsm_state, Ctx: character_context, Fsm: character_state_machine): logic = external {}

    GetDebugInfo<override>(): string = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  jump_request<epic_internal> := class(character_action_request) {}

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  jump_state<epic_internal> := class<final_super>(fsm_state) {
    DebugName<override>: string = external {}

    Mode<override>: behavior_mode = external {}

    OnExit<override>(): void = external {}

    OnUpdate<override>(Ctx: character_context, DeltaTime: float): void = external {}

    ParentId<override>: ?subtype(fsm_state) = external {}

    RegisterNode<override>(
      InStateMachine: character_state_machine,
      ?Pack: ?hfsm_pack_component = external {}
    ): void = external {}

    StateId<override>: subtype(fsm_state) = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  local_character_controller_component<public> := class(character_controller_component) {
    FinalizeSetup<override>(): logic = external {}

    OnEndSimulation<override>(): void = external {}

    OnJump<protected>(Arg: tuple(player, logic)): void = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  locomotion_state<epic_internal> := class<final_super>(fsm_state) {
    DebugName<override>: string = external {}

    Mode<override>: behavior_mode = external {}

    OnUpdate<override>(Ctx: character_context, DeltaTime: float): void = external {}

    ParentId<override>: ?subtype(fsm_state) = external {}

    RegisterNode<override>(
      InStateMachine: character_state_machine,
      ?Pack: ?hfsm_pack_component = external {}
    ): void = external {}

    StateId<override>: subtype(fsm_state) = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  maximum_speed_predicate<epic_internal> := class<concrete>(condition_predicate) {
    Evaluate<override>(Ctx: character_context, Fsm: character_state_machine): logic = external {}

    GetDebugInfo<override>(): string = external {}

    @editable
    Speed<epic_internal>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  minimum_speed_predicate<epic_internal> := class<concrete>(condition_predicate) {
    Evaluate<override>(Ctx: character_context, Fsm: character_state_machine): logic = external {}

    GetDebugInfo<override>(): string = external {}

    @editable
    Speed<epic_internal>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  movement_intention_request<epic_internal> := class(character_action_request) {
    WorldIntent<public>: (/Verse.org/SpatialMath:)vector3
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  no_anim<epic_internal> := class<final><castable><concrete>(modifier(skeleton)) {
    Evaluate<override>(InValue: skeleton)<reads>: skeleton = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  node<epic_internal> := struct {
    FilterConditions: node_filter_conditions = external {}

    Make: node_factory

    Mode: behavior_mode

    Owner: ?hfsm_pack_component = external {}

    Rules: state_rules = external {}

    Template: fsm_state
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  node_factory<epic_internal> := type {
    _(
      : state_container,
      : character_state_machine,
      : character_context,
      : fsm_state,
      : ?hfsm_pack_component
    )<transacts>: fsm_state
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  node_filter_conditions<epic_internal> := type { _(: character_context): logic }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  pack_priority<epic_internal><native> := struct<concrete> {
    @editable
    Pack: ?castable_concrete_subtype(entity) = external {}

    @editable
    Priority: int = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  respawned_event<epic_internal> := class(state_event) {}

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  run_state<epic_internal> := class<final_super>(fsm_state) {
    CanEnter<override>()<transacts><decides>: void = external {}

    DebugName<override>: string = external {}

    Mode<override>: behavior_mode = external {}

    OnEnter<override>(): void = external {}

    OnExit<override>(): void = external {}

    OnUpdate<override>(Ctx: character_context, DeltaTime: float): void = external {}

    ParentId<override>: ?subtype(fsm_state) = external {}

    RegisterNode<override>(
      InStateMachine: character_state_machine,
      ?Pack: ?hfsm_pack_component = external {}
    ): void = external {}

    StateId<override>: subtype(fsm_state) = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  spawn_item_ability<epic_internal> := class(ability(spawn_item_context, spawn_item_effect)) {
    MakeAbility<override>()<transacts>: spawn_item_effect = external {}

    MakeContext<override>()<transacts>: spawn_item_context = external {}

    var ActiveEffects<override>: []spawn_item_effect = external {}

    var Icon<override>: texture = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  spawn_item_ability_component<epic_internal> := class<final_super>(component) {
    OnBeginSimulation<override>(): void = external {}

    OnSimulate<override>()<suspends>: void = external {}

    @editable
    Prefab<epic_internal>: castable_concrete_subtype(entity) = external {}

    ResolveSpawnOrigin<epic_internal>()<transacts>: ?origin = external {}

    @editable
    var UnspawnDuration<public>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  spawn_item_context<epic_internal> := class<concrete>(ability_context) {
    Prefab<epic_internal>: castable_concrete_subtype(entity) = external {}

    SpawnOrigin<epic_internal>: ?origin = external {}

    UnspawnDuration<epic_internal>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  spawn_item_effect<epic_internal> := class(ability_effect) {
    AbilityComponent<override>: spawn_item_effect_component = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  spawn_item_effect_component<epic_internal> := class(ability_effect_component) {
    OnBeginUse<override>()<transacts>: void = external {}

    OnEndUse<override>(Reason: ?cancel_reason)<transacts>: void = external {}

    OnSimulate<override>()<suspends>: void = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  state_machine_debug_display<epic_internal> := class {
    Draw<epic_internal>(
      Roots: []fsm_state,
      Active: []fsm_state,
      Base: (/Verse.org/SpatialMath:)vector3
    ): void = external {}

    Hide<epic_internal>(): void = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  state_machine_debug_settings<epic_internal> := class<concrete> {}

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  state_rule<epic_internal> := class<abstract> {
    @editable
    @display_priority("1")
    DebugName<epic_internal>: string = external {}

    GetDebugDetails<epic_internal>(): string = external {}

    GetDebugInfo<epic_internal><final>(): string = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  state_rules<epic_internal> := class {}

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  @deprecated { Message := "Use state_container directly" }
  template_parent<epic_internal> := class(state_container) {}

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  tick_event<epic_internal> := class(state_event) {
    TimeSinceLastTick<public>: float
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  transition_by_predicate<epic_internal> := class<concrete>(exit_transition) {
    Evaluate<override>(State: fsm_state, Ctx: character_context, Fsm: character_state_machine): logic = external {}

    GetDebugDetails<override>(): string = external {}

    @editable
    Predicate<epic_internal>: ?condition_predicate = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  transition_execution<epic_internal> := class<abstract> {
    Execute<epic_internal>(State: fsm_state, Ctx: character_context, Fsm: character_state_machine): logic = external {}

    GetDebugInfo<epic_internal>(): string = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  transition_phase<epic_internal> := enum {
    PostUpdate

    PreUpdate
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  visual_attachment_component<public> := class<final_super>(component) {
    AttachToSlot<public>(Child: entity, Slot: visual_attachment_slot)<transacts>: logic = external {}

    DespawnSlot<public>(Slot: visual_attachment_slot): void = external {}

    GetSlotEntity<public>(Slot: visual_attachment_slot)<decides><reads>: entity = external {}

    GetSlotOrigin<public>(Slot: visual_attachment_slot)<transacts><decides>: origin = external {}

    OnBeginSimulation<override>(): void = external {}

    SpawnSlot<public>(Slot: visual_attachment_slot): ?entity = external {}

    @editable
    var (/UnrealEngine.com/Character/visual_attachment_component:)Input<public>: visual_attachment_input = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  visual_attachment_input<public> := class<concrete> {
    @editable
    (/UnrealEngine.com/Character/visual_attachment_input:)Back<public>: visual_attachment_slot_config = external {}

    GetSlotConfig<public>(Slot: visual_attachment_slot)<reads>: visual_attachment_slot_config = external {}

    @editable
    Head<public>: visual_attachment_slot_config = external {}

    @editable
    LeftHand<public>: visual_attachment_slot_config = external {}

    @editable
    RightHand<public>: visual_attachment_slot_config = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  visual_attachment_slot<public> := enum {
    (/UnrealEngine.com/Character/visual_attachment_slot:)Back

    Head

    LeftHand

    RightHand
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  visual_attachment_slot_config<public> := class<concrete> {
    @editable
    AutoSpawn<public>: logic = external {}

    @editable
    BoneName<public>: string = external {}

    @editable
    LocalTransform<public>: (/Verse.org/SpatialMath:)transform = external {}

    @editable
    Mesh<public>: mesh = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  walk_state<epic_internal> := class<final_super>(fsm_state) {
    CanEnter<override>()<transacts><decides>: void = external {}

    DebugName<override>: string = external {}

    Mode<override>: behavior_mode = external {}

    OnEnter<override>(): void = external {}

    OnExit<override>(): void = external {}

    OnUpdate<override>(Ctx: character_context, DeltaTime: float): void = external {}

    ParentId<override>: ?subtype(fsm_state) = external {}

    RegisterNode<override>(
      InStateMachine: character_state_machine,
      ?Pack: ?hfsm_pack_component = external {}
    ): void = external {}

    StateId<override>: subtype(fsm_state) = external {}
  }
}

# Verse path: /UnrealEngine.com
# Module import path: /UnrealEngine.com/ControlInput
ControlInput<public> := module {
  @available { MinUploadedAtFNVersion := 3630 }
  @deprecated
  # Deprecated: use 'GetPlayerInput' from the '/Verse.org/Input' module instead.
  # Access input-related data and settings for a player.
  (/UnrealEngine.com/ControlInput:)GetPlayerInput<public><native>(
    Player: player
  )<transacts><decides>: (/UnrealEngine.com/ControlInput:)player_input

  @deprecated
  MakeInputAsset<epic_internal><native>((
    InputAction: input_action(t),
    Path: string
  ) where t: type)<converges>: input_action(t)

  @available { MinUploadedAtFNVersion := 3630 }
  @cpp_name("input_events_vni_alt")
  @deprecated
  # Deprecated: use 'input_events' from the '/Verse.org/Input' module instead.
  # Input_events is a container for user input events which can be
  # subscribed to.
  #   * Use the 'GetPlayerInput' and 'GetInputEvents' functions to retrieve an
  #     input_events object for a given player.
  #   * Low-level notifications of current user input: DetectionBeginEvent,
  #     DetectionOngoingEvent, and DetectionEndEvent.
  #   * High-level notifications of triggered events: ActivationTriggeredEvent
  #     and ActivationCanceledEvent.
  #
  #                         /—----------<-------\
  #  DetectionBeginEvent -> DetectionOngoingEvent -> ActivationTriggeredEvent -> DetectionEndEvent
  #            /\                         /\                                            /
  #              \---------------------> ActivationCanceledEvent ----------------------/
  (/UnrealEngine.com/ControlInput:)input_events<public><native>(t: type) := class(
    (/UnrealEngine.com/ControlInput:)input_events_base
  ) {
    # This input has been canceled before activation. For example, if the key is
    # released before a “Press and Hold” time threshold.
    #  Tuple payload: 0: the player generating this event
    #                 1: the value generated by the physical input
    #                 2: elapsed seconds since detection began
    ActivationCanceledEvent<public><native>: listenable(tuple(player, t, float)) = external {}

    # This input has met all required conditions and has successfully fired.
    # Most of the time, you should bind to this event.
    #  Tuple payload: 0: the player generating this event
    #                 1: the value generated by the physical input
    ActivationTriggeredEvent<public><native>: listenable(tuple(player, t)) = external {}

    (/UnrealEngine.com/ControlInput/input_events:)ControlInput_input_events_Variance<private>(): tuple(
      t,
      t,
      t,
      t
    ) = external {}

    # Detection has started for this input e.g. a required key is now held down.
    # Note: ActivationTriggeredEvent may also occur this frame,
    #  but this event will always be fired first. DetectionBegin and
    #  DetectionEnd will always fire, regardless of whether the input is
    #  successful or canceled.
    #  Tuple payload: 0: the player generating this event
    #                 1: the value generated by the physical input
    DetectionBeginEvent<public><native>: listenable(tuple(player, t)) = external {}

    # Detection has finished e.g. no required keys are now down. Will always
    # fire as a pair with DetectionBegin.
    #  Tuple payload: 0: the player generating this event
    #                 1: elapsed seconds since detection began
    DetectionEndEvent<public><native>: listenable(tuple(player, float)) = external {}

    # Detection for this input is still being processed. For example, a time
    # threshold may not be met.
    #  Tuple payload: 0: the player generating this event
    #                 1: the value generated by the physical input
    #                 2: elapsed seconds since detection began
    DetectionOngoingEvent<public><native>: listenable(tuple(player, t, float)) = external {}
  }

  using { /Verse.org/Assets }
  using { /Verse.org/Native }
  using { /Verse.org/Simulation }
  using { /Verse.org/SpatialMath }
  @import_as("/Script/VerseInput.UVerseInputEventsBase")
  (/UnrealEngine.com/ControlInput:)input_events_base<epic_internal><native> := class<abstract> {}

  @available { MinUploadedAtFNVersion := 3630 }
  @cpp_name("player_input_vni_alt")
  @deprecated
  # Deprecated: use 'player_input' from the '/Verse.org/Input' module instead.
  # This is the main manager class for input-related settings and functions for
  # a player.
  (/UnrealEngine.com/ControlInput:)player_input<public><native> := class {
    AddInputMapping<public><native>(InputMapping: input_mapping): void

    GetInputEvents<public><native>(
      ActionToBind: input_action(t) where t: type
    ): (/UnrealEngine.com/ControlInput:)input_events(t)

    MakeFloatInputEvents<epic_internal><native_callable>(): (/UnrealEngine.com/ControlInput:)input_events(
      float
    ) = external {}

    MakeLogicInputEvents<epic_internal><native_callable>(): (/UnrealEngine.com/ControlInput:)input_events(
      logic
    ) = external {}

    MakeVector3InputEvents<epic_internal><native_callable>(): (/UnrealEngine.com/ControlInput:)input_events(
      (/Verse.org/SpatialMath:)vector3
    ) = external {}

    RemoveInputMapping<public><native>(InputMapping: input_mapping): void
  }
}

Conversations<public> := module {
  @available { MinUploadedAtFNVersion := 4000 }
  # Sets the persona the player will attempt to prompt when they use the
  # relevant hotkey.
  #  The persona must be in the voice channel with the player in order for the
  #  player to be able to successfully prompt.
  (Player: player where member_info: subtype(has_voice_member_info)).SetConversationTarget<public><native>(
    (local:)Persona: persona_component,
    Channel: voice_channel(member_info)
  )<transacts>: void

  @available { MinUploadedAtFNVersion := 4000 }
  # Unbind player from prompting personas
  (Player: player).ClearConversationTarget<public><native>()<transacts>: void

  @available { MinUploadedAtFNVersion := 4000 }
  # Retrieve the persona and channel the player is currently bound to prompt.
  (Player: player).GetConversationTarget<public><native>()<decides><reads>: tuple(
    persona_component,
    voice_channel(has_voice_member_info)
  )

  MakeLLMString<epic_internal><native_callable>(String: string): llm_string = external {}

  MakeLLMStringMessage<epic_internal><localizes><native_callable>(LLMString: llm_string): message = external {}

  (/UnrealEngine.com/Conversations:)MakeLocalizableValue<epic_internal>(
    V: llm_string
  ): localizable_llm_string = external {}

  @available { MinUploadedAtFNVersion := 4000 }
  MakePersonaErrorResult<epic_internal><native_callable>(
    Result: error_type where error_type: type
  ): result(false, error_type) = external {}

  @available { MinUploadedAtFNVersion := 4000 }
  MakePersonaSuccessResult<epic_internal><native_callable>(
    Result: success_type where success_type: type
  ): result(success_type, false) = external {}

  @available { MinUploadedAtFNVersion := 4000 }
  ai_character_limit_error<public><native> := class(ai_error) {}

  @available { MinUploadedAtFNVersion := 4100 }
  ai_description<public><constructor>(Description: string)<computes>: ai_description_attribute = external {}

  @available { MinUploadedAtFNVersion := 4100 }
  @attribscope_data
  @customattribhandler
  ai_description_attribute<public> := class<internal><computes>(attribute) {
    Description<public>: string
  }

  using { /Verse.org/Chat }
  using { /Verse.org/Colors }
  using { /Verse.org/Diagnostics }
  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  # Verse path: /UnrealEngine.com/Conversations
  @available { MinUploadedAtFNVersion := 4000 }
  ai_error<public><native> := class<castable> {
    Message<public><native>: message
  }

  @available { MinUploadedAtFNVersion := 4000 }
  ai_moderated_error<public><native> := class(ai_error) {}

  @available { MinUploadedAtFNVersion := 4000 }
  @export_metadata { Category := "PublishingMutators"; Key := "Conversations"; Value := "" }
  # Manages AI session state: conversation history, pinned entries, and
  # registered capabilities (tools, signals, listenables).
  #  History is automatically compacted by the runtime. Completed goals are
  #  summarized into history.
  ai_session<public><native> := class<unique> {
    CancelVoiceChannelSubscription<epic_internal><native_callable>(
      SubscriptionToCancel: cancelable
    )<transacts>: void = external {}

    # Removes all the history events from the session.
    ClearHistory<public><native>()<transacts>: void

    OnAISessionConstructed<epic_internal><native>()<transacts>: void

    OnAddMemberEvent<epic_internal><native>((
      Agent: agent,
      MemberInfo: member_info
    ) where member_info: subtype(has_voice_member_info))<transacts>: void

    OnRemoveMemberEvent<epic_internal><native>((
      Agent: agent,
      MemberInfo: member_info
    ) where member_info: subtype(has_voice_member_info))<transacts>: void

    @available { MinUploadedAtFNVersion := 4100 }
    # Sends instructions to the model with the session's full context
    # (personality, pinned facts, history).
    #  The response is parsed into response_type, which must be a struct
    #  containing only:
    #  numeric types, messages, booleans, enums, agents, or structs/arrays of
    #  those types.
    #  Field names and type names guide the model on how to fill out
    #  the structure.
    Prompt<public><native>((local:)Prompt: message, response_type: type)<suspends>: result(response_type, ai_error)

    @available { MinUploadedAtFNVersion := 4120 }
    # Registers a fire-and-forget side-output the model can emit alongside any
    # response, during prompts and goals.
    #  When Required is true, the model must emit this every response.
    #  Returns a cancelable that unregisters the action.
    RegisterAction<public><native>(
      Definition: prompt_binding_definition,
      Required: logic,
      output_type: type,
      Callback: type { _(: output_type): void }
    )<transacts>: cancelable

    SubscribeToVoiceChannelMemberAdded<epic_internal><native_callable>(
      VoiceChannel: voice_channel(member_info) where member_info: subtype(has_voice_member_info)
    )<transacts>: cancelable = external {}

    SubscribeToVoiceChannelMemberRemoved<epic_internal><native_callable>(
      VoiceChannel: voice_channel(member_info) where member_info: subtype(has_voice_member_info)
    )<transacts>: cancelable = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  ai_throttled_error<public><native> := class(ai_error) {}

  @available { MinUploadedAtFNVersion := 4000 }
  ai_timeout_error<public><native> := class(ai_error) {}

  @available { MinUploadedAtFNVersion := 4000 }
  # Tough, Low, Natural
  aura_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Whimsical, Med, Warm
  battle_gamer_mae_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Comic, High, Warm
  brite_bomber_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Cinematic, Med, Natural
  brute_gunner_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Comic, High, Natural
  chase_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Cinematic, Med, Warm
  clover_swift_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  cuddle_team_leader_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Refined, Med, Warm
  elmira_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Comic, Med, Natural
  field_commander_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Cinematic, Med, Natural
  fishstick_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Refined, Med, Warm
  guild_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Tough, Med, Natural
  halley_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Whimsical, Med, Natural
  haylee_skye_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Glamorous, Animated, warm
  helsie_midnight_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  hope_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  internal_response_data<epic_internal><native> := struct {
    @ai_description("Use this to output the name of the targeted conversation participant")
    TargetAgent<native>: ?agent
  }

  @available { MinUploadedAtFNVersion := 4220 }
  # The decision made when evaluating an incoming prompt against the active
  # interruption rule.
  interrupt_decision<epic_internal><native> := enum {
    # The incoming prompt was ignored because the persona cannot be interrupted.
    Ignored

    # The incoming prompt caused the active utterance to be interrupted.
    Interrupted

    # The incoming prompt was queued and will be processed after the current
    # utterance finishes.
    Queued
  }

  @available { MinUploadedAtFNVersion := 4000 }
  jonesy_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Narrator, Low, Warm
  kor_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Whimsical, High, Warm
  lexa_hexbringer_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  llm_fact<epic_internal><native> := class(cancelable) {
    Cancel<native><override>()<transacts>: void
  }

  # Verse path: /UnrealEngine.com/Conversations
  llm_string<epic_internal><native> := class {
    Value<epic_internal><native>: string
  }

  localizable_llm_string<epic_internal><native> := class(localizable_value) {
    Value<epic_internal><native>: string
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Glamorous, Med, Natural
  magnus_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Tough, Low, Gravelly
  mancake_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  mecha_team_leader_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  midas_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Narrator, Med, Warm
  moxie_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Whimsical, High, Warm
  munitions_master_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Glamorous, Low, Natural
  nezumi_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Comic, High, Natural
  orin_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Refined, Med, Natural
  peely_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @export_metadata { Category := "PublishingMutators"; Key := "Conversations"; Value := "" }
  # NPC Persona component
  persona_component<public><native> := class<final_super>(component) {
    # Listenable which is signaled when the spoken message is finalized
    # (after moderation).
    #  Contains the actual message delivered — either the original or the
    #  canned replacement.
    #  1/ The agent (if involved) that prompted the response.
    #  2/ The final message that was said.
    CommitSayEvent<public><native>: listenable(tuple(?agent, message)) = external {}

    # The session which will process all this persona's prompts
    # When the persona is in a voice channel, every session in that channel will
    # automatically propagate conversation history entries to all sessions found
    # in the channel.
    # All and only conversation directly to or from a persona will be
    # automatically recorded.
    GetAISession<public><native>()<transacts>: ai_session

    @available { MinUploadedAtFNVersion := 4220 }
    # Listenable which is signaled when an incoming prompt is evaluated against
    # the active interruption rule.
    #  Receives the rule that was active and the decision that was made.
    InterruptionEvaluatedEvent<epic_internal><native>: listenable(tuple(
      persona_interruption_rule,
      interrupt_decision
    )) = external {}

    @available { MinUploadedAtFNVersion := 4220 }
    # Succeeds if the persona is currently speaking.
    IsTalking<epic_internal><native>()<decides><reads>: void

    OnInitialized<override>(): void = external {}

    OnPersonaComponentConstructed<epic_internal><native>()<transacts>: void

    @available { MinUploadedAtFNVersion := 4000 }
    OnReceive<override>(SceneEvent: scene_event): logic = external {}

    # Listenable which is signaled when the persona was requested to talk,
    # either by a player or prompt and failed.
    #  Callback receives:
    #    1) The persona which had the failure
    #    2) The error
    PromptFailureEvent<public><native>: listenable(ai_error) = external {}

    # Prompts the session with instructions and speaks the result to the
    # channel parameter.
    #  Fails if the interrupt rule prevents the prompt being submitted or the
    #  persona isn't in a channel.
    PromptToTalk<public><native>((
      Instructions: message,
      Channel: voice_channel(member_info)
    ) where member_info: subtype(has_voice_member_info))<transacts><decides>: void

    # Prompts the session with instructions and speaks the result to the
    # channel parameter.
    #  Fails if the interrupt rule prevents the prompt being submitted or the
    #  persona isn't in a channel.
    #  Override the interrupt rules for this prompt only.
    PromptToTalk<public><native>((
      Instructions: message,
      PromptInterrupt: persona_interruption_rule,
      Channel: voice_channel(member_info)
    ) where member_info: subtype(has_voice_member_info))<transacts><decides>: void

    SetPersonality<public><native>(NewPersonality: message)<transacts><decides>: void

    SetVoice<public><native>(NewVoice: voice_model)<transacts><decides>: void

    # Listenable which is signaled when the player starts prompting the persona.
    StartHearEvent<public><native>: listenable(agent) = external {}

    # Listenable which is signaled when the persona begins speaking (before
    # moderation resolves).
    #  1/ The agent (if involved) that prompted the response.
    #  2/ Cancelable to stop the persona from talking.
    StartSayEvent<public><native>: listenable(tuple(?agent, cancelable)) = external {}

    # Listenable which is signaled when the player finishes prompting
    # the persona.
    StopHearEvent<public><native>: listenable(agent) = external {}

    # Listenable which is signaled when the target stops talking.
    #  1/ logic that is true when interrupted
    StopSayEvent<public><native>: listenable(logic) = external {}

    UpdateDetails<epic_internal><native>()<transacts>: void

    UpdateIcon<epic_internal><native>()<transacts>: void

    # How the persona will handle overlapping prompts.
    var PromptInterruptionRule<public>: persona_interruption_rule = external {}

    var<epic_internal> Color<epic_internal><native>: color = external {}

    var<epic_internal> HearingRange<epic_internal><native>: float = external {}

    var<epic_internal> Volume<epic_internal><native>: float = external {}

    # The personality of the persona
    var<private> Personality<public>: message = external {}

    # The voice assigned to this persona.
    var<private> Voice<public>: voice_model = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @import_as("/Script/AIPrompt.UPersonaPrompt")
  persona_editor_prompt<epic_internal><native> := class<epic_internal><final><concrete> {}

  @available { MinUploadedAtFNVersion := 4000 }
  # Defines the way the persona will handle attempts to prompt it while it
  # is processing.
  persona_interruption_rule<public><native> := enum<open> {
    # Cannot be interrupted, will ignore any input until the finished.
    IgnoreUntilFinished

    # Will be interrupted immediately when spoken to.
    InterruptOnPromptStart

    # Will interrupt when the response for the interrupting prompt is ready.
    InterruptOnResponseStart
  }

  @available { MinUploadedAtFNVersion := 4000 }
  persona_utterance<epic_internal><native> := class(cancelable) {
    Cancel<native><override>()<transacts>: void
  }

  @available { MinUploadedAtFNVersion := 4120 }
  # Describes a capability registered on a session. The Name and Description are
  # provided to the AI in the prompt.
  prompt_binding_definition<public><native> := struct {
    # Describes when/why the AI prompt should pick this capability.
    Description<public><native>: message

    # Human-readable name the AI prompt sees when deciding which capability
    # to call.
    Name<public><native>: message
  }

  @available { MinUploadedAtFNVersion := 4000 }
  raven_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Tough, High, Natural
  red_ruin_joni_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  revolt_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4120 }
  session_type_subscription<epic_internal><native> := class(cancelable) {
    Cancel<native><override>()<transacts>: void
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Whimsical, High, Warm
  sunspot_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Narrator, Low, Warm
  terns_voice<public> := class<final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Tough, High, Warm
  the_imagined_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  tomatohead_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # The persona voice used when converting text-to-voice
  voice_model<public><native> := class<epic_internal><abstract> {
    VoiceName<epic_internal><native>: string
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Cinematic, High, Natural
  ziggy_voice<public> := class<epic_internal><final>(voice_model) {
    VoiceName<override>: string = external {}
  }
}

HealthPipeline<public> := module {
  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # A health adjustment delivered as damage; cast to distinguish in OnReceive.
  damage_event<public><native> := class(health_adjustment_event) {}

  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # Categorizes an adjustment or result entry as damage.
  damage_tag<public><native> := class(health_adjustment_tag) {}

  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # A health adjustment delivered as healing; cast to distinguish in OnReceive.
  healing_event<public><native> := class(health_adjustment_event) {}

  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # Categorizes an adjustment or result entry as healing.
  healing_tag<public><native> := class(health_adjustment_tag) {}

  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # A context object passed through the adjustment pipeline in the scene_event
  #  to provide the instigator and contributing entities.
  health_adjustment_context<public><native> := class<concrete> {
    var Contributors<public><native>: []entity = external {}

    var Instigator<public><native>: ?entity = external {}
  }

  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # The health delta to apply plus categories describing the adjustment.
  health_adjustment_entry<public><native> := class<final><concrete><reads> {
    Categories<public><native>: []tag = external {}

    HealthDelta<public><native>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # Adjustments are scene events: senders build them and deliver
  # with entity.SendUp;
  #  receivers (health_component) process them in OnReceive.
  #  Modifiers is the event LAYER stack, supplied by the sender (gather from
  #  contributors however your game sees fit) before the event is sent.
  health_adjustment_event<public><native> := class<epic_internal><abstract>(scene_event) {
    Context<public><native>: health_adjustment_context = external {}

    Entries<public><native>: []health_adjustment_entry = external {}

    var Modifiers<public>: health_adjustment_modifier_stack = external {}

    var Result<public><native>: ?health_adjustment_result = external {}
  }

  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # Modifiers evaluate individual adjustment entries: real entry in, modified
  # entry out
  #  (health_adjustment_entry is <reads>-constructible, so a <reads> body can
  #  build the modified entry).
  #  Evaluation state (Context/Target/Pool) is delivered through vars at the
  #  time of adjustment evaluation.
  health_adjustment_modifier<public> := class(modifier(health_adjustment_entry)) {
    Evaluate<override>(InValue: health_adjustment_entry)<reads>: health_adjustment_entry = external {}

    PostEvaluate<public>()<transacts>: void = external {}

    PreEvaluate<public>(
      InContext: ?health_adjustment_context,
      InTarget: ?entity,
      InPool: ?health_pool_entry
    )<transacts>: void = external {}

    var Context<protected>: ?health_adjustment_context = external {}

    var Pool<protected>: ?health_pool_entry = external {}

    var Target<protected>: ?entity = external {}
  }

  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # An ordered stack of health adjustment modifiers.
  #  Itself a modifier, so stacks nest; the Pre/PostEvaluate broadcasts forward
  #  evaluation state down the chain.
  health_adjustment_modifier_stack<public> := class(modifier_stack(health_adjustment_entry)) {
    AddModifier<override>(
      Modifier: modifier(health_adjustment_entry),
      Position: rational
    )<transacts>: cancelable = external {}

    PostEvaluate<public>()<transacts>: void = external {}

    PreEvaluate<public>(
      InContext: ?health_adjustment_context,
      InTarget: ?entity,
      InPool: ?health_pool_entry
    )<transacts>: void = external {}
  }

  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # The outcome of a processed health adjustment event.
  health_adjustment_result<public><native> := class<final><concrete> {
    var Excess<public><native>: []health_adjustment_entry = external {}

    var Results<public><native>: []health_adjustment_result_entry = external {}
  }

  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # A slice of an adjustment as applied to one pool.
  #  Categories carries the entry's direction - damage_tag when the pool was
  #  damaged, healing_tag when it was healed - alongside the adjustment's tags.
  health_adjustment_result_entry<public><native> := class<final><concrete> {
    var Categories<public><native>: []tag = external {}

    var HealthDelta<public><native>: float = external {}

    var PoolTag<public><native>: ?health_pool_tag = external {}
  }

  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  using { /Verse.org/Simulation/Tags }
  # Verse path: /UnrealEngine.com/HealthPipeline
  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # Base tag type categorizing health adjustments.
  health_adjustment_tag<public><native> := class<epic_internal>(tag) {}

  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # The default health component: processes damage and healing scene events
  # against an ordered array of health pools.
  #
  # ==============================================================================
  # Scene Events
  #
  #   Senders BUILD the adjustment event themselves and deliver it with SendUp:
  #
  #     Event := damage_event:
  #         Context := health_adjustment_context{Instigator := option{Agent}}
  #         Entries := array{health_adjustment_entry{HealthDelta := 70.0}}
  #     Target.SendUp(Event)
  #     DealtResult := Event.Result
  #
  #   The event's Modifiers stack is supplied by the sender - gather modifiers
  #   from contributors however your game sees fit before sending.
  #
  #   OnReceive consumes the first damage_event/healing_event that reaches this
  #   component: pools are adjusted, the event's Result is set, OnDamaged or
  #   OnHealed is signaled with that result, and OnDied is signaled when the
  #   adjustments took IsAlive from succeeding to failing.
  #
  # ==============================================================================
  # The Math - Layer-Factor Multiplication
  #
  #   Pools are processed in order; within each pool, entries are processed in
  #   order. Per (pool, entry), three modifier stack LAYERS are consulted:
  #
  #     1. the event's stack     (Event.Modifiers, supplied by the sender)
  #     2. the pool's stack      (Pool.DamageModifiers / Pool.HealingModifiers)
  #     3. the component's stack (DamageModifiers / HealingModifiers)
  #
  #   Each layer independently evaluates the REAL entry with natural semantics -
  #   a stack's modifiers chain internally, and the whole stack's output folds
  #   to ONE factor:
  #
  #     Factor = Stack.Evaluate(Entry).HealthDelta / Entry.HealthDelta
  #
  #   The layer factors MULTIPLY: Multiplier = FEvent * FPool * FComponent. A
  #   factor of 1.0 is naturally inert; a 0 from ANY layer zeroes the multiplier
  #   and NULLIFIES the entry (a 0-delta result entry is recorded and nothing
  #   remains to continue on); a negative factor flips the direction.
  #
  # ==============================================================================
  # Application, Unwind, and Excess
  #
  #     Scaled = Remaining * Multiplier
  #
  #   The pool is first gated by its CanProcessAdjustment. The SIGN of Scaled
  #   then decides direction: in a damage_event a positive Scaled damages the
  #   pool toward 0 while a negative Scaled heals it toward MaxValue (a
  #   healing_event mirrors this). Scaled is negative when the entry's
  #   HealthDelta or the folded multiplier is negative - a negative HealthDelta
  #   entry is valid input and starts in the reversed direction. A pool with no
  #   capacity in that direction is skipped and the entry continues on
  #   unchanged.
  #
  #   What the pool absorbs is recorded as a result entry carrying the pool's
  #   Tag, the entry's Categories, and the direction actually applied
  #   (damage_tag or healing_tag). Overflow UNWINDS by dividing the multiplier
  #   back out - Remaining = (Scaled - Absorbed) / Multiplier - and continues to
  #   the next pool, where the layers are consulted again. Whatever survives
  #   every pool lands in Result.Excess at its unwound value.
  #
  #   Example: a 70 damage entry against shields at 50 carrying a 2x pool trait,
  #   with a 3x record on the event: multiplier 2 * 3 = 6, so 420 to apply;
  #   shields absorb 50; the remaining 370 unwinds to ~61.7 and continues to
  #   the next pool at THAT pool's multipliers.
  health_component<public><native> := class<final_super>(component) {
    # Appends a pool (applied after the existing pools).
    AddHealthPool<public><native_callable>(Pool: health_pool_entry)<transacts>: void = external {}

    # The first pool whose identity Tag is an instance of PoolTag; fails
    #  when none match.
    GetHealthPool<public>(PoolTag: castable_subtype(health_pool_tag))<decides><reads>: health_pool_entry = external {}

    # The health pools, in adjustment-application order.
    GetHealthPools<public>()<reads>: []health_pool_entry = external {}

    # Succeeds while the component is alive; override to change the gate.
    IsAlive<public>()<decides><reads>: void = external {}

    # Signaled after a damage event is processed, with the result that
    # was applied.
    OnDamaged<public><final><native>: listenable(health_adjustment_result) = external {}

    # Signaled when an adjustment takes IsAlive from succeeding to failing.
    OnDied<public><final><native>: listenable(tuple()) = external {}

    # Signaled after a healing event is processed, with the result that
    # was applied.
    OnHealed<public><final><native>: listenable(health_adjustment_result) = external {}

    # Adjustments arrive as scene events (senders build them and SendUp to
    #  the target). A processed event is consumed to stop it climbing past the
    #  first health component; unhandled events keep traversing.
    OnReceive<override>(SceneEvent: scene_event): logic = external {}

    # Removes the given pool instance (health_pool_entry is unique).
    RemoveHealthPool<public><native_callable>(Pool: health_pool_entry)<transacts>: void = external {}

    # Signals OnDamaged and broadcasts the native delegate mirror;
    #  native because the underlying event signal is no_rollback.
    SignalDamaged<protected><native>(Result: health_adjustment_result)<transacts>: void

    # Signals OnDied and broadcasts the native delegate mirror;
    #  native because the underlying event signal is no_rollback.
    SignalDied<protected><native>()<transacts>: void

    # Signals OnHealed and broadcasts the native delegate mirror;
    #  native because the underlying event signal is no_rollback.
    SignalHealed<protected><native>(Result: health_adjustment_result)<transacts>: void

    # Component-layer damage modifier stack.
    var DamageModifiers<public>: health_adjustment_modifier_stack = external {}

    # Component-layer healing modifier stack.
    var HealingModifiers<public>: health_adjustment_modifier_stack = external {}

    @editable {}
    # The health pools associated w/ this health component; adjustments are
    #  applied to each pool in this order.
    var<protected> HealthPools<public><native>: []health_pool_entry = external {}
  }

  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # A pool of health that can be damaged and/or healed.
  #  Pool identifier is the Tag: define one health_pool_tag subclass per
  #  pool type
  #  (e.g. shields_pool_tag := class(health_pool_tag)) - conditional matching
  #  and result entries reference pools by that tag. Pools carry their own
  #  modifier stacks, evaluated as the pool LAYER.
  health_pool_entry<public><native> := class<concrete><unique> {
    # Gates whether this pool processes an adjustment entry; the default
    #  processes everything - override for pool-specific rules (e.g. shields
    #  refuse Penetrating entries).
    CanProcessAdjustment<public>(Adjustment: health_adjustment_entry)<decides><reads>: void = external {}

    @editable
    # The pool's identity tag; fixed at setup (non-var) so identity cannot
    #  change while the pool is live.
    Tag<public><native>: health_pool_tag = external {}

    @editable
    var CurrentValue<public><native>: float = external {}

    # Pool-layer damage modifier stack.
    var DamageModifiers<public>: health_adjustment_modifier_stack = external {}

    # Pool-layer healing modifier stack.
    var HealingModifiers<public>: health_adjustment_modifier_stack = external {}

    @editable
    var MaxValue<public><native>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4300 }
  @experimental
  # Pool identity: define one subclass per pool type and set an instance as the
  # pool's Tag.
  #  Conditional matching and result entries reference pools by it.
  health_pool_tag<public><native> := class(tag) {}
}

Itemization<public> := module {
  @available { MinUploadedAtFNVersion := 3800 }
  # Returns a failure reason (such as being full) if the provided item entity
  # cannot be added. Does not consider sub-inventories.
  (Inventory: inventory_component).CanAddItem<public><native>(
    Item: entity,
    ?AllowMergeItems: logic = external {}
  )<transacts>: result(false, []add_item_error)

  @available { MinUploadedAtFNVersion := 3800 }
  # Returns a failure reason (such as being full) if the provided item entity
  # cannot be added. AddItemDistribute allows the item to enter sub-inventories.
  (Inventory: inventory_component).CanAddItemDistribute<public><native>(
    Item: entity,
    ?AllowMergeItems: logic = external {}
  )<transacts>: result(false, []add_item_error)

  @available { MinUploadedAtFNVersion := 3800 }
  # Returns a failure reason if the provided item is not present or cannot
  # be removed.
  (Inventory: inventory_component).CanRemoveItem<public><native>(
    Item: entity
  )<transacts>: result(false, []remove_item_error)

  @available { MinUploadedAtFNVersion := 3800 }
  (Item: item_component).CanEquip<public><native>()<transacts>: result(false, []equip_item_error)

  @available { MinUploadedAtFNVersion := 3800 }
  (Item: item_component).CanUnequip<public><native>()<transacts>: result(false, []unequip_item_error)

  add_inventory_result<epic_internal><native> := class<epic_internal> {
    Inventory<public><native>: inventory_component

    ParentInventory<public><native>: inventory_component
  }

  add_item_error<public><native> := class<computes> {}

  # When adding an item, 'find_inventory_event' is used as a first pass to find
  # the best inventory for an item. It is sent downwards.
  # 'add_item_query_event' can be used to veto inventory choices, sent upwards
  # from the inventory (to its ancestors) and downwards from the item entity (to
  # its children).
  add_item_query_event<public><native> := class<epic_internal>(scene_event) {
    AddError<public>(Error: add_item_error): void = external {}

    Inventory<public><native>: inventory_component

    Item<public><native>: item_component

    var<private> Errors<public><native>: []add_item_error = external {}
  }

  add_item_result<public><native> := class<epic_internal> {
    # Items that were newly added to this inventory as a result of
    # the transaction.
    AddedItems<public><native>: []entity

    # Items whose stack size changed as a result of the transaction, and the
    # previous stack size value.
    ModifiedItems<public><native>: []tuple(entity, int)
  }

  @editor_type
  @experimental
  basic_inventory_setup_data<epic_internal><native> := class<concrete>(inventory_setup_data) {
    ApplyTo<native><override>(Target: inventory_component)<decides>: inventory_setup_data_result

    @editable
    InventoryList<public><native>: []inventory_properties = external {}

    @editable
    StartingItemList<public><native>: []inventory_starting_item = external {}
  }

  change_equipped_result<public><native> := class<epic_internal> {
    IsItemEquipped<public><native>: logic

    ItemComponent<public><native>: item_component
  }

  change_inventory_result<public><native> := class<epic_internal> {
    CurrentInventory<public><native>: ?inventory_component

    ItemComponent<public><native>: item_component

    PreviousInventory<public><native>: ?inventory_component
  }

  change_item_component_event<epic_internal> := class(scene_event) {
    Entity<public>: entity

    ItemComponent<public>: ?item_component = external {}
  }

  change_items_slot_result<epic_internal><native> := struct<epic_internal> {
    Inventory<public><native>: inventory_component

    SlotChangedItems<public><native>: []item_slot_change
  }

  equip_item_error<public><native> := class<computes> {}

  # When equipping an item, 'equip_item_query_event' can be used to veto the
  # equip. It is sent upwards from the inventory (to its ancestors) and
  # downwards from the item entity (to its children).
  equip_item_query_event<public><native> := class(scene_event) {
    AddError<public>(Error: equip_item_error): void = external {}

    Item<public><native>: item_component

    var<private> Errors<public><native>: []equip_item_error = external {}
  }

  equip_item_result<public><native> := class<epic_internal> {
    Item<public><native>: entity
  }

  # When adding an item, 'find_inventory_event' is used as a first pass to find
  # the best inventory for an item. It is sent downwards.
  # 'add_item_query_event' can be used to veto inventory choices. It is
  # sent upwards.
  find_inventory_event<public><native> := class<epic_internal>(scene_event) {
    ItemComponent<public><native>: item_component

    var ChosenInventory<public><native>: ?inventory_component = external {}

    var ChosenInventoryPriority<public><native>: float = external {}
  }

  @class_and_subclass_group_names("inventory")
  # Inventory components hold items. An entity with an inventory component can
  # be considered to have an inventory.
  # The inventory component controls which items can enter or exit.
  # They also determine whether an item can be equipped.
  inventory_component<public><native> := class<final_super>(component) {
    AddInventory<epic_internal><final><native>(Inventory: inventory_component)<transacts><decides>: void

    @available { MinUploadedAtFNVersion := 3800 }
    # Adds the item to this inventory only, ignoring sub-inventories. Fails if
    # no items could be added.
    AddItem<public><final><native>(
      Item: entity,
      ?AllowMergeItems: logic = external {}
    )<transacts>: result(add_item_result, []add_item_error)

    @available { MinUploadedAtFNVersion := 3800 }
    # Adds the item to this inventory, including sub-inventories. Fails if no
    # items could be added.
    AddItemDistribute<public><final><native>(
      Item: entity,
      ?AllowMergeItems: logic = external {}
    )<transacts>: result(add_item_result, []add_item_error)

    # Triggered when an item is added. Fires on this inventory, then propagates
    # up to all ancestor inventories.
    AddItemEvent<public><final><native>: listenable(add_item_result) = external {}

    # Triggered when an item is equipped. Fires on this inventory, then
    # propagates up to all ancestor inventories.
    EquipItemEvent<public><final><native>: listenable(equip_item_result) = external {}

    @available { MinUploadedAtFNVersion := 2930 }
    # Returns a list of all sub-inventories within this inventory and its
    # descendant inventories.
    FindInventories<public><final><native>()<reads>: generator(inventory_component)

    @available { MinUploadedAtFNVersion := 2930 }
    # Returns a list of all items within this inventory and its
    # descendant inventories.
    FindItems<public><final><native>()<reads>: generator(entity)

    # Returns a list of all items (of a specific type) within this inventory and
    # its descendant inventories.
    FindItems<public><final><native>(Type: castable_subtype(item_component))<reads>: []entity

    GetEquippedItems<public><final><native>(): []entity

    # Returns a list of sub-inventories of this inventory only.
    GetInventories<public><final><native>()<reads>: []inventory_component

    GetItemSlot<epic_internal><native>(Item: entity)<reads>: int

    # Returns a list of items within this inventory only.
    GetItems<public><final><native>()<reads>: []entity

    # Returns a list of items (of a specific type) within this inventory only.
    GetItems<public><final><native>(Type: castable_subtype(item_component))<reads>: []entity

    InventoryAddedEvent<epic_internal><final><native>: listenable(add_inventory_result) = external {}

    InventoryPropertyChangedEvent<epic_internal><final><native>: listenable(
      inventory_property_change_result
    ) = external {}

    InventoryRemovedEvent<epic_internal><final><native>: listenable(remove_inventory_result) = external {}

    ItemsSlotChangedEvent<epic_internal><final><native>: listenable(change_items_slot_result) = external {}

    @available { MinUploadedAtFNVersion := 3800 }
    MakeAddItemResultInternal<epic_internal><final><native_callable>(
      IsSuccess: logic,
      AddItemResult: add_item_result
    ): result(add_item_result, []add_item_error) = external {}

    @available { MinUploadedAtFNVersion := 3800 }
    MakeCanAddItemResultInternal<epic_internal><final><native_callable>(
      IsSuccess: logic
    ): result(void, []add_item_error) = external {}

    @available { MinUploadedAtFNVersion := 3800 }
    MakeCanRemoveItemResultInternal<epic_internal><final><native_callable>(
      IsSuccess: logic
    ): result(void, []remove_item_error) = external {}

    @available { MinUploadedAtFNVersion := 3800 }
    MakeRemoveItemResultInternal<epic_internal><final><native_callable>(
      IsSuccess: logic,
      RemoveItemResult: remove_item_result
    ): result(remove_item_result, []remove_item_error) = external {}

    OnInitializedInternal<native><override>(): void

    @available { MinUploadedAtFNVersion := 4000 }
    OnReceive<override><native>(SceneEvent: scene_event): logic

    OnUninitializingInternal<native><override>(): void

    RemoveInventory<epic_internal><final><native>(Inventory: inventory_component)<transacts><decides>: void

    @available { MinUploadedAtFNVersion := 3800 }
    # Removes an item from this inventory or its descendent inventories. Fails
    # if the item could not be removed.
    RemoveItem<public><final><native>(Item: entity)<transacts>: result(remove_item_result, []remove_item_error)

    # Triggered when an item is removed. Fires on this inventory, then
    # propagates up to all ancestor inventories.
    RemoveItemEvent<public><final><native>: listenable(remove_item_result) = external {}

    # Triggered when an item is unequipped. Fires on this inventory, then
    # propagates up to all ancestor inventories.
    UnequipItemEvent<public><final><native>: listenable(unequip_item_result) = external {}

    var<private> InventoryDescription<epic_internal><native>: message = external {}

    var<private> InventoryDisplayName<epic_internal><native>: message = external {}

    var<private> InventoryName<epic_internal><native>: string = external {}

    var<private> PickupPriority<epic_internal><native>: int = external {}
  }

  @class_and_subclass_group_names("inventory")
  @experimental
  @hide_in_editor
  inventory_initialization_component<epic_internal><native> := class<final_super>(component) {}

  @experimental
  inventory_properties<epic_internal><native> := class<epic_internal> {
    @editable
    InventoryClass<public><native>: subtype(inventory_component)

    @editable
    InventoryDescription<public><native><localizes>: message = external {}

    @editable
    InventoryDisplayName<public><native><localizes>: message = external {}

    @editable
    InventoryName<public><native>: string = external {}

    @editable
    PickupPriority<public><native>: int = external {}

    @editable
    SlotBindings<public><native>: []inventory_slot_binding_definition

    @editable_number(int) { MinValue := option { 0 } }
    TotalSlotsOverride<public><native>: int = external {}
  }

  inventory_property_change_result<epic_internal><native> := struct<epic_internal> {
    Inventory<public><native>: inventory_component
  }

  @experimental
  inventory_setup_data<epic_internal><native> := class<abstract> {
    ApplyTo<public>(Target: inventory_component)<decides>: inventory_setup_data_result
  }

  @experimental
  inventory_setup_data_result<epic_internal><native> := struct<epic_internal> {
    AddedInventoryMap<public><native>: []tuple(inventory_component, []entity)

    Inventory<public><native>: inventory_component
  }

  @experimental
  inventory_slot_binding_definition<epic_internal><native> := struct<epic_internal><concrete> {
    @editable
    InputAction<public><native>: input_action(type) = external {}

    @editable_number(int) { MinValue := option { 0 } }
    Slot<public><native>: int = external {}
  }

  @experimental
  inventory_starting_item<epic_internal><native> := struct<epic_internal><concrete> {
    @editable_number(int) { MinValue := option { 1 } }
    Amount<native>: int = external {}

    @editable
    ItemDefinition<native>: ?item_definition = external {}

    @editable
    ItemEntityClass<native>: ?subtype(entity) = external {}
  }

  @experimental
  item_ability_binding<epic_internal><native> := class<final><concrete> {
    @editable
    var<private> ActiveWhenItemEquipped<public><native>: logic = external {}

    @editable
    var<private> ActiveWhenItemNotEquipped<public><native>: logic = external {}

    @editable
    var<private> Cooldowns<public><native>: []item_ability_cooldown = external {}

    @editable
    var<private> Costs<public><native>: []item_ability_cost = external {}

    @editable
    var<private> InputAction<public><native>: ?input_action(type) = external {}
  }

  @class_and_subclass_group_names("item")
  @experimental
  @hide_in_editor
  item_ability_component<epic_internal><native> := class<final><final_super>(component) {
    @editable
    var<private> ItemAbilities<public><native>: []item_ability_binding
  }

  @experimental
  @import_as("/Script/ItemizationCoreRuntime.UItemAbilityCooldown")
  item_ability_cooldown<epic_internal><native> := class<unique><abstract> {}

  @experimental
  item_ability_cooldown_time<epic_internal><native> := class(item_ability_cooldown) {}

  @experimental
  item_ability_cooldown_velocity_based<epic_internal><native> := class(item_ability_cooldown) {}

  @experimental
  @import_as("/Script/ItemizationCoreRuntime.UItemAbilityCost")
  item_ability_cost<epic_internal><native> := class<unique><abstract> {}

  @experimental
  item_ability_cost_item<epic_internal><native> := class(item_ability_cost) {}

  @class_and_subclass_group_names("item")
  @experimental
  item_attach_component<epic_internal><native> := class<final><final_super>(component) {
    @editable
    Attachments<public><native>: []item_attachment_definition = external {}
  }

  @experimental
  item_attachment_definition<epic_internal><native> := class<unique><concrete> {
    @editable
    var VisibleWhenEquipped<public><native>: logic = external {}

    @editable
    var VisibleWhenUnequipped<public><native>: logic = external {}
  }

  # item_category is used to classify items.
  item_category<public><native> := class<castable><concrete><unique><allocates> {}

  @class_and_subclass_group_names("item")
  # Anything using this component should be considered an item. Required to
  # interact with inventories.
  item_component<public><native> := class<final_super>(component) {
    @replicated("")
    @editable
    # Add one or more category instances to help define and organize this item.
    Categories<public><native>: []item_category = external {}

    # Broadcast when this item is equipped or unequipped.
    ChangeEquippedEvent<public><final><native>: listenable(change_equipped_result) = external {}

    # Broadcast when this item changes inventory.
    ChangeInventoryEvent<public><final><native>: listenable(change_inventory_result) = external {}

    # Removes the item from its inventory and places it in the simulation world.
    # Works on orphaned items i.e. outside the world or any inventory.
    #  Fails if the item is already a pickup. The transform of the item will not
    #  be altered except to unparent it from any inventory.
    (/UnrealEngine.com/Itemization/item_component:)Drop<public><native>()<transacts><decides>: void

    # Removes the item from its inventory and places it in the simulation world.
    # Works on orphaned items i.e. outside the world or any inventory.
    #  Fails if the item is already in the world. The transform of the dropped
    #  item will be set to WorldTransform.
    (/UnrealEngine.com/Itemization/item_component:)Drop<public><native>(
      WorldTransform: (/Verse.org/SpatialMath:)transform
    )<transacts><decides>: void

    @available { MinUploadedAtFNVersion := 3800 }
    # Attempts to equip this item within the inventory it is currently in.
    # Fails if not in an inventory or if equip_item_query_event contains any
    # errors after querying.
    Equip<public><final><native>()<transacts>: result(false, []equip_item_error)

    # Returns the inventory_component this item currently resides in. Fails if
    # it cannot find a valid parent inventory.
    GetParentInventory<public><final><native>()<decides><reads>: inventory_component

    # Succeeds if this item is considered currently within an inventory
    # and equipped.
    IsEquipped<public><final><native>()<decides><reads>: void

    @replicated("")
    ItemDefinitionAsset<epic_internal><native>: ?item_definition = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @replicated("RepNotify")
    ItemID<epic_internal><native>: item_id = external {}

    @available { MinUploadedAtFNVersion := 3800 }
    MakeEquipResultInternal<epic_internal><final><native_callable>(
      IsSuccess: logic
    ): result(void, []equip_item_error) = external {}

    @available { MinUploadedAtFNVersion := 3800 }
    MakeUnequipResultInternal<epic_internal><final><native_callable>(
      IsSuccess: logic
    ): result(void, []unequip_item_error) = external {}

    OnBeginSimulation<override>(): void = external {}

    OnEndSimulation<override>(): void = external {}

    OnInitializedInternal<native><override>(): void

    OnRep_ItemID<epic_internal><native>(): void

    # Fails if this item is already in an inventory, or the inventory cannot
    # accept the item.
    PickUp<public><native>(Inventory: inventory_component)<transacts><decides>: void

    @available { MinUploadedAtFNVersion := 3800 }
    # Attempts to unequip this item.
    # Fails if not in an inventory, not currently equipped or if
    # unequip_item_query_event contains any errors after querying.
    Unequip<public><final><native>()<transacts>: result(false, []unequip_item_error)
  }

  item_definition<epic_internal><native> := class<epic_internal>(asset) {}

  @replicatable
  @import_as("/Script/ItemizationCoreRuntime.FItemID")
  item_id<epic_internal><native> := struct<concrete> {}

  @experimental
  item_mesh_attachment_definition<epic_internal><native> := class<concrete>(item_attachment_definition) {
    @editable
    EntityToAttach<public><native>: ?subtype(entity) = external {}

    @editable
    var AttachToSocketName<public><native>: string = external {}
  }

  @class_and_subclass_group_names("item")
  @hide_in_editor
  # Item component setting owner pose data for this item.
  item_owner_pose_modifier_component<public><native> := class<epic_internal><final_super>(component) {}

  item_slot_change<epic_internal><native> := struct<epic_internal> {
    CurrentSlot<public><native>: int

    Item<public><native>: entity

    PreviousSlot<public><native>: int
  }

  @class_and_subclass_group_names("item")
  @experimental
  @hide_in_editor
  # Component that allows setting the number of slots used by this item in
  # an inventory.
  item_slot_size_component<epic_internal><native> := class<final_super>(component) {
    @editable
    SlotSize<public><native>: int = external {}
  }

  @experimental
  itemization_core_debug_library<epic_internal><native> := class {
    AddTestItem<public><native_callable>(InInventory: inventory_component): void = external {}

    # Adds an item which is also an inventory (let's call it a bag). There is an
    # object inside the bag.
    AddTestItemWithInventory<public><native_callable>(InInventory: inventory_component): void = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    # Adds a mergeable item which can be stacked to the inventory.
    AddTestStackableItem<public><native_callable>(InInventory: inventory_component): void = external {}

    RemoveAllItems<public><native_callable>(InInventory: inventory_component): void = external {}
  }

  @experimental
  @hide_in_editor
  itemization_debug_item_component_mergeable<epic_internal> := class(item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<decides><reads>: void = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  native_item_stackable_component<epic_internal><native> := class(stackable_component) {
    Split<override><native>(Amount: int)<transacts><decides>: entity
  }

  remove_inventory_result<epic_internal><native> := class<epic_internal> {
    Inventory<public><native>: inventory_component

    ParentInventory<public><native>: inventory_component
  }

  remove_item_error<public><native> := class<computes> {}

  # Can be used to veto item removal. Sent upwards from the inventory (to its
  # ancestors) and downwards from the item entity (to its children).
  remove_item_query_event<public><native> := class<epic_internal>(scene_event) {
    AddError<public>(Error: remove_item_error): void = external {}

    Inventory<public><native>: inventory_component

    Item<public><native>: item_component

    var<private> Errors<public><native>: []remove_item_error = external {}
  }

  remove_item_result<public><native> := class<epic_internal> {
    # The inventory which the item was removed from.
    Inventory<public><native>: inventory_component

    # Item whose stack size changed as a result of the transaction.
    ModifiedItem<public><native>: ?tuple(entity, int)

    # Total stack count of items removed as a result of this transaction.
    RemovedAmount<public><native>: int

    # Items that were removed from this inventory as a result of
    # the transaction.
    RemovedItems<public><native>: []entity
  }

  using { /Verse.org/Assets }
  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  using { /Verse.org/SpatialMath }
  using { /Verse.org/Temporary/EpicGamesRestricted/Network }
  # Verse path: /UnrealEngine.com/Itemization
  @hide_in_editor
  subscribable_inventory_event<epic_internal><native>(t: type) := class(subscribable_event_intrnl(t)) {
    Await<native><override>()<suspends>: t

    (/UnrealEngine.com/Itemization/subscribable_inventory_event:)Itemization_subscribable_inventory_event_Variance<private>(): tuple(t, t) = external {}

    @available { MinUploadedAtFNVersion := 4210 }
    (/UnrealEngine.com/Itemization/subscribable_inventory_event:)Itemization_subscribable_inventory_event_Variance_Inherited<private>(: t, : t, : t, : t, : t, : t): tuple(t, t, t, t, t, t, t, t, t) = external {}

    Subscribe<native><override>(Callback: type { _(: t): void })<transacts>: cancelable
  }

  unequip_item_error<public><native> := class<computes> {}

  # When unequipping an item, 'unequip_item_query_event' can be used to veto the
  # unequip. It is sent upwards from the inventory (to its ancestors) and
  # downwards from the item entity (to its children).
  unequip_item_query_event<public><native> := class(scene_event) {
    AddError<public>(Error: unequip_item_error): void = external {}

    Item<public><native>: item_component

    var<private> Errors<public><native>: []unequip_item_error = external {}
  }

  unequip_item_result<public><native> := class<epic_internal> {
    Item<public><native>: entity
  }
}

JSON<public> := module {
  # Parse a JSON string returning a value with its contents
  Parse<public><native>(JSONString: string)<transacts><decides>: value

  using { /Verse.org/Native }
  # Verse path: /UnrealEngine.com/JSON
  @cpp_name("verse::value")
  value<public><native> := class {
    # Retrieve an array value or fail if value is not a json array
    AsArray<public><native>()<transacts><decides>: []value

    # Retrieve a float value or fail if value is not a json number
    AsFloat<public><native>()<transacts><decides>: float

    # Retrieve an integer value or fail if value is not a json number
    AsInt<public><native>()<transacts><decides>: int

    # Retrieve an object value or fail if value is not null
    AsNull<public><native>()<transacts><decides>: void

    # Retrieve an object value or fail if value is not a json object
    AsObject<public><native>()<transacts><decides>: [string]value

    # Retrieve an object value or fail if value is not a string
    AsString<public><native>()<transacts><decides>: string
  }
}

LootPools<public> := module {
  @available { MinUploadedAtFNVersion := 4310 }
  @experimental
  # A `lootable_component` that contains loot pools and a selection mechanism
  # that calls into each of them once.
  basic_lootable_component<epic_internal> := class(lootable_component) {
    # Calls `SelectLoot` on each element of `SourceLootPools` and returns an
    # array combining all of the results.
    SelectLoot<override>(Instigator: ?entity)<transacts><decides>: []entity = external {}

    @editable
    # The loot pools that are queried for loot on each call to `SelectLoot`.
    SourceLootPools<epic_internal>: []loot_pool
  }

  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  # Verse path: /UnrealEngine.com/LootPools
  @available { MinUploadedAtFNVersion := 4310 }
  @experimental
  # Data passed to a `loot_pool` when loot is requested.
  loot_context<epic_internal> := class {
    # The entity that loot is being selected for.
    Instigator<epic_internal>: ?entity = external {}

    # The `lootable_component` that initiated this call to `SelectLoot`.
    Owner<epic_internal>: ?lootable_component = external {}
  }

  @available { MinUploadedAtFNVersion := 4310 }
  @experimental
  # Base class of all loot-generating classes.
  loot_pool<epic_internal> := class<abstract> {
    # Returns the entities to be granted as loot, as determined by `Context`.
    SelectLoot<epic_internal>(Context: loot_context)<transacts><decides>: []entity
  }

  @available { MinUploadedAtFNVersion := 4310 }
  @experimental
  # A component for entities that can return loot on request.
  lootable_component<epic_internal> := class<final_super><abstract>(component) {
    # Returns loot entities, as determined by `Instigator`.
    SelectLoot<epic_internal>(Instigator: ?entity)<transacts><decides>: []entity
  }
}

Marketplace<public> := module {
  # Displays the Epic purchase UI to the player to purchase the `Offer`.
  # Returns true if an offer was purchased.
  BuyOffer<public><native>(Player: player, Offer: offer)<suspends>: logic

  @available { MinUploadedAtFNVersion := 3800 }
  # Consumes a consumable `entitlement`.
  # Fails if:
  #  * The `entitlement` is not consumable.
  #  * The `Player` does not own requested `Count` of `entitlement`.
  ConsumeEntitlement<public><native>(
    Player: player,
    entitlement_type: concrete_subtype(entitlement),
    ?Count: int = external {}
  )<suspends>: logic

  # Used to listen for entitlement change events during a game session.
  # Runtime error if `entitlement` is used directly.
  GetEntitlementsChangedEvent<public><native>(
    Player: player,
    entitlement_type: subtype(entitlement)
  ): listenable(tuple(player, []entitlement_change(entitlement_type)))

  GetPriceVBucks<public><native>(P: price_vbucks): float

  # Get all available
  # `entitlement`s for `Player`, along with the number of those `entitlement`s.
  # This includes finding `entitlement`s of derived types.
  # Calling GetPurchasedEntitlements(Player, entitlement) will suspend forever.
  GetPurchasedEntitlements<public><native>(
    Player: player,
    entitlement_type: subtype(entitlement)
  )<suspends>: []tuple(entitlement_type, int)

  @available { MinUploadedAtFNVersion := 3800 }
  # Grant an entitlement directly to `Player`.
  # This function does not gate granting entitlements based
  # on EntitlementDisclosures.
  # Entitlements are always granted assuming they match the
  # MaxCount requirement.
  GrantEntitlement<public><native>(
    Player: player,
    entitlement_type: concrete_subtype(entitlement),
    ?Count: int = external {}
  )<suspends>: logic

  MakePriceVBucks<public><native>(Amount: float)<converges>: price_vbucks

  # Informs if usage of direct prompts to purchase is restricted for `Player`.
  RestrictDirectPromptsToPurchase<public><native>(Player: player)<decides><reads>: void

  # Informs if usage of paid random items is restricted for `Player`
  # due to platform, territory, age, or user configuration restrictions.
  RestrictPaidRandomItems<public><native>(Player: player)<decides><reads>: void

  # Shows the Epic provided store front contain the specified `Offers`.
  ShowOffersDialog<public><native>(Player: player, Offers: []offer, ?Title: message = external {})<suspends>: void

  # A `bundle_offer` allows you to bundle multiple
  # other `offer`s into a single purchasable `offer`.
  bundle_offer<public><native> := class<castable>(offer) {
    Offers<public><native>: []tuple(offer, int) = external {}
  }

  # An entitlement that is tracked by the commerce system.
  #
  #  * A player may only have one `entitlement` if the entitlement is
  #    not consumable.
  #  * A player may have `MaxCount` of a consumable entitlement.
  #  * Your derived type must be <concrete> to be used by the purchase system.
  #  * If the entitlement you are selling gives players a meaningful advantage
  #    in your island, you must set ConsequentialToGameplay to true.
  entitlement<public><native> := class<castable>(has_icon, has_description) {
    ConsequentialToGameplay<public><native>: logic = external {}

    Consumable<public><native>: logic = external {}

    MaxCount<public><native>: int = external {}

    PaidArea<public><native>: logic = external {}

    PaidRandomItem<public><native>: logic = external {}
  }

  # Entitlements that have changed in quantity.
  # This will also include entitlement changes triggered by moderation, refunds
  # and other commerce operations.
  entitlement_change<public><native>(t: type) := class<internal> {
    # Change to the original quantity of entitlement.
    Change<public><native>: int

    # Entitlement that has changed in quantity.
    Entitlement<public><native>: t

    (/UnrealEngine.com/Marketplace/entitlement_change:)Marketplace_entitlement_change_Variance<private>(): tuple(
      t
    ) = external {}

    # Total quantity of the entitlement now owned.
    Quantity<public><native>: int
  }

  # An `entitlement_offer` allows an individual `entitlement` to be purchased.
  entitlement_offer<public><native> := class<castable>(offer) {
    @available { MinUploadedAtFNVersion := 3800 }
    @editable
    EntitlementType<public><native>: concrete_subtype(entitlement)
  }

  # Offers are used to sell entitlements to players. See `entitlement_offer` and
  # `bundle_offer` classes for more information.
  offer<public><native> := class<internal><abstract><castable>(has_icon, has_description) {
    # Override this method to restrict availability of an offer in certain
    # regions and minimum ages.
    #
    # Parameters:
    #     CountryCode: ISO-3166-1 A-2 code for the country, dependent
    #                  territories, or special area of geographical interest
    #     SubdivisionCode: ISO-3166-2 code (excluding Country Code portion) for
    #                  the subdivision within a country, dependent territory, or
    #                  special area of geographical interest.
    #                  If subdivision information is unavailable for players in
    #                  a region SubdivisionCode will be an empty string.
    #     PlatformFamily: Android, iOS, macOS, Nintendo, PlayStation, Windows,
    #                     Xbox, Luna, GeForceNow
    #
    # Returns:
    #     Fails if sale of this offer should not be allowed in this
    #     (CountryCode, SubdivisionCode)
    #     Minimum age of purchase in this (CountryCode, SubdivisionCode).
    #     If minimum age is higher than the highest available age by region the
    #     offer will not be made
    GetMinPurchaseAge<public><native_callable>(
      CountryCode: string,
      SubdivisionCode: string,
      PlatformFamily: string
    )<computes><decides>: int = external {}

    @editable
    Price<public><native>: price_dimension
  }

  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  # Verse path: /UnrealEngine.com/Marketplace
  offer_interactable_component<public><native> := class(interactable_component) {
    CanInteract<native><native_callable><override>(Agent: agent)<decides><reads>: void

    InteractMessage<override>(Agent: agent)<decides><reads>: message = external {}

    OnBeginSimulation<override>(): void = external {}

    OnSucceed<protected>(Agent: agent): void = external {}

    @editable
    var Offer<public>: offer

    var SucceededEventHandle<public>: ?cancelable = external {}
  }

  using { /Verse.org/Assets }
  using { /Verse.org/Native }
  using { /Verse.org/Presentation }
  # Verse path: /UnrealEngine.com/Marketplace
  price_dimension<public><native> := class<epic_internal><computes><abstract> {}

  # Verse path: /UnrealEngine.com/Marketplace
  price_vbucks<public><native> := class<internal><final><computes>(price_dimension) {}
}

PCG<public> := module {
  # Verse path: /UnrealEngine.com/PCG
  # Module import path: /UnrealEngine.com/PCG/VersePCG
  VersePCG<public> := module {
    pcg_base_tag<epic_internal><native> := class<abstract>(tag) {}

    @experimental
    # PCG Component
    pcg_component<epic_internal><native> := class<final_super>(component) {
      # The `pcg graph` to be generated by this `pcg_component`.
      Graph<epic_internal><native>: pcg_graphinterface_asset = external {}

      @editable
      var<private> Seed<public><native>: int = external {}
    }

    using { /Verse.org/Assets }
    using { /Verse.org/Native }
    using { /Verse.org/SceneGraph }
    using { /Verse.org/Simulation }
    using { /Verse.org/Simulation/Tags }
    @import_as("/Script/VersePCG.UPCGEntityComponentExecutionSource")
    pcg_execution_source<epic_internal><native> := class<epic_internal> {}

    pcg_generated_tag<epic_internal><native> := class(pcg_base_tag) {}

    pcg_graph_asset<epic_internal><native> := class<epic_internal><final><concrete><computes>(
      asset,
      pcg_graphinterface_asset
    ) {}

    pcg_graphinstance_asset<epic_internal><native> := class<epic_internal><final><concrete><computes>(
      asset,
      pcg_graphinterface_asset
    ) {}

    pcg_graphinterface_asset<epic_internal><native> := interface<epic_internal><computes> {}
  }
}

using { /Verse.org/Native }
# Verse path: /UnrealEngine.com
@available { MinUploadedAtFNVersion := 4300 }
# Module import path: /UnrealEngine.com/Progression
(/UnrealEngine.com:)Progression<public> := module {
  BroadcastVerbMessage<epic_internal><native>(Author: entity, SceneEvent: scene_event): void

  FindPersistedParticipation<epic_internal><native>(
    Data: quest_progress_data,
    Participant: (/Verse.org:)Progression.quest_participant
  )<decides><reads>: quest_membership_data

  MakeClaimRewardErrorResultFrom<epic_internal><native_callable>(
    Error: claim_reward_error
  ): result(void, []claim_reward_error) = external {}

  MakeClaimRewardSuccessResult<epic_internal><native_callable>(): result(void, []claim_reward_error) = external {}

  MakeGrantRewardErrorResult<epic_internal><native_callable>(): result(void, []quest_reward_error) = external {}

  MakeGrantRewardRecipientsErrorResult<epic_internal><native_callable>(): result(
    [](/Verse.org:)Progression.quest_membership,
    []quest_reward_error
  ) = external {}

  MakeGrantRewardRecipientsSuccessResult<epic_internal><native_callable>(
    Memberships: [](/Verse.org:)Progression.quest_membership
  ): result([](/Verse.org:)Progression.quest_membership, []quest_reward_error) = external {}

  MakeGrantRewardSuccessResult<epic_internal><native_callable>(): result(void, []quest_reward_error) = external {}

  MakeRegisterGameplayConditionalErrorResult<epic_internal><native_callable>(): result(
    gameplay_conditional_listener_handle,
    []register_gameplay_conditional_error
  ) = external {}

  MakeRegisterGameplayConditionalSuccessResult<epic_internal><native_callable>(
    ListenerHandle: gameplay_conditional_listener_handle
  ): result(gameplay_conditional_listener_handle, []register_gameplay_conditional_error) = external {}

  MakeRegisterVerbErrorResult<epic_internal><native_callable>(): result(
    verb_listener_handle,
    []register_verb_error
  ) = external {}

  MakeRegisterVerbSuccessResult<epic_internal><native_callable>(
    ListenerHandle: verb_listener_handle
  ): result(verb_listener_handle, []register_verb_error) = external {}

  MakeRewardPayoutErrorResult<epic_internal>(
    Errors: []quest_reward_error
  )<transacts>: result([quest_reward][](/Verse.org:)Progression.quest_membership, []quest_reward_error) = external {}

  MakeRewardPayoutSuccessResult<epic_internal>(
    Payouts: [quest_reward][](/Verse.org:)Progression.quest_membership
  )<transacts>: result([quest_reward][](/Verse.org:)Progression.quest_membership, []quest_reward_error) = external {}

  MergeRewardPayouts<epic_internal>(
    Entries: []tuple(quest_reward, [](/Verse.org:)Progression.quest_membership)
  )<reads>: [quest_reward][](/Verse.org:)Progression.quest_membership = external {}

  RegisterGameplayConditional<epic_internal><native>(
    ContextAnchor: entity,
    GameplayConditional: concrete_subtype(gameplay_conditional),
    Callback: type { _(: gameplay_conditional_context): void }
  )<transacts>: result(gameplay_conditional_listener_handle, []register_gameplay_conditional_error)

  RegisterInstancedVerbFilter<epic_internal><native>(
    VerbFilter: verb_filter,
    Callback: type { _(: entity, : scene_event, : float): void }
  )<transacts>: result(verb_listener_handle, []register_verb_error)

  RegisterSharedVerbFilter<epic_internal><native>(
    VerbFilter: verb_filter,
    Callback: type { _(: entity, : scene_event, : float): void }
  )<transacts>: result(verb_listener_handle, []register_verb_error)

  RegisterVerbFilter<epic_internal><native>(
    VerbFilterType: subtype(verb_filter),
    Callback: type { _(: entity, : scene_event, : float): void }
  )<transacts>: result(verb_listener_handle, []register_verb_error)

  RegisterVerbMessage<epic_internal><native>(
    VerbMessageType: subtype(scene_event),
    Callback: type { _(: entity, : scene_event): void }
  )<transacts>: result(verb_listener_handle, []register_verb_error)

  RestoreQuestData<epic_internal><native>(Data: quest_progress_data)<transacts><decides>: (/Verse.org:)Progression.quest

  SnapshotQuestData<epic_internal><native>(Quest: (/Verse.org:)Progression.quest)<reads>: quest_progress_data

  already_claimed_error<epic_internal><native> := class<epic_internal>(claim_reward_error) {}

  using { /Verse.org/Simulation }
  # A quest that auto-completes when its `Objective` is or becomes `Complete`,
  # and grants its `Rewards` once over the quest's live memberships on a
  # succeeding completion.
  # Represents the "Do X, Get Y" paradigm for goal setting: for example, pick up
  # 5 apples, where each apple picked up adds progress, and on completion a
  # reward is distributed to the participants set to receive.
  basic_quest<public><native> := class<abstract>(
    (/Verse.org:)Progression.quest,
    (/Verse.org:)Progression.has_objective,
    has_quest_rewards
  ) {
    # Succeeds if this quest may be activated: this quest's own errors
    # concatenated with the inner `Objective`'s `CanActivate` errors.
    CanActivate<override><native><native_callable>()<reads>: result(void, [](/Verse.org:)Progression.objective_error)

    # Succeeds if this quest may be completed: this quest's own errors
    # concatenated with the inner `Objective`'s `CanComplete` errors.
    CanComplete<override><native><native_callable>(
      Reason: (/Verse.org:)Progression.complete_objective_reason
    )<reads>: result(void, [](/Verse.org:)Progression.objective_error)

    # Succeeds if this quest may be deactivated: this quest's own errors
    # concatenated with the inner `Objective`'s `CanDeactivate` errors.
    CanDeactivate<override><native><native_callable>()<reads>: result(void, [](/Verse.org:)Progression.objective_error)

    # Called when a participant abandons this quest; withdraws an
    # `agent_quest_participant` membership's `Objective` contribution,
    # mirroring `OnJoin`.
    OnAbandon<override><native><native_callable>(
      Participant: (/Verse.org:)Progression.quest_participant,
      Info: (/Verse.org:)Progression.quest_participant_info
    )<transacts>: void

    # Called when this quest activates; propagates the activation to
    # the `Objective`.
    OnActivate<override><native><native_callable>()<transacts>: void

    # Called when this quest completes; grants `Rewards` only for
    # a `succeed_objective_reason`.
    OnComplete<override><native><native_callable>(
      Reason: (/Verse.org:)Progression.complete_objective_reason
    )<transacts>: void

    # Called when this quest deactivates; propagates to the `Objective`.
    OnDeactivate<override><native><native_callable>()<transacts>: void

    # Called when a participant joins this quest; enrolls
    # `agent_quest_participant` memberships as `Objective` contributors when
    # `Info` has `Contribute` and that `Objective` tracks them.
    OnJoin<override><native><native_callable>(
      Participant: (/Verse.org:)Progression.quest_participant,
      Info: (/Verse.org:)Progression.quest_participant_info
    )<transacts>: void

    RouteAddContributor<epic_internal><native_callable>(
      InObjective: (/Verse.org:)Progression.objective,
      Agent: agent
    )<transacts>: void = external {}

    RouteGetContributors<epic_internal><native_callable>(
      InObjective: (/Verse.org:)Progression.objective
    )<reads>: []agent = external {}

    RouteRemoveContributor<epic_internal><native_callable>(
      InObjective: (/Verse.org:)Progression.objective,
      Agent: agent
    )<transacts>: void = external {}

    RouteSetAnchor<epic_internal><native_callable>(
      InObjective: (/Verse.org:)Progression.objective,
      InAnchor: entity
    )<transacts>: void = external {}

    # Writes `Objective`, moves the contributing agents across and activates it
    # if this quest is still running; completes this quest if the new objective
    # is already complete.
    SetObjective<final><override><native>(InObjective: (/Verse.org:)Progression.objective)<transacts>: void

    # Writes `Rewards` and refreshes what this quest shows in the quest UI.
    SetRewards<final><override><native>(InRewards: []quest_reward)<transacts>: void
  }

  claim_reward_error<epic_internal><native> := class<epic_internal><abstract><castable> {}

  using { /UnrealEngine.com/Marketplace }
  using { /Verse.org/StateMachine }
  # An objective composed of sub-objectives, complete when at least
  # RequiredCount of them are; RequiredCount 0, the default, means all of them.
  # Completion is derived from the sub-objectives on every read, so subscribe to
  # CompleteEvent rather than polling State.
  composite_objective<epic_internal><native> := class<epic_internal>(
    (/Verse.org:)Progression.objective,
    (/Verse.org:)Progression.has_objective_contributors,
    (/Verse.org:)Progression.has_objective_anchor
  ) {
    AddContributor<final><override>(Agent: agent)<transacts>: void = external {}

    GetProgress<override><native><native_callable>()<reads>: message

    OnActivate<override><native><native_callable>()<transacts>: void

    OnDeactivate<override><native><native_callable>()<transacts>: void

    RemoveContributor<final><override>(Agent: agent)<transacts>: void = external {}

    RouteAddContributor<epic_internal><native_callable>(
      Child: (/Verse.org:)Progression.objective,
      Agent: agent
    )<transacts>: void = external {}

    RouteRemoveContributor<epic_internal><native_callable>(
      Child: (/Verse.org:)Progression.objective,
      Agent: agent
    )<transacts>: void = external {}

    RouteSetAnchor<epic_internal><native_callable>(
      Child: (/Verse.org:)Progression.objective,
      InAnchor: entity
    )<transacts>: void = external {}

    SetAnchor<final><override>(InAnchor: entity)<transacts>: void = external {}

    var Objectives<epic_internal><native>: [](/Verse.org:)Progression.objective = external {}

    var<private> RequiredCount<epic_internal><native>: int = external {}
  }

  composite_objective_snapshot<epic_internal><native> := class<epic_internal><final><persistable> {
    Children<epic_internal><native>: []objective_snapshot = external {}

    CompletedCount<epic_internal><native>: int = external {}

    ObjectiveId<epic_internal><native>: string = external {}

    ObjectiveVersePath<epic_internal><native>: string = external {}

    RequiredCount<epic_internal><native>: int = external {}
  }

  conditional_objective<epic_internal><native> := class<epic_internal>(
    progress_objective,
    (/Verse.org:)Progression.has_objective_contributors,
    (/Verse.org:)Progression.has_objective_anchor,
    has_gameplay_conditionals
  ) {
    AddContributor<override>(Agent: agent)<transacts>: void = external {}

    OnActivate<override>()<transacts>: void = external {}

    OnConditionalExecuted<override>(Context: gameplay_conditional_context): void = external {}

    OnDeactivate<override>()<transacts>: void = external {}

    RemoveContributor<override>(Agent: agent)<transacts>: void = external {}

    SetAnchor<override>(InAnchor: entity)<transacts>: void = external {}

    var RegisteredHandles<epic_internal>: []gameplay_conditional_listener_handle = external {}
  }

  contextual_reactions_cache<epic_internal> := class<epic_internal><unique> {
    Invalidate<epic_internal>(): void = external {}

    OnGameplayConditionalTriggered<epic_internal>(Context: gameplay_conditional_context): void = external {}

    OwningComponent<epic_internal>: contextual_reactions_component

    Reactions<epic_internal>: []gameplay_reaction

    var Handle<epic_internal>: ?gameplay_conditional_listener_handle = external {}
  }

  contextual_reactions_component<epic_internal><native> := class<epic_internal><final_super>(component) {
    Events<epic_internal>: []tuple(concrete_subtype(gameplay_conditional), []gameplay_reaction)

    OnBeginSimulation<override>(): void = external {}

    OnEndSimulation<override>(): void = external {}

    var Caches<epic_internal>: []contextual_reactions_cache = external {}
  }

  ecosystem_entitlement<epic_internal><native> := class(entitlement) {
    PaidArea<final><override>: logic = external {}

    PaidRandomItem<final><override>: logic = external {}
  }

  # Grants an entitlement to each eligible participant.
  entitlement_quest_reward<public><native> := class(quest_reward) {
    # The entitlement type to grant.
    Entitlement<public><native>: concrete_subtype(entitlement)

    # Skips memberships whose participant is not a player agent.
    OnGrant<final><override><native>(Memberships: [](/Verse.org:)Progression.quest_membership)<transacts>: void

    # Quantity per participant; `1` by default, not clamped or validated.
    Quantity<public><native>: int = external {}
  }

  execute_gameplay_reaction_error<public><native> := class<epic_internal> {}

  gameplay_conditional<epic_internal><native> := class {
    Attributes<epic_internal><native>: []gameplay_conditional_attribute = external {}

    Execute<epic_internal><final><native>(ContextObject: gameplay_conditional_context): void

    OnInitialization<epic_internal><native_callable>(ContextAnchor: entity): void = external {}

    OnInvalidation<epic_internal><native_callable>(): void = external {}

    OnParticipantAdded<epic_internal><native_callable>(Participant: entity): void = external {}

    OnParticipantRemoved<epic_internal><native_callable>(Participant: entity): void = external {}
  }

  gameplay_conditional_attribute<epic_internal><native> := class<abstract> {
    Evaluate<epic_internal><native_callable>()<decides>: void

    OnInitialization<epic_internal><native_callable>(ContextAnchor: entity): void

    OnInvalidation<epic_internal><native_callable>(): void
  }

  gameplay_conditional_context<epic_internal><native> := class {
    Delta<epic_internal><native>: float

    Instigator<epic_internal><native>: entity
  }

  gameplay_conditional_listener_handle<epic_internal><native> := class<final> {
    AddParticipant<epic_internal><native>(Participant: entity)<transacts>: void

    GetParticipants<epic_internal><native>()<reads>: []entity

    IsRegistered<epic_internal><native>()<transacts><decides>: void

    RemoveParticipant<epic_internal><native>(Participant: entity)<transacts>: void

    Unregister<epic_internal><native>()<transacts>: void
  }

  gameplay_conditional_verbs<epic_internal> := class(gameplay_conditional) {
    OnInitialization<override>(ContextAnchor: entity): void = external {}

    OnInvalidation<override>(): void = external {}

    OnParticipantAdded<override>(Participant: entity): void = external {}

    OnParticipantRemoved<override>(Participant: entity): void = external {}

    OnVerbMessageReceived<protected>(Author: entity, SceneEvent: scene_event): void = external {}

    OnVerbMessageReceivedWithDelta<protected>(Author: entity, SceneEvent: scene_event, Delta: float): void = external {}

    VerbFilterTypes<epic_internal>: []subtype(verb_filter) = external {}

    VerbMessageTypes<epic_internal>: []subtype(scene_event) = external {}
  }

  gameplay_reaction<epic_internal><native> := class<abstract> {
    Execute<epic_internal><native_callable>(
      ContextObject: gameplay_reaction_context
    )<transacts>: result(void, []execute_gameplay_reaction_error)
  }

  gameplay_reaction_context<epic_internal><native> := class {
    Source<epic_internal><native>: entity

    Target<epic_internal><native>: entity
  }

  grant_quest_reward_error<epic_internal><native> := class<epic_internal>(quest_reward_error) {}

  has_gameplay_conditionals<epic_internal><native> := interface<epic_internal> {
    Conditionals<epic_internal>: []concrete_subtype(gameplay_conditional) = external {}

    OnConditionalExecuted<epic_internal><native_callable>(Context: gameplay_conditional_context): void
  }

  has_gameplay_reactions<epic_internal><native> := interface<epic_internal> {
    Reactions<epic_internal>: []gameplay_reaction = external {}

    TriggerReactions<epic_internal>(Context: gameplay_reaction_context)<transacts>: void = external {}
  }

  # Implemented by quests that carry a quest_extension list. The interface owns
  # the storage.
  has_quest_extensions<epic_internal><native> := interface {
    # Replaces the extension list. An override owns the write.
    SetQuestExtensions<epic_internal><native_callable>(InExtensions: []quest_extension)<transacts>: void = external {}

    # Extensions attached to this quest. Write it with SetQuestExtensions.
    var<protected> QuestExtensions<epic_internal><native>: []quest_extension = external {}
  }

  # Implement on a quest to control presentation settings.
  has_quest_presentation<public><native> := interface(has_icon, has_description) {
    # Native read of `AllowFavorite` for the presentation view; creators read
    # the field directly.
    GetAllowFavorite<epic_internal><final><native_callable>()<reads>: logic = external {}

    # Native read of `Categories` for the presentation view; creators read the
    # field directly.
    GetCategories<epic_internal><final><native_callable>()<reads>: []quest_category = external {}

    # Native read of `ShowNotification` for the presentation view; creators read
    # the field directly.
    GetShowNotification<epic_internal><final><native_callable>()<reads>: logic = external {}

    # Sets `AllowFavorite` and refreshes this quest in the quest UI; an
    # unchanged write does nothing.
    SetAllowFavorite<public><final><native_callable>(InAllowFavorite: logic)<transacts>: void = external {}

    # Sets `Categories` and refreshes this quest in the quest UI; an unchanged
    # write does nothing.
    SetCategories<public><final><native_callable>(InCategories: []quest_category)<transacts>: void = external {}

    # Sets `ShowNotification` and refreshes this quest in the quest UI; an
    # unchanged write does nothing.
    SetShowNotification<public><final><native_callable>(InShowNotification: logic)<transacts>: void = external {}

    # Whether players may favorite this quest.
    # Write it with `SetAllowFavorite`.
    var<private> AllowFavorite<public><native>: logic

    # The categories this quest is grouped under; an empty array leaves
    # it uncategorized.
    # Write it with `SetCategories`.
    var<private> Categories<public><native>: []quest_category

    # Whether notifications play for this quest.
    # Write it with `SetShowNotification`.
    var<private> ShowNotification<public><native>: logic
  }

  # Implemented by quests that carry a reward list.
  has_quest_rewards<public><native> := interface {
    CanGrantRewards<epic_internal>(
      Memberships: [](/Verse.org:)Progression.quest_membership
    )<reads>: result(void, []quest_reward_error) = external {}

    # Succeeds if `Membership` may receive `Reward` from this quest; the default
    # accepts everyone.
    # A refusal drops that membership from that reward's list and is not
    # an error.
    CanReceive<public>(
      Membership: (/Verse.org:)Progression.quest_membership,
      Reward: quest_reward
    )<reads>: result(void, []quest_reward_error) = external {}

    # Native read of `Rewards` for the quest view; creators read the
    # field directly.
    GetRewards<epic_internal><final><native_callable>()<reads>: []quest_reward = external {}

    # Grants every reward in `Rewards`, in array order, to the memberships whose
    # `Info` has `Receive` and that `CanReceive` accepts for it, and returns the
    # recipients of each reward whose `Grant` succeeded.
    # An error means not everything was granted: rewards whose `Grant` succeeded
    # stay granted, and the errors are every failing `Grant`'s, concatenated.
    GrantRewards<public><final><native_callable>(
      Memberships: [](/Verse.org:)Progression.quest_membership
    )<transacts>: result([quest_reward][](/Verse.org:)Progression.quest_membership, []quest_reward_error) = external {}

    # Returns what `GrantRewards` would grant right now.
    # A reward whose `CanGrant` refuses is omitted, and an empty list is a
    # reward that pays nobody.
    PreviewRewards<public><final>(
      Memberships: [](/Verse.org:)Progression.quest_membership
    )<reads>: [quest_reward][](/Verse.org:)Progression.quest_membership = external {}

    QuestAcceptedMemberships<epic_internal><final>(
      Reward: quest_reward,
      Memberships: [](/Verse.org:)Progression.quest_membership
    )<reads>: [](/Verse.org:)Progression.quest_membership = external {}

    ReceivingRoster<epic_internal><final>(
      Memberships: [](/Verse.org:)Progression.quest_membership
    )<reads>: [](/Verse.org:)Progression.quest_membership = external {}

    # Replaces the reward list; nothing is granted and no event fires.
    SetRewards<public><native_callable>(InRewards: []quest_reward)<transacts>: void = external {}

    # The rewards `GrantRewards` pays to eligible memberships.
    # Write it with `SetRewards`.
    var<protected> Rewards<public><native>: []quest_reward = external {}
  }

  locker_entitlement<epic_internal><native> := class(ecosystem_entitlement) {
    Consumable<final><override>: logic = external {}

    MaxCount<final><override>: int = external {}
  }

  modular_quest<epic_internal><native> := class<epic_internal>(basic_quest, has_quest_extensions) {
    CanAbandon<override><native><native_callable>(
      Participant: (/Verse.org:)Progression.quest_participant,
      Info: (/Verse.org:)Progression.quest_participant_info
    )<reads>: result(void, [](/Verse.org:)Progression.quest_error)

    CanGrantRewards<override>(
      Memberships: [](/Verse.org:)Progression.quest_membership
    )<reads>: result(void, []quest_reward_error) = external {}

    CanJoin<override><native><native_callable>(
      Participant: (/Verse.org:)Progression.quest_participant,
      Info: (/Verse.org:)Progression.quest_participant_info
    )<reads>: result(void, [](/Verse.org:)Progression.quest_error)

    ExtensionGrantRefusals<epic_internal>(
      Memberships: [](/Verse.org:)Progression.quest_membership
    )<reads>: [][]quest_reward_error = external {}

    OnAbandon<override><native><native_callable>(
      Participant: (/Verse.org:)Progression.quest_participant,
      Info: (/Verse.org:)Progression.quest_participant_info
    )<transacts>: void

    OnActivate<override><native><native_callable>()<transacts>: void

    OnComplete<override><native><native_callable>(
      Reason: (/Verse.org:)Progression.complete_objective_reason
    )<transacts>: void

    OnDeactivate<override><native><native_callable>()<transacts>: void

    OnJoin<override><native><native_callable>(
      Participant: (/Verse.org:)Progression.quest_participant,
      Info: (/Verse.org:)Progression.quest_participant_info
    )<transacts>: void
  }

  not_ready_to_claim_error<epic_internal><native> := class<epic_internal>(claim_reward_error) {}

  objective_machine_state<epic_internal><native> := class<epic_internal><final_super>(
    state,
    (/Verse.org:)Progression.has_objective
  ) {
    OnEnter<override><native><native_callable>(): void

    OnExit<override><native><native_callable>(): void
  }

  objective_snapshot<epic_internal><native> := class<epic_internal><final><persistable> {
    Composite<epic_internal><native>: ?composite_objective_snapshot = external {}

    Progress<epic_internal><native>: ?progress_objective_snapshot = external {}

    Sequential<epic_internal><native>: ?sequential_objective_snapshot = external {}

    StateMachine<epic_internal><native>: ?state_machine_objective_snapshot = external {}

    Timed<epic_internal><native>: ?timed_objective_snapshot = external {}
  }

  # Tracks numeric progress toward a required threshold; complete
  # when `Progress >= RequiredProgress`.
  # A commanded `Complete()` succeeds at any progress and does not advance it.
  progress_objective<public><native> := class((/Verse.org:)Progression.objective) {
    AddProgress<epic_internal><final><native>(Amount: float)<transacts>: void

    # Returns progress in `"X / Y"` format.
    GetProgress<final><override><native>()<reads>: message

    # Sets current progress, clamped to `[0, RequiredProgress]`.
    SetProgress<public><final><native>(InProgress: float)<transacts>: void

    # Sets the target progress; a negative or NaN value becomes `0`.
    # Lowering it below `Progress` re-clamps `Progress` to the new target and
    # fires `ProgressEvent`.
    SetRequiredProgress<public><final><native>(InRequiredProgress: float)<transacts>: void

    # Current progress toward `RequiredProgress`; an authored value is clamped
    # to `[0, RequiredProgress]` at activation.
    # Write it with `SetProgress`.
    var<private> Progress<public><native>: float = external {}

    # Target progress for completion; an authored value is not clamped, and `0`
    # reads complete from activation.
    # Write it with `SetRequiredProgress`.
    var<private> RequiredProgress<public><native>: float
  }

  using { /Verse.org }
  progress_objective_snapshot<epic_internal><native> := class<epic_internal><final><persistable> {
    ObjectiveId<epic_internal><native>: string = external {}

    ObjectiveVersePath<epic_internal><native>: string = external {}

    Progress<epic_internal><native>: float = external {}

    RequiredCount<epic_internal><native>: float = external {}
  }

  using { /Verse.org/Assets }
  using { /Verse.org/Presentation }
  # A category to represent a set of quests, usually for UI purposes.
  quest_category<public><native> := class<abstract><unique><castable>(has_icon, has_description) {
    # The category this one is nested under; `false` is a top-level category.
    Parent<public><native>: ?quest_category = external {}

    # Relative ordering among categories; lower values sort first.
    SortOrder<public><native>: rational
  }

  quest_extension<epic_internal><native> := class<epic_internal><abstract><castable> {
    CanAbandon<epic_internal><native><native_callable>(
      QuestParticipant: (/Verse.org:)Progression.quest_participant
    )<reads>: result(void, [](/Verse.org:)Progression.abandon_quest_error)

    CanGrantRewards<epic_internal><native><native_callable>(
      Memberships: [](/Verse.org:)Progression.quest_membership
    )<reads>: result(void, []quest_reward_error)

    CanJoin<epic_internal><native><native_callable>(
      QuestParticipant: (/Verse.org:)Progression.quest_participant
    )<reads>: result(void, [](/Verse.org:)Progression.join_quest_error)

    GetOwningQuest<epic_internal><final><native>()<decides><reads>: (/Verse.org:)Progression.quest

    OnAbandon<epic_internal><native><native_callable>(
      QuestParticipant: (/Verse.org:)Progression.quest_participant
    ): void

    OnActivate<epic_internal><native><native_callable>(): void

    OnComplete<epic_internal><native><native_callable>(Reason: (/Verse.org:)Progression.complete_objective_reason): void

    OnDeactivate<epic_internal><native><native_callable>(): void

    OnJoin<epic_internal><native><native_callable>(QuestParticipant: (/Verse.org:)Progression.quest_participant): void
  }

  quest_membership_data<epic_internal><native> := class<epic_internal><final><persistable> {
    Contributes<epic_internal><native>: logic = external {}

    Observes<epic_internal><native>: logic = external {}

    ParticipantKey<epic_internal><native>: string = external {}

    Receives<epic_internal><native>: logic = external {}
  }

  quest_progress_data<epic_internal><native> := class<epic_internal><final><persistable> {
    Failed<epic_internal><native>: logic = external {}

    Memberships<epic_internal><native>: []quest_membership_data = external {}

    Objective<epic_internal><native>: ?objective_snapshot = external {}

    QuestId<epic_internal><native>: string = external {}

    QuestVersePath<epic_internal><native>: string = external {}

    State<epic_internal><native>: (/Verse.org:)Progression.quest_state = external {}
  }

  # A unit of payout a quest hands to its memberships. Subclass it to grant
  # anything: an item, currency, experience or an unlock.
  #   * Grant 100 gold to every participant set to receive when the
  #     quest completes.
  #   * Unlock the next area for the whole server.
  #   * Grant a bonus reward to participants whose membership `Info` matches
  #     a condition.
  quest_reward<public><native> := class<abstract><unique><castable>(has_icon, has_description) {
    # Succeeds if this reward may be granted at all; the default succeeds, and a
    # veto is an error return.
    CanGrant<public><native><native_callable>()<reads>: result(void, []quest_reward_error)

    # Succeeds if `Membership` may receive this reward; the default succeeds,
    # and a refusal drops that membership from the grant and is not an error
    # on `Grant`.
    CanReceive<public><native><native_callable>(
      Membership: (/Verse.org:)Progression.quest_membership
    )<reads>: result(void, []quest_reward_error)

    # Grants this reward over `Memberships` and returns the ones it handed to
    # `OnGrant`: asks `CanGrant`, keeps the memberships `CanReceive` accepts,
    # collapses duplicates and hands that set to `OnGrant`.
    # A `CanGrant` refusal is the only error: nothing is delivered and the
    # guard's own errors come back.
    Grant<public><final><native>(
      Memberships: [](/Verse.org:)Progression.quest_membership
    )<transacts>: result([](/Verse.org:)Progression.quest_membership, []quest_reward_error)

    # Signaled after `Grant` handed its recipients to `OnGrant`.
    GrantEvent<public><final><native>: listenable(quest_reward_grant_event_data) = external {}

    # Delivers this reward over `Memberships`, the ones `CanReceive` accepted.
    OnGrant<protected><native_callable>(Memberships: [](/Verse.org:)Progression.quest_membership)<transacts>: void

    # Returns the memberships `Grant` would pay right now; runs no payout and
    # fires nothing.
    Preview<public><final><native>(
      Memberships: [](/Verse.org:)Progression.quest_membership
    )<reads>: [](/Verse.org:)Progression.quest_membership
  }

  # Returned when a reward cannot be granted.
  quest_reward_error<public><native> := class<abstract><computes><castable> {}

  # Delivered by `quest_reward.GrantEvent`.
  quest_reward_grant_event_data<public><native> := struct<epic_internal> {
    # The memberships the reward was issued to, which may be empty.
    Recipients<public><native>: [](/Verse.org:)Progression.quest_membership

    # The reward that was granted.
    Reward<public><native>: quest_reward
  }

  using { /Verse.org/SceneGraph }
  register_gameplay_conditional_error<public><native> := class<epic_internal> {}

  register_verb_error<public><native> := class<epic_internal> {}

  reward_claim_quest_extension<epic_internal><native> := class<epic_internal>(quest_extension) {
    CanGrantRewards<override><native><native_callable>(
      Memberships: [](/Verse.org:)Progression.quest_membership
    )<reads>: result(void, []quest_reward_error)

    # Pays the owning quest's live roster at claim time; members who abandoned
    # (or were revoked) after completion are not paid, and the claim
    # still latches.
    ClaimRewards<epic_internal><native><native_callable>()<transacts>: result(void, []claim_reward_error)

    IsReadyToClaim<epic_internal><native><native_callable>()<decides><reads>: void

    RewardsClaimedEvent<epic_internal><final><native>: listenable(reward_claim_quest_extension) = external {}

    RewardsReadyEvent<epic_internal><final><native>: listenable(reward_claim_quest_extension) = external {}

    var<private> Claimed<epic_internal><native>: logic = external {}

    var<private> PendingClaim<epic_internal><native>: logic = external {}
  }

  # An objective that requires completing a sequence of sub-objectives in order,
  # advancing to the next sub-objective when the current one is complete.
  # The stage cursor advances only while the sequence is active; sub-objectives
  # completed while it is inactive are skipped at the next Activate; a finished
  # sequence reads Complete on restore without activation.
  sequential_objective<epic_internal><native> := class<epic_internal>(
    (/Verse.org:)Progression.objective,
    (/Verse.org:)Progression.has_objective_contributors,
    (/Verse.org:)Progression.has_objective_anchor
  ) {
    AddContributor<final><override>(Agent: agent)<transacts>: void = external {}

    GetProgress<override><native><native_callable>()<reads>: message

    OnActivate<override><native><native_callable>()<transacts>: void

    OnDeactivate<override><native><native_callable>()<transacts>: void

    RemoveContributor<final><override>(Agent: agent)<transacts>: void = external {}

    RouteAddContributor<epic_internal><native_callable>(
      Child: (/Verse.org:)Progression.objective,
      Agent: agent
    )<transacts>: void = external {}

    RouteRemoveContributor<epic_internal><native_callable>(
      Child: (/Verse.org:)Progression.objective,
      Agent: agent
    )<transacts>: void = external {}

    RouteSetAnchor<epic_internal><native_callable>(
      Child: (/Verse.org:)Progression.objective,
      InAnchor: entity
    )<transacts>: void = external {}

    SetAnchor<final><override>(InAnchor: entity)<transacts>: void = external {}

    var Objectives<epic_internal><native>: [](/Verse.org:)Progression.objective

    var<private> CurrentStageIndex<epic_internal><native>: int = external {}
  }

  sequential_objective_snapshot<epic_internal><native> := class<epic_internal><final><persistable> {
    Children<epic_internal><native>: []objective_snapshot = external {}

    CurrentIndex<epic_internal><native>: int = external {}

    ObjectiveId<epic_internal><native>: string = external {}

    ObjectiveVersePath<epic_internal><native>: string = external {}
  }

  # An objective driven by a state machine, where each state holds an objective
  # and the machine transitions as those objectives complete; complete when a
  # completion state is reached.
  # Complete derives from the live machine's active leaves; an unwired machine
  # reads not-complete and the persisted state id is diagnostic only.
  state_machine_objective<epic_internal><native> := class<epic_internal>(
    (/Verse.org:)Progression.objective,
    (/Verse.org:)Progression.has_objective_contributors,
    (/Verse.org:)Progression.has_objective_anchor
  ) {
    AddContributor<final><override>(Agent: agent)<transacts>: void = external {}

    GetProgress<override><native><native_callable>()<reads>: message

    OnActivate<override><native><native_callable>()<transacts>: void

    RemoveContributor<final><override>(Agent: agent)<transacts>: void = external {}

    RouteAddContributor<epic_internal><native_callable>(
      Child: (/Verse.org:)Progression.objective,
      Agent: agent
    )<transacts>: void = external {}

    RouteRemoveContributor<epic_internal><native_callable>(
      Child: (/Verse.org:)Progression.objective,
      Agent: agent
    )<transacts>: void = external {}

    RouteSetAnchor<epic_internal><native_callable>(
      Child: (/Verse.org:)Progression.objective,
      InAnchor: entity
    )<transacts>: void = external {}

    SetAnchor<final><override>(InAnchor: entity)<transacts>: void = external {}

    UpdateCurrentState<epic_internal><final><native>(): void

    var (/UnrealEngine.com/Progression/state_machine_objective:)StateMachine<epic_internal><native>: state_machine

    var CompletionStates<epic_internal><native>: []state

    var<private> CurrentState<epic_internal><native>: ?objective_machine_state = external {}
  }

  state_machine_objective_snapshot<epic_internal><native> := class<epic_internal><final><persistable> {
    CurrentStateId<epic_internal><native>: string = external {}

    ObjectiveId<epic_internal><native>: string = external {}

    ObjectiveVersePath<epic_internal><native>: string = external {}
  }

  timed_objective<epic_internal><native> := class<epic_internal>(
    (/Verse.org:)Progression.objective,
    (/Verse.org:)Progression.has_objective_contributors,
    (/Verse.org:)Progression.has_objective_anchor
  ) {
    AddContributor<final><override>(Agent: agent)<transacts>: void = external {}

    GetProgress<override><native><native_callable>()<reads>: message

    RemoveContributor<final><override>(Agent: agent)<transacts>: void = external {}

    RouteAddContributor<epic_internal><native_callable>(
      Child: (/Verse.org:)Progression.objective,
      Agent: agent
    )<transacts>: void = external {}

    RouteRemoveContributor<epic_internal><native_callable>(
      Child: (/Verse.org:)Progression.objective,
      Agent: agent
    )<transacts>: void = external {}

    RouteSetAnchor<epic_internal><native_callable>(
      Child: (/Verse.org:)Progression.objective,
      InAnchor: entity
    )<transacts>: void = external {}

    SetAnchor<final><override>(InAnchor: entity)<transacts>: void = external {}

    TimeExpiredEvent<epic_internal><final><native>: listenable(timed_objective) = external {}

    UpdateTimeRemaining<epic_internal><final><native>(DeltaSeconds: float)<transacts>: void

    var Objective<epic_internal><native>: (/Verse.org:)Progression.objective

    var TimeLimit<epic_internal><native>: float

    var<private> TimeRemaining<epic_internal><native>: float
  }

  timed_objective_snapshot<epic_internal><native> := class<epic_internal><final><persistable> {
    Inner<epic_internal><native>: ?objective_snapshot = external {}

    ObjectiveId<epic_internal><native>: string = external {}

    ObjectiveVersePath<epic_internal><native>: string = external {}

    TimeRemainingMs<epic_internal><native>: int = external {}
  }

  verb_filter<public><native> := class<epic_internal><abstract> {
    Evaluate<epic_internal><native_callable>(SceneEvent: scene_event)<decides>: void

    GetDelta<epic_internal><native_callable>(SceneEvent: scene_event): float
  }

  verb_listener_handle<public><native> := class<epic_internal><final> {
    AddParticipant<epic_internal><native>(Entity: entity)<transacts>: void

    GetParticipants<epic_internal><native>()<reads>: []entity

    IsRegistered<epic_internal><native>()<transacts><decides>: void

    RemoveParticipant<epic_internal><native>(Entity: entity)<transacts>: void

    Unregister<epic_internal><native>(): void
  }

  verb_router_component<public><native> := class<epic_internal><final_super>(component) {
    OnReceive<override>(SceneEvent: scene_event): logic = external {}
  }

  xp_entitlement<epic_internal><native> := class(ecosystem_entitlement) {
    Consumable<final><override>: logic = external {}
  }
}

Social<public> := module {
  @available { MinUploadedAtFNVersion := 4210 }
  # Returns the party context for `InPlayer`.
  # Filters by the simulation_entity owning this player.
  # A player is always in a party of at least 1 (themselves).
  (InPlayer: player).GetLocalParty<public><native>()<reads>: agent_group_interface(party_member_info)

  using { /Verse.org/AgentGroup }
  using { /Verse.org/Native }
  using { /Verse.org/Simulation }
  # Verse path: /UnrealEngine.com/Social
  @available { MinUploadedAtFNVersion := 4210 }
  # Per-member info for party members. Can be extended with additional fields in
  # future versions.
  party_member_info<public><native> := class<epic_internal>(member_info_interface) {}
}

# Verse path: /UnrealEngine.com
# Module import path: /UnrealEngine.com/StateMachine
(/UnrealEngine.com:)StateMachine<public> := module {
  # Creates a new unique state handle. Each call returns a handle with a
  # unique Id.
  MakeStateHandle<public><native>(): state_handle

  using { /Verse.org/StateMachine }
  # Module import path: /UnrealEngine.com/StateMachine/Patterns
  Patterns<public> := module {
    # Makes states from a list of factories.  Try each factory until one
    # succeeds.  Returns the leaf states of the first factory that succeed.
    # Fails if no factory succeed.
    LinearSelector<epic_internal>(
      Factories: []type { _()<transacts><decides>: make_leaves_result }
    )<transacts><decides>: select_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory until one
    # succeeds.  Returns the leaf states of the first factory that succeed.
    # Fails if no factory succeed.  Used when the states can be injected
    # or dynamic.
    LinearSelectorFrom<epic_internal>((
      Parent: t,
      Factories: []type { _(: t)<transacts><decides>: make_leaves_result }
    ) where t: type)<transacts><decides>: select_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in order and
    # compare the weighted score of each factory.  The factory with the biggest
    # weighted score wins.  Returns the leaf states of the factory that succeed
    # and has the biggest score.  Fails if no factory succeed.
    MaxWeightSelector<epic_internal>(
      Factories: []type { _()<transacts><decides>: scored_leaves_result }
    )<transacts><decides>: select_scored_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in order and
    # compare the weighted score of each factory.  The factory with the biggest
    # weighted score wins.  Returns the leaf states of the factory that succeed
    # and has the biggest score.  Fails if no factory succeed.  Used when the
    # states can be injected or dynamic.
    MaxWeightSelectorFrom<epic_internal>((
      Parent: t,
      Factories: []type { _(: t)<transacts><decides>: scored_leaves_result }
    ) where t: type)<transacts><decides>: select_scored_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in order and
    # compare the weighted score of each factory.  The factory with the lowest
    # weighted score wins.  Returns the leaf states of the factory that succeed
    # and has the lowest score.  Fails if no factory succeed.
    MinWeightSelector<epic_internal>(
      Factories: []type { _()<transacts><decides>: scored_leaves_result }
    )<transacts><decides>: select_scored_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in order and
    # compare the weighted score of each factory.  The factory with the lowest
    # weighted score wins.  Returns the leaf states of the factory that succeed
    # and has the lowest score.  Fails if no factory succeed.  Used when the
    # states can be injected or dynamic.
    MinWeightSelectorFrom<epic_internal>((
      Parent: t,
      Factories: []type { _(: t)<transacts><decides>: scored_leaves_result }
    ) where t: type)<transacts><decides>: select_scored_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in a random order
    # until one succeeds.  Returns the leaf states of the first random factory
    # that succeed.  Fails if no factory succeed.
    RandomSelector<epic_internal>(
      Factories: []type { _()<transacts><decides>: make_leaves_result }
    )<transacts><decides>: select_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in a random order
    # until one succeeds.  Returns the leaf states of the first random factory
    # that succeed.  Fails if no factory succeed.  Used when the states can be
    # injected or dynamic.
    RandomSelectorFrom<epic_internal>((
      Parent: t,
      Factories: []type { _(: t)<transacts><decides>: make_leaves_result }
    ) where t: type)<transacts><decides>: select_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in the sequence
    # from the provided Index.  Returns the leaf states of the first factory
    # that succeed from Index.  Fails if no factory succeed.
    TrySequencer<epic_internal>(
      Factories: []type { _()<transacts><decides>: make_leaves_result },
      Index: int
    )<transacts><decides>: select_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in the sequence
    # from the provided Index.  Returns the leaf states of the first factory
    # that succeed from Index.  Fails if no factory succeed.  Used when the
    # states can be injected or dynamic.
    TrySequencerFrom<epic_internal>((
      Parent: t,
      Factories: []type { _(: t)<transacts><decides>: make_leaves_result },
      Index: int
    ) where t: type)<transacts><decides>: select_leaves_result = external {}
  }

  # The result of a make state function.  Contains the terminal states of the
  # selection.  It can returns more than one leaf if it contains
  # parallel states.
  make_leaves_result<epic_internal> := struct {
    Leaves: []state = external {}
  }

  # The result of a make state function.  Contains the created state and
  # terminal states of the selection.  It can returns more than one leaf if it
  # contains parallel states.
  make_state_result<epic_internal>(state_type: type) := struct {
    Leaves: []state

    State: state_type
  }

  # The result of a make state function with an heuristic function.  Contains
  # the terminal states of the selection and the score of the selected factory.
  scored_leaves_result<epic_internal> := struct {
    Leaves: []state = external {}

    Score: float
  }

  # The result of a selector pattern such as LinearSelector or RandomSelector.
  # Contains the terminal states of the selection and the index of the
  # selected factory.
  select_leaves_result<epic_internal> := struct {
    Index: int

    Leaves: []state = external {}
  }

  # The result of a heuristic selector pattern such as MinWeightedSelector.
  # Contains the terminal states of the selection, the index of the selected
  # factory .
  select_scored_leaves_result<epic_internal> := struct {
    Index: int

    Leaves: []state = external {}

    Score: float
  }

  # Event sent via SendUp when a final state completes.  Propagates up the
  # parent chain until a parent handles it in OnReceive.
  state_completed_event<epic_internal> := class(state_event) {
    Result<public>: state_completed_result
  }

  # The result of a state's completion.  Used by final states to signal whether
  # they completed successfully or failed.
  state_completed_result<epic_internal> := enum {
    Failure

    Success
  }

  # A comparable, hashable handle that uniquely identifies a state factory.
  # Created via MakeStateHandle. Cannot be constructed directly by external
  # code.  Use this to register, unregister, and identify factories.
  state_handle<public><native> := struct<concrete><computes> {
    Id<native>: int = external {}
  }

  # State that starts a suspends task and ends the task when it exits
  suspended_state<epic_internal> := class<final_super><abstract><unique>(state) {
    OnEnter<override>(): void = external {}

    OnExit<override>(): void = external {}

    OnSimulate<public>()<suspends>: void = external {}
  }
}

Temporary<public> := module {
  # Verse path: /UnrealEngine.com/Temporary
  # Module import path: /UnrealEngine.com/Temporary/Curves
  Curves<public> := module {
    editable_curve<public><native> := class<final><concrete> {
      # Evaluates this float curve at the specified time and returns the result
      # as a float
      Evaluate<public><native>(Time: float): float
    }
  }

  # Module import path: /UnrealEngine.com/Temporary/Diagnostics
  (/UnrealEngine.com/Temporary:)Diagnostics<public> := module {
    # debug draw class to draw debug shapes on screen.
    debug_draw<public><native> := class {
      # Channel will be used to clear specific debug draw.
      Channel<public><native>: subtype(debug_draw_channel) = external {}

      # Clears all debug draw from this debug_draw instance.
      Clear<public><native>()<transacts>: void

      # Clears all debug draw for the channel.
      ClearChannel<public><native>()<transacts>: void

      # Draws an arrow pointing from Start to End locations, and using the
      # provided draw parameters.
      DrawArrow<public><native>(
        Start: (/Verse.org/SpatialMath:)vector3,
        End: (/Verse.org/SpatialMath:)vector3,
        ?ArrowSize: float = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws an arrow pointing from Start to End locations, and using the
      # provided draw parameters.
      DrawArrow<public>(
        Start: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        End: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        ?ArrowSize: float = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void = external {}

      # Draws a box at the named location, and using the provided
      # draw parameters
      DrawBox<public><native>(
        Center: (/Verse.org/SpatialMath:)vector3,
        Rotation: (/Verse.org/SpatialMath:)rotation,
        ?Extent: (/Verse.org/SpatialMath:)vector3 = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws a box at the named location, and using the provided
      # draw parameters
      DrawBox<public>(
        Center: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
        ?Extent: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void = external {}

      # Draws a capsule at the named location, and using the provided
      # draw parameters.
      DrawCapsule<public><native>(
        Center: (/Verse.org/SpatialMath:)vector3,
        Rotation: (/Verse.org/SpatialMath:)rotation,
        ?Height: float = external {},
        ?Radius: float = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws a capsule at the named location, and using the provided
      # draw parameters.
      DrawCapsule<public>(
        Center: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
        ?Height: float = external {},
        ?Radius: float = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void = external {}

      # Draws a cone at the named location, and using the provided
      # draw parameters.
      DrawCone<public><native>(
        Origin: (/Verse.org/SpatialMath:)vector3,
        Direction: (/Verse.org/SpatialMath:)vector3,
        ?Height: float = external {},
        ?NumSides: int = external {},
        ?AngleWidthRadians: float = external {},
        ?AngleHeightRadians: float = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws a cone at the named location, and using the provided
      # draw parameters.
      DrawCone<public>(
        Origin: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        Direction: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        ?Height: float = external {},
        ?NumSides: int = external {},
        ?AngleWidthRadians: float = external {},
        ?AngleHeightRadians: float = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void = external {}

      # Draws a cylinder at the named location, and using the provided
      # draw parameters.
      DrawCylinder<public><native>(
        Start: (/Verse.org/SpatialMath:)vector3,
        End: (/Verse.org/SpatialMath:)vector3,
        ?NumSegments: int = external {},
        ?Radius: float = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws a cylinder at the named location, and using the provided
      # draw parameters.
      DrawCylinder<public>(
        Start: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        End: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        ?NumSegments: int = external {},
        ?Radius: float = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void = external {}

      # Draws a line from Start to End locations, and using the provided
      # draw parameters.
      DrawLine<public><native>(
        Start: (/Verse.org/SpatialMath:)vector3,
        End: (/Verse.org/SpatialMath:)vector3,
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws a line from Start to End locations, and using the provided
      # draw parameters.
      DrawLine<public>(
        Start: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        End: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void = external {}

      # Draws a point at the named location, and using the provided
      # draw parameters.
      DrawPoint<public><native>(
        Position: (/Verse.org/SpatialMath:)vector3,
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws a point at the named location, and using the provided
      # draw parameters.
      DrawPoint<public>(
        Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void = external {}

      # Draws a sphere at the named location, and using the provided
      # draw parameters.
      DrawSphere<public><native>(
        Center: (/Verse.org/SpatialMath:)vector3,
        ?Radius: float = external {},
        ?Color: color = external {},
        ?NumSegments: int = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws a sphere at the named location, and using the provided
      # draw parameters.
      DrawSphere<public>(
        Center: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        ?Radius: float = external {},
        ?Color: color = external {},
        ?NumSegments: int = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void = external {}

      # Draws a 3D text using the provided draw parameters.
      DrawText<public><native>(
        Text: string,
        Position: (/Verse.org/SpatialMath:)vector3,
        ?Color: color = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {},
        ?FontScale: float = external {},
        ?DrawDropShadow: logic = external {}
      )<transacts>: void

      # Draws a 3D text using the provided draw parameters.
      DrawText<public>(
        Text: string,
        Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        ?Color: color = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {},
        ?FontScale: float = external {},
        ?DrawDropShadow: logic = external {}
      )<transacts>: void = external {}

      # Hide Debug Draw for the channel for all users.
      HideChannel<public><native>()<transacts>: void

      # Show Debug Draw for the channel for all users.
      ShowChannel<public><native>()<transacts>: void
    }

    # debug_draw_channel is the base class used to define debug draw channels.
    debug_draw_channel<public><native> := class<abstract> {}

    using { /UnrealEngine.com/Temporary/SpatialMath }
    using { /Verse.org/Colors }
    using { /Verse.org/Native }
    using { /Verse.org/SpatialMath }
    # Enumerated presets for policies describing a desired draw duration.
    debug_draw_duration_policy<public><native> := enum {
      FiniteDuration

      Persistent

      SingleFrame
    }

    # log class to send messages to the default log
    log<public><native> := class {
      # Channel class name will be added as a prefix used when printing the
      # message e.g. '[log_channel]: #Message
      Channel<public><native>: subtype(log_channel)

      @available { MinUploadedAtFNVersion := 4000 }
      # Sets the current debug diagnostic display `Color` that will be applied
      # to all future Print calls. By default, `Color` is `NamedColors.White`,
      # Only used if Duration is greater than `0.0`.
      Color<epic_internal><native>: color = external {}

      # Sets the default log level of the displayed message. See log_level enum
      # for more info on log levels. Defaults to log_level.Normal.
      DefaultLevel<public><native>: log_level = external {}

      @available { MinUploadedAtFNVersion := 4000 }
      # If set to greater than 0.0, displays the log on the screen in
      # debug environments.
      Duration<epic_internal><native>: float = external {}

      # Print `Message` using the given log level.
      (/UnrealEngine.com/Temporary/Diagnostics/log:)Print<epic_internal>(
        Message: message,
        ?Level: log_level = external {}
      )<reads>: void = external {}

      # Print `Message` diagnostic using the given log level.
      (/UnrealEngine.com/Temporary/Diagnostics/log:)Print<public>(
        Message: diagnostic,
        ?Level: log_level = external {}
      )<computes>: void = external {}

      # Print `Message` using the given log level.
      (/UnrealEngine.com/Temporary/Diagnostics/log:)Print<public>(
        Message: string,
        ?Level: log_level = external {}
      )<computes>: void = external {}

      # Prints the current script call stack using the given log level.
      PrintCallStack<public><native>(?Level: log_level = external {})<computes>: void
    }

    # log_channel is the base class used to define log channels. When printing a
    # message to a log, the log channel class name will be prefixed to the
    # output message.
    log_channel<public><native> := class<abstract> {}

    # log levels available for various log commands
    log_level<public><native> := enum {
      Debug

      Error

      Normal

      Verbose

      Warning
    }
  }

  # Stably sort `Array` using `Less` where `Less` succeeding indicates `Left`
  # should precede `Right`
  SortBy<public><native>((Array: []t, Less: type { _(: t, : t)<computes><decides>: void }) where t: type)<computes>: []t

  # Module import path: /UnrealEngine.com/Temporary/SpatialMath
  (/UnrealEngine.com/Temporary:)SpatialMath<public> := module {
    # Makes a `rotation` by applying `AngleRadians` of left-handed rotation
    # around the local +Y axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyLocalRotationY<public>(
      AngleRadians: float
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {}

    # Makes a `rotation` by applying `AngleRadians` of left-handed rotation
    # around the local +Z axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyLocalRotationZ<public>(
      AngleRadians: float
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {}

    # Makes a `rotation` by applying `PitchUpRadians` of right-handed rotation
    # around the local +Y axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyPitch<public><native>(
      PitchUpRadians: float
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by applying `RollClockwiseRadians` of right-handed
    # rotation around the local +X axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyRoll<public><native>(
      RollClockwiseRadians: float
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by applying `AngleRadians` of left-handed rotation
    # around the world +X axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyWorldRotationX<public><native>(
      AngleRadians: float
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by applying `AngleRadians` of left-handed rotation
    # around the world +Y axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyWorldRotationY<public><native>(
      AngleRadians: float
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by applying `AngleRadians` of left-handed rotation
    # around the world +Z axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyWorldRotationZ<public><native>(
      AngleRadians: float
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by applying `YawRightRadians` of left-handed rotation
    # around the local +Z axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyYaw<public><native>(
      YawRightRadians: float
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by composing `AdditionalRotation` to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).RotateBy<public><native>(
      AdditionalRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by composing the inverse of `RotationToRemove` from
    # `InitialRotation`. such that InitialRotation
    # = RotateBy(UnrotateBy(InitialRotation, RotationToRemove),
    # RotationToRemove). This is equivalent to
    # RotateBy(InitialRotation, InvertRotation(RotationToRemove))
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).UnrotateBy<public><native>(
      RotationToRemove: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    @vm_no_effect_token
    # Makes a `vector3` from the axis of `rotation`.
    # If `rotation` is nearly identity, this will return the +X axis. See
    # also `GetAngle`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).(/UnrealEngine.com/Temporary/SpatialMath:)GetAxis<public><native>()<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3

    @vm_no_effect_token
    # Makes an `[]float` with three elements:
    #  * *yaw* degrees of `rotation`
    #  * *pitch* degrees of `rotation`
    #  * *roll* degrees of `rotation`
    # using the conventions of `MakeRotationFromYawPitchRollDegrees`.
    (
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    ).(/UnrealEngine.com/Temporary/SpatialMath:)GetYawPitchRollDegrees<public><native>()<reads>: []float

    # Makes a `rotation` by inverting `Rotation` such
    # that `ApplyRotation(Rotation, Rotation.Invert())) = IdentityRotation`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).(/UnrealEngine.com/Temporary/SpatialMath:)Invert<public><native>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Returns `Rotation` if it does not contain `NaN`, `Inf` or `-Inf`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).(/UnrealEngine.com/Temporary/SpatialMath:)IsFinite<public><native>()<decides><converges>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    @vm_no_effect_token
    # Returns the radians of `rotation` around the axis of `rotation`. See
    # also `GetAxis`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).GetAngle<public><native>()<reads>: float

    # Makes a unit `vector3` pointing in the local space *forward* direction in
    # world space coordinates.
    # This is equivalent
    # to: `RotateVector(Rotation, vector3{X:=1.0, Y:=0.0, Z:=0.0})`.
    (
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    ).GetLocalForward<public>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a unit `vector3` pointing in the the local space *right* direction
    # in world space coordinates.
    # This is equivalent
    # to: `RotateVector(Rotation, vector3{X:=0.0, Y:=1.0, Z:=0.0})`.
    (
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    ).GetLocalRight<public>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a unit `vector3` pointing in the local space *up* direction in world
    # space coordinates.
    # This is equivalent
    # to: `RotateVector(Rotation, vector3{X:=0.0, Y:=0.0, Z:=1.0})`.
    (
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    ).GetLocalUp<public>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    @vm_no_effect_token
    # Makes a `vector3` by applying `Rotation` to `Vector`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).RotateVector<public><native>(
      Vector: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3

    @vm_no_effect_token
    # Makes a `vector3` by applying the inverse of `Rotation` to `Vector`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).UnrotateVector<public><native>(
      Vector: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3

    # Succeeds when each component of `V` is within `AbsoluteTolerance`
    # of `0.0`.
    (
      V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    ).(/UnrealEngine.com/Temporary/SpatialMath:)IsAlmostZero<public>(
      AbsoluteTolerance: float
    )<computes><decides>: void = external {}

    # Returns `V` if all components are finite.
    # Fails if any of the components are not finite.
    (V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3).(/UnrealEngine.com/Temporary/SpatialMath:)IsFinite<public>()<computes><decides>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Returns the length of `V`.
    (
      V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    ).(/UnrealEngine.com/Temporary/SpatialMath:)Length<public>()<reads>: float = external {}

    # Returns the squared length of `V`.
    (
      V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    ).(/UnrealEngine.com/Temporary/SpatialMath:)LengthSquared<public>()<computes>: float = external {}

    # Makes a unit length `vector3` pointing in the same direction of `V`.
    # Fails if `V.IsAlmostZero[] or not V.IsFinite[]`.
    (V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3).(/UnrealEngine.com/Temporary/SpatialMath:)MakeUnitVector<public>()<decides><reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Returns the squared length of `V` as if `V.Z = 0.0`.
    (V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3).LengthSquaredXY<public>()<reads>: float = external {}

    # Returns the length of `V` as if `V.Z = 0.0`.
    (V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3).LengthXY<public>()<reads>: float = external {}

    # Succeeds when each component of `V` is within `AbsoluteTolerance`
    # of `0.0`.
    (V: vector2).(/UnrealEngine.com/Temporary/SpatialMath:)IsAlmostZero<public>(
      AbsoluteTolerance: float
    )<computes><decides>: void = external {}

    # Returns `V` if all components are finite.
    # Fails if any of the components are not finite.
    (V: vector2).(/UnrealEngine.com/Temporary/SpatialMath:)IsFinite<public>()<computes><decides>: vector2 = external {}

    # Returns the length of `V`.
    (V: vector2).(/UnrealEngine.com/Temporary/SpatialMath:)Length<public>()<reads>: float = external {}

    # Returns the squared length of `V`.
    (V: vector2).(/UnrealEngine.com/Temporary/SpatialMath:)LengthSquared<public>()<reads>: float = external {}

    # Makes a unit length `vector2` pointing in the same direction of `V`.
    # Fails if `V.IsAlmostZero[] or not V.IsFinite[]`.
    (
      V: vector2
    ).(/UnrealEngine.com/Temporary/SpatialMath:)MakeUnitVector<public>()<decides><reads>: vector2 = external {}

    @vm_no_effect_token
    # Returns the 'smallest angular distance' between `Rotation1` and
    # `Rotation2` in radians.
    AngularDistance<public><native>(
      Rotation1: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      Rotation2: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<reads>: float

    # Returns the cross product of `V1` and `V2`.
    (/UnrealEngine.com/Temporary/SpatialMath:)CrossProduct<public>(
      V1: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      V2: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Returns radians from `Degrees`.
    (/UnrealEngine.com/Temporary/SpatialMath:)DegreesToRadians<public>(Degrees: float)<reads>: float = external {}

    @vm_no_effect_token
    # Returns the 'distance' between `Rotation1` and `Rotation2`. The result
    # will be between:
    #  * `0.0`, representing equivalent rotations and
    #  * `1.0` representing rotations which are 180 degrees apart (i.e., the
    #    shortest rotation between them is 180 degrees around some axis).
    (/UnrealEngine.com/Temporary/SpatialMath:)Distance<public><native>(
      Rotation1: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      Rotation2: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<reads>: float

    # Returns the Euclidean distance between `V1` and `V2`.
    (/UnrealEngine.com/Temporary/SpatialMath:)Distance<public>(
      V1: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      V2: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: float = external {}

    # Returns the Euclidean distance between `V1` and `V2`.
    (/UnrealEngine.com/Temporary/SpatialMath:)Distance<public>(V1: vector2, V2: vector2)<reads>: float = external {}

    # Returns the squared Euclidean distance between `V1` and `V2`.
    (/UnrealEngine.com/Temporary/SpatialMath:)DistanceSquared<public>(
      V1: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      V2: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: float = external {}

    # Returns the squared Euclidean distance between `V1` and `V2`.
    (/UnrealEngine.com/Temporary/SpatialMath:)DistanceSquared<public>(
      V1: vector2,
      V2: vector2
    )<reads>: float = external {}

    # Returns the squared 2-D Euclidean distance between `V1` and `V2` by
    # ignoring their difference in `Z`.
    DistanceSquaredXY<public>(
      V1: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      V2: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: float = external {}

    # Returns the 2-D Euclidean distance between `V1` and `V2` by ignoring the
    # difference in `Z`.
    DistanceXY<public>(
      V1: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      V2: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: float = external {}

    # Returns the dot product of `V1` and `V2`.
    (/UnrealEngine.com/Temporary/SpatialMath:)DotProduct<public>(
      V1: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      V2: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: float = external {}

    # Returns the dot product of `V1` and `V2`.
    (/UnrealEngine.com/Temporary/SpatialMath:)DotProduct<public>(V1: vector2, V2: vector2)<reads>: float = external {}

    # Returns the dot product of `V1` and `V2`.
    (/UnrealEngine.com/Temporary/SpatialMath:)DotProduct<public>(
      V1: vector2i,
      V2: vector2i
    )<computes>: int = external {}

    # Makes a `vector2i` that is component-wise equal to `V1` and `V2`.
    # Fails if any component of `V1` does not equal the corresponding component
    # of `V2`.
    Equals<public>(V1: vector2i, V2: vector2i)<computes><decides>: vector2i = external {}

    @available { MinUploadedAtFNVersion := 3400 }
    # Util function for converting a `rotation` from
    # /UnrealEngine.com/Temporary/SpatialMath to a `rotation`
    # from /Verse.org/SpatialMath.
    FromRotation<public>(
      InRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<reads>: (/Verse.org/SpatialMath:)rotation = external {}

    @available { MinUploadedAtFNVersion := 3400 }
    # Util function for converting a `rotation` from /Verse.org/SpatialMath to a
    # `rotation` from /UnrealEngine.com/Temporary/SpatialMath.
    FromRotation<public>(
      InRotation: (/Verse.org/SpatialMath:)rotation
    )<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {}

    @available { MinUploadedAtFNVersion := 3600 }
    # Util function for converting a scalar `vector3` from
    # /UnrealEngine.com/Temporary/SpatialMath to a `vector3`
    # from /Verse.org/SpatialMath.
    # Use this function when your vector indicates a magnitude on each axis but
    # not a direction, such as when you convert a scale measurement rather than
    # a translation or position.
    FromScalarVector3<public>(
      InVector3: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: (/Verse.org/SpatialMath:)vector3 = external {}

    @available { MinUploadedAtFNVersion := 3600 }
    # Util function for converting a scalar `vector3` from
    # /Verse.org/SpatialMath to a `vector3`
    # from /UnrealEngine.com/Temporary/SpatialMath.
    # Use this function when your vector indicates a magnitude on each axis but
    # not a direction, such as when you convert a scale measurement rather than
    # a translation or position.
    FromScalarVector3<public>(
      InVector3: (/Verse.org/SpatialMath:)vector3
    )<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    @available { MinUploadedAtFNVersion := 3400 }
    # Util function for converting a `transform` from
    # /UnrealEngine.com/Temporary/SpatialMath to a `transform`
    # from /Verse.org/SpatialMath.
    FromTransform<public>(
      InTransform: (/UnrealEngine.com/Temporary/SpatialMath:)transform
    )<reads>: (/Verse.org/SpatialMath:)transform = external {}

    @available { MinUploadedAtFNVersion := 3400 }
    # Util function for converting a `transform` from /Verse.org/SpatialMath to
    # a `transform` from /UnrealEngine.com/Temporary/SpatialMath.
    FromTransform<public>(
      InTransform: (/Verse.org/SpatialMath:)transform
    )<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)transform = external {}

    @available { MinUploadedAtFNVersion := 3400 }
    # Util function for converting a translation/position `vector3` from
    # /UnrealEngine.com/Temporary/SpatialMath to a `vector3`
    # from /Verse.org/SpatialMath.
    FromVector3<public>(
      InVector3: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: (/Verse.org/SpatialMath:)vector3 = external {}

    @available { MinUploadedAtFNVersion := 3400 }
    # Util function for converting a translation/position `vector3` from
    # /Verse.org/SpatialMath to a `vector3`
    # from /UnrealEngine.com/Temporary/SpatialMath.
    FromVector3<public>(
      InVector3: (/Verse.org/SpatialMath:)vector3
    )<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes the identity `rotation`.
    (/UnrealEngine.com/Temporary/SpatialMath:)IdentityRotation<public><native>()<converges>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Succeeds when each component of `V1` and `V2` are within
    # `AbsoluteTolerance` of each other.
    (/UnrealEngine.com/Temporary/SpatialMath:)IsAlmostEqual<public>(
      V1: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      V2: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      AbsoluteTolerance: float
    )<computes><decides>: void = external {}

    # Succeeds when each component of `V1` and `V2` are within
    # `AbsoluteTolerance` of each other.
    (/UnrealEngine.com/Temporary/SpatialMath:)IsAlmostEqual<public>(
      V1: vector2,
      V2: vector2,
      AbsoluteTolerance: float
    )<computes><decides>: void = external {}

    # Used to linearly interpolate/extrapolate between `From` (when
    # `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that all
    # arguments are finite.
    # Returns `From*(1 - Parameter) + To*Parameter`.
    (/UnrealEngine.com/Temporary/SpatialMath:)Lerp<public>(
      From: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      To: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Parameter: float
    )<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Used to linearly interpolate/extrapolate between `From` (when
    # `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that all
    # arguments are finite.
    # Returns `From*(1 - Parameter) + To*Parameter`.
    (/UnrealEngine.com/Temporary/SpatialMath:)Lerp<public>(
      From: vector2,
      To: vector2,
      Parameter: float
    )<reads>: vector2 = external {}

    # Makes a new `rotation` from the component wise subtraction of the Euler
    # angle components in `RotationA` by the Euler angle components in
    # `RotationB` and ensures the returned value is normalized.
    MakeComponentWiseDeltaRotation<public><native>(
      RotationA: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      RotationB: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    @vm_no_effect_token
    # Makes a `rotation` from `Axis` and `AngleRadians` using a left-handed sign
    # convention (e.g. a positive rotation around +Z takes +X to +Y). If
    # `Axis.IsAlmostZero[]`, make the identity rotation.
    MakeRotation<public><native>(
      Axis: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      AngleRadians: float
    )<reads><converges>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    @vm_no_effect_token
    # Makes a `rotation` by applying `YawRightDegrees`, `PitchUpDegrees`, and
    # `RollClockwiseDegrees`, in that order:
    #  * first a *yaw* about the Z axis with a positive angle indicating a
    #    clockwise rotation when viewed from above,
    #  * then a *pitch* about the new Y axis with a positive angle indicating
    #    'nose up',
    #  * followed by a *roll* about the new X axis axis with a positive angle
    #    indicating a clockwise rotation when viewed along +X.
    # Note that these conventions differ from `MakeRotation` but match
    # `ApplyYaw`, `ApplyPitch`, and `ApplyRoll`.
    (/UnrealEngine.com/Temporary/SpatialMath:)MakeRotationFromYawPitchRollDegrees<public><native>(
      YawRightDegrees: float,
      PitchUpDegrees: float,
      RollClockwiseDegrees: float
    )<reads><converges>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes the smallest angular `rotation` from `InitialRotation` to
    # `FinalRotation` such that:
    # `InitialRotation.RotateBy(MakeShortestRotationBetween(InitialRotation,
    # FinalRotation)) = FinalRotation` and
    # `MakeShortestRotationBetween(InitialRotation, FinalRotation)?.GetAngle()`
    # is as small as possible.
    (/UnrealEngine.com/Temporary/SpatialMath:)MakeShortestRotationBetween<public><native>(
      InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      FinalRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes the smallest angular `rotation` from `InitialVector` to
    # `FinalVector` such that:
    # `InitialVector.RotateBy(MakeShortestRotationBetween(InitialVector,
    # Vector)) = FinalVector` and
    # `MakeShortestRotationBetween(InitialVector, FinalVector)?.GetAngle()` is
    # as small as possible.
    (/UnrealEngine.com/Temporary/SpatialMath:)MakeShortestRotationBetween<public><native>(
      InitialVector: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      FinalVector: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `vector2` with all components `1.0`.
    Ones2<epic_internal>()<computes>: vector2 = external {}

    # Makes a `vector3` with all components `1.0`.
    (/UnrealEngine.com/Temporary/SpatialMath:)Ones<epic_internal>()<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Returns degrees from `Radians`.
    (/UnrealEngine.com/Temporary/SpatialMath:)RadiansToDegrees<public>(Radians: float)<reads>: float = external {}

    # Makes a `vector3` by inverting the `SurfaceNormal` component
    # of `Direction`.
    # Fails if `not SurfaceNormal.MakeUnitVector[]`.
    (/UnrealEngine.com/Temporary/SpatialMath:)ReflectVector<public>(
      Direction: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      SurfaceNormal: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<decides><reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector2` by inverting the `SurfaceNormal` component
    # of `Direction`.
    # Fails if `not SurfaceNormal.MakeUnitVector[]`.
    (/UnrealEngine.com/Temporary/SpatialMath:)ReflectVector<public>(
      Direction: vector2,
      SurfaceNormal: vector2
    )<decides><reads>: vector2 = external {}

    # Used to perform spherical linear interpolation between `From` (when
    # `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects
    # that `0.0 <= Parameter <= 1.0`.
    (/UnrealEngine.com/Temporary/SpatialMath:)Slerp<public><native>(
      InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      FinalRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      Parameter: float
    )<transacts><decides>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `string` representation of `InTransform` where the result is on
    # the form.
    # `"Scale: {ToString(`InTransform.Scale`)} Rotation:
    # {ToString(`InTransform.Rotation`)}
    # Translation: {ToString(`InTransform.Translation`)}.
    (/UnrealEngine.com/Temporary/SpatialMath:)ToString<epic_internal>(
      InTransform: (/UnrealEngine.com/Temporary/SpatialMath:)transform
    )<reads>: string = external {}

    # Makes a `string` representation of `rotation` in axis/degrees format with
    # a left-handed sign convention.
    # `ToString(MakeRotation(vector3{X:=1.0, Y:=0.0, Z:=0.0}, PiFloat/2.0))`
    # produces the
    # string: `"Axis: {x=1.000000,y=0.000000,z=0.000000} Angle: 90.000000"`.
    (/UnrealEngine.com/Temporary/SpatialMath:)ToString<public>(
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<reads>: string = external {}

    # Makes a `string` representation of `V`.
    (/UnrealEngine.com/Temporary/SpatialMath:)ToString<public>(
      V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: string = external {}

    # Makes a `string` representation of `V`.
    (/UnrealEngine.com/Temporary/SpatialMath:)ToString<public>(V: vector2)<reads>: string = external {}

    # Makes a `string` representation of `V`.
    (/UnrealEngine.com/Temporary/SpatialMath:)ToString<public>(V: vector2i)<computes>: string = external {}

    # Makes a `vector2` by converting the components of `V` to `float`s.
    ToVector2<public>(V: vector2i)<transacts>: vector2 = external {}

    # Makes a `vector2i` by component-wise truncation of `V` to `ints`s.
    ToVector2i<public>(V: vector2)<decides><reads>: vector2i = external {}

    # Makes a `vector3` by applying `InTransform` to `InVector`.
    TransformVector<public>(
      InTransform: (/UnrealEngine.com/Temporary/SpatialMath:)transform,
      InVector: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector3` by applying `InTransform` to `InVector` without
    # applying `InTransform.Scale`.
    TransformVectorNoScale<public>(
      InTransform: (/UnrealEngine.com/Temporary/SpatialMath:)transform,
      InVector: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a unit `vector2` pointing in the positive X axis.
    XAxis2<epic_internal>()<computes>: vector2 = external {}

    # Makes a unit `vector3` pointing in the positive X axis (forward)
    XAxis<epic_internal>()<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a unit `vector2` pointing in the positive Y axis.
    YAxis2<epic_internal>()<computes>: vector2 = external {}

    # Makes a unit `vector3` pointing in the positive Y axis (right)
    YAxis<epic_internal>()<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a unit `vector3` pointing in the positive Z axis (up)
    ZAxis<epic_internal>()<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector2` with all components `0.0`.
    Zero2<epic_internal>()<computes>: vector2 = external {}

    # Makes a `vector3` with all components `0.0`.
    (/UnrealEngine.com/Temporary/SpatialMath:)Zero<epic_internal>()<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector3` by component-wise multiplication of `L` and `R`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'*'<public>(
      L: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      R: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector3` by multiplying the components of `L` by `R`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'*'<public>(
      L: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      R: float
    )<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector3` by multiplying the components of `R` by `L`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'*'<public>(
      L: float,
      R: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector2` by multiplying the components of `Right` by `Left`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'*'<public>(
      Left: float,
      Right: vector2
    )<computes>: vector2 = external {}

    # Makes a `vector2i` by multiplying the components of `Right` by `Left`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'*'<public>(
      Left: int,
      Right: vector2i
    )<computes>: vector2i = external {}

    # Makes a `vector2` by component-wise multiplication of `Left` and `Right`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'*'<public>(
      Left: vector2,
      Right: float
    )<computes>: vector2 = external {}

    # Makes a `vector2i` by multiplying the components of `Left` by `Right`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'*'<public>(
      Left: vector2i,
      Right: int
    )<computes>: vector2i = external {}

    # Makes a `vector3` by component-wise addition of `L` and `R`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'+'<public>(
      L: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      R: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector2` by component-wise addition of `Left` and `Right`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'+'<public>(
      Left: vector2,
      Right: vector2
    )<computes>: vector2 = external {}

    # Makes a `vector2i` by component-wise addition of `Left` and `Right`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'+'<public>(
      Left: vector2i,
      Right: vector2i
    )<computes>: vector2i = external {}

    # Makes a `vector3` by component-wise subtraction of `R` from `L`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'-'<public>(
      L: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      R: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector2` by component-wise subtraction of `Right` from `Left`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'-'<public>(
      Left: vector2,
      Right: vector2
    )<computes>: vector2 = external {}

    # Makes a `vector2i` by component-wise subtraction of `Right` from `Left`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'-'<public>(
      Left: vector2i,
      Right: vector2i
    )<computes>: vector2i = external {}

    # Makes a `vector3` by component-wise division of `L` by `R`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'/'<public>(
      L: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      R: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector3` by dividing the components of `L` by `R`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'/'<public>(
      L: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      R: float
    )<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector2` by dividing the components of `Left` by `Right`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'/'<public>(
      Left: vector2,
      Right: float
    )<computes>: vector2 = external {}

    # Makes a `vector2` by component-wise division of `Left` by `Right`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'/'<public>(
      Left: vector2,
      Right: vector2
    )<computes>: vector2 = external {}

    # Makes a `vector3` by inverting the signs of `Operand`.
    (/UnrealEngine.com/Temporary/SpatialMath:)prefix'-'<public>(
      Operand: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector2` by inverting the signs of `Operand`.
    (/UnrealEngine.com/Temporary/SpatialMath:)prefix'-'<public>(Operand: vector2)<computes>: vector2 = external {}

    # Makes a `vector2i` by inverting the signs of `Operand`.
    (/UnrealEngine.com/Temporary/SpatialMath:)prefix'-'<public>(Operand: vector2i)<computes>: vector2i = external {}

    using { /Verse.org/Native }
    using { /Verse.org/Simulation }
    using { /Verse.org/SpatialMath }
    using { /Verse.org/Temporary/EpicGamesRestricted/Network }
    @editable
    @import_as("/Script/EpicGamesTemporary.FVerseRotation_Deprecated")
    # An abstract representation of an orientation change in 3d-space.
    (/UnrealEngine.com/Temporary/SpatialMath:)rotation<public><native> := struct<concrete> {}

    # A combination of scale, rotation, and translation, applied in that order.
    (/UnrealEngine.com/Temporary/SpatialMath:)transform<public><native> := struct<concrete><computes> {
      @editable
      # The rotation of this `transform`.
      Rotation<public><native>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {}

      @editable
      # The scale of this `transform`.
      Scale<public><native>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

      @editable
      # The location of this `transform`.
      Translation<public><native>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}
    }

    @replicatable
    # 2-dimensional vector with `float` components.
    vector2<public><native> := struct<concrete><computes><persistable> {
      @editable
      X<public><native>: float = external {}

      @editable
      Y<public><native>: float = external {}
    }

    # 2-dimensional vector with `int` components.
    vector2i<public><native> := struct<concrete><computes><persistable> {
      @editable
      X<public><native>: int = external {}

      @editable
      Y<public><native>: int = external {}
    }

    @replicatable
    # 3-dimensional vector with `float` components.
    (/UnrealEngine.com/Temporary/SpatialMath:)vector3<public><native> := struct<concrete><computes><persistable> {
      @editable
      X<public><native>: float = external {}

      @editable
      Y<public><native>: float = external {}

      @editable
      Z<public><native>: float = external {}
    }
  }

  # Module import path: /UnrealEngine.com/Temporary/Testing
  Testing<public> := module {
    # test_reporter is a test result aggregator that writes test results to a
    # log stream and can compile and print a summary of test results.
    test_reporter<epic_internal><native> := class {
      # Sets the default log level of the displayed message. See log_level enum
      # for more info on log levels. Defaults to log_level.Normal.
      DefaultLevel<epic_internal><native>: log_level = external {}

      # Returns a string of the test results summary.
      GetSummaryStrings<epic_internal><native>(?Level: log_level = external {}): []string

      # Logs `Message` to the `test_reporter` log stream. This allows users to
      # add context for results to the summary.
      (/UnrealEngine.com/Temporary/Testing/test_reporter:)Log<epic_internal><native>(
        Message: string,
        ?Level: log_level = external {}
      ): void

      # The name of this `test_reporter`. Used when displaying results summary.
      Name<epic_internal><native>: string = external {}

      # Prints a summary of test results to the log stream.
      PrintSummary<epic_internal><native>(?Level: log_level = external {}): void

      # Prints a json summary of test results to the log stream.
      PrintSummaryJson<epic_internal><native>(): void

      # Report a test result of `Blocked`. `Category` and `SubCategory` are used
      # to calculate test result stats as part of printing the summary.
      ReportTestBlocked<epic_internal><native>(
        Message: string,
        ?Category: string = external {},
        ?SubCategory: string = external {},
        ?StartTimeSec: float = external {},
        ?DurationSec: float = external {}
      ): void

      # Report a test result of `Failed`. `Category` and `SubCategory` are used
      # to calculate test result stats as part of printing the summary.
      ReportTestFailed<epic_internal><native>(
        Message: string,
        ?Category: string = external {},
        ?SubCategory: string = external {},
        ?StartTimeSec: float = external {},
        ?DurationSec: float = external {}
      ): void

      # Report a test result of `Passed`. `Category` and `SubCategory` are used
      # to calculate test result stats as part of printing the summary.
      ReportTestPassed<epic_internal><native>(
        Message: string,
        ?Category: string = external {},
        ?SubCategory: string = external {},
        ?StartTimeSec: float = external {},
        ?DurationSec: float = external {}
      ): void

      # Report a test result of `Result`. `Category` and `SubCategory` are used
      # to calculate test result stats as part of printing the summary.
      ReportTestResult<epic_internal><native>(
        Message: string,
        Result: test_result,
        ?Category: string = external {},
        ?SubCategory: string = external {},
        ?StartTimeSec: float = external {},
        ?DurationSec: float = external {}
      ): void

      # Report a test result of `Skipped`. `Category` and `SubCategory` are used
      # to calculate test result stats as part of printing the summary.
      ReportTestSkipped<epic_internal><native>(
        Message: string,
        ?Category: string = external {},
        ?SubCategory: string = external {},
        ?StartTimeSec: float = external {},
        ?DurationSec: float = external {}
      ): void

      # Resets test results.
      Reset<epic_internal><native>(): void
    }

    using { /UnrealEngine.com/Temporary/Diagnostics }
    # test result outcomes
    test_result<epic_internal><native> := enum {
      Blocked

      Failed

      Passed

      Skipped
    }
  }

  # Verse path: /UnrealEngine.com/Temporary
  # Module import path: /UnrealEngine.com/Temporary/UI
  (/UnrealEngine.com/Temporary:)UI<public> := module {
    # Returns the `player_ui` associated with `Player`.
    # Fails if there is no `player_ui` associated with `Player`.
    GetPlayerUI<public><native>(Player: player)<transacts><decides>: player_ui

    # Make a canvas slot for fixed position widget.
    # If Size is set, then the Offsets is calculated and the SizeToContent is
    # set to false.
    # If Size is not set, then Right and Bottom are set to zero and are not
    # used. The widget size will be automatically calculated. The SizeToContent
    # is set to true.
    # The widget is not anchored and will not move if the parent is resized.
    # The Anchors is set to zero.
    MakeCanvasSlot<public><native>(
      Widget: widget,
      Position: vector2,
      ?Size: vector2 = external {},
      ?ZOrder: type { _X: int where 0 <= _X, _X <= 2147483647 } = external {},
      ?Alignment: vector2 = external {}
    )<computes>: canvas_slot

    # Module import path: /UnrealEngine.com/Temporary/UI/UIInput
    UIInput<epic_internal> := module {
      LeftPrimary<epic_internal>: input_action(logic) = external {}

      LeftSecondary<epic_internal>: input_action(logic) = external {}

      Primary_1<epic_internal>: input_action(logic) = external {}

      Primary_2<epic_internal>: input_action(logic) = external {}

      RightPrimary<epic_internal>: input_action(logic) = external {}

      RightSecondary<epic_internal>: input_action(logic) = external {}

      Secondary_1<epic_internal>: input_action(logic) = external {}

      Secondary_2<epic_internal>: input_action(logic) = external {}

      using { /Verse.org/Assets }
      UINavigationMapping<epic_internal>: input_mapping = external {}
    }

    ___DefaultEmptyString_Internal<epic_internal><localizes>: message = external {}

    # The anchors of a `widget` determine its the position and sizing relative
    # to its parent.
    # `anchor`s range from `(0.0, 0.0)` (left, top) to `(1.0, 1.0)`
    # (right, bottom).
    anchors<public><native> := struct<concrete><computes> {
      # Holds the maximum anchors, (right, bottom). The valid range is between
      # `0.0` and `1.0`.
      Maximum<public><native>: vector2 = external {}

      # Holds the minimum anchors, (left, top). The valid range is between `0.0`
      # and `1.0`.
      Minimum<public><native>: vector2 = external {}
    }

    # Button is a container of a single child widget slot and fires the OnClick
    # event when the button is clicked.
    button<public><native> := class<final>(widget) {
      HighlightEvent<public>(): listenable(widget_message) = external {}

      # Subscribable event that fires when the button is clicked.
      OnClick<public>(): listenable(widget_message) = external {}

      # Sets the child widget slot.
      SetWidget<public><native>(InSlot: button_slot): void

      # The child widget of the button. Used only during initialization of the
      # widget and not modified by SetSlot.
      Slot<public><native>: button_slot

      UnhighlightEvent<public>(): listenable(widget_message) = external {}

      # The UI input action that will trigger the Click event of this button.
      var TriggeringInputAction<public>: ?input_action(logic) = external {}
    }

    # Slot for button widget.
    button_slot<public><native> := struct {
      # Horizontal alignment of the widget inside the slot.
      HorizontalAlignment<public><native>: horizontal_alignment = external {}

      # Empty distance in pixels that surrounds the widget inside the slot.
      # Assumes 1080p resolution.
      Padding<public><native>: margin = external {}

      # Vertical alignment of the widget inside the slot.
      VerticalAlignment<public><native>: vertical_alignment = external {}

      # The widget assigned to this slot.
      Widget<public><native>: widget
    }

    # Canvas is a container widget that allows for arbitrary positioning of
    # widgets in the canvas' slots.
    canvas<public><native> := class<final>(widget) {
      # Adds a new child slot to the canvas.
      AddWidget<public><native>(Slot: canvas_slot): void

      # Removes a slot containing the given widget.
      RemoveWidget<public><native>(Widget: widget): void

      # The child widgets of the canvas. Used only during initialization of the
      # widget and not modified by Add/RemoveWidget.
      Slots<public><native>: []canvas_slot = external {}
    }

    # Slot for a canvas widget.
    canvas_slot<public><native> := struct {
      # Alignment is the pivot/origin point of the widget.
      # Starting in the upper left at (0.0,0.0), ending in the lower right
      # at (1.0,1.0).
      Alignment<public><native>: vector2 = external {}

      # The border for the margin and how the widget is resized with its parent.
      # Values are defined between 0.0 and 1.0.
      Anchors<public><native>: anchors = external {}

      # The offset that defined the size and position of the widget.
      # When the anchors are well defined, the Offsets.Left represent the
      # distance in pixels from the Anchors Minimum.X, the Offsets.Bottom
      # represent the distance in pixel from the Anchors Maximum.Y, effectively
      # controlling the desired widget size. When the anchors are not well
      # defined, the Offsets.Left and Offsets.Top represent the widget position
      # and Offsets.Right and Offset.Bottom represent the widget size.
      Offsets<public><native>: margin = external {}

      # When true we use the widget's desired size. The size calculated by the
      # Offsets is ignored.
      SizeToContent<public><native>: logic = external {}

      # The widget assigned to this slot.
      Widget<public><native>: widget

      # Z Order of this slot relative to other slots in this canvas panel.
      # Higher values are rendered last (and so they will appear to be on top)
      ZOrder<public><native>: type { _X: int where 0 <= _X, _X <= 2147483647 } = external {}
    }

    # A solid color widget.
    color_block<public><native> := class<final>(widget) {
      # The color of the widget. Used only during initialization of the widget
      # and not modified by SetColor.
      DefaultColor<public><native>: color = external {}

      # The size this widget desired to be displayed in. Used only during
      # initialization of the widget and not modified by SetDesiredSize.
      DefaultDesiredSize<public><native>: vector2 = external {}

      # The opacity of the widget. Used only during initialization of the widget
      # and not modified by SetOpacity.
      DefaultOpacity<public><native>: type { _X: float where 0.000000 <= _X, _X <= 1.000000 } = external {}

      # Gets the widget's color.
      GetColor<public><native>(): color

      # Gets the size this widget desired to be displayed in.
      GetDesiredSize<public><native>(): vector2

      # Gets the widget's opacity.
      GetOpacity<public><native>(): type { _X: float where 0.000000 <= _X, _X <= 1.000000 }

      # Sets the widget's color.
      SetColor<public><native>(InColor: color): void

      # Sets the size this widget desired to be displayed in.
      SetDesiredSize<public><native>(InDesiredSize: vector2): void

      # Sets the widgets's opacity.
      SetOpacity<public><native>(InOpacity: type { _X: float where 0.000000 <= _X, _X <= 1.000000 }): void
    }

    # `widget` horizontal alignment mode.
    horizontal_alignment<public><native> := enum {
      # Center `widget` horizontally within the slot.
      Center

      # `widget` fills the slot horizontally.
      Fill

      # Align `widget` to the left of the slot.
      Left

      # Align `widget` to the right of the slot.
      Right
    }

    # Tiling options values
    image_tiling<public><native> := enum {
      # Repeat/Wrap the image to fill the available space.
      Repeat

      # Stretch the image to fit the available space.
      Stretch
    }

    using { /UnrealEngine.com/Temporary/SpatialMath }
    using { /Verse.org/Assets }
    using { /Verse.org/Colors }
    using { /Verse.org/SceneGraph }
    using { /Verse.org/Simulation }
    @experimental
    local_hud_component<epic_internal> := class<final_super>(component) {
      @experimental
      Hide<public>(Player: player): void = external {}

      OnBeginSimulation<override>(): void = external {}

      OnEndSimulation<override>(): void = external {}

      @experimental
      Show<public>(Player: player): void = external {}

      var Canvas<public>: canvas

      var UISlot<public>: player_ui_slot
    }

    # Specifies the gap outside each edge separating a `widget` from
    # its neighbors.
    # Distance is measured in units where `1.0` unit is the width of a pixel at
    # 1080p resolution.
    margin<public><native> := struct<concrete><computes> {
      # The bottom edge spacing.
      Bottom<public><native>: float = external {}

      # The left edge spacing.
      Left<public><native>: float = external {}

      # The right edge spacing.
      Right<public><native>: float = external {}

      # The top edge spacing.
      Top<public><native>: float = external {}
    }

    # A widget to display a material.
    material_block<public><native> := class(widget) {
      # The size this widget desired to be displayed in. Used only during
      # initialization of the widget and not modified by SetDesiredSize.
      DefaultDesiredSize<public><native>: vector2 = external {}

      # The image to render. Used only during initialization of the widget and
      # not modified by SetImage.
      DefaultImage<public><native>: material

      # Tinting applied to the image. Used only during initialization of the
      # widget and not modified by SetTint.
      DefaultTint<public><native>: color = external {}

      # Gets the size this widget desired to be displayed in.
      GetDesiredSize<public><native>(): vector2

      # Gets the image to render.
      GetImage<public><native>(): material

      # Gets the tint applied to the image.
      GetTint<public><native>(): color

      # Sets the size this widget desired to be displayed in.
      SetDesiredSize<public><native>(InDesiredSize: vector2): void

      # Sets the image to render.
      SetImage<public><native>(InImage: material): void

      # Sets the tint applied to the image.
      SetTint<public><native>(InColor: color): void
    }

    # Used by`widget` orientation modes.
    orientation<public><native> := enum {
      # Orient `widget`s from left to right.
      Horizontal

      # Orient `widget`s from top to bottom.
      Vertical
    }

    # Overlay is a container consisting of widgets stacked on top of each other.
    overlay<public><native> := class<final>(widget) {
      # Add a new child slot to the overlay. Slots are added at the end.
      AddWidget<public><native>(Slot: overlay_slot): void

      # Removes a slot containing the given widget
      RemoveWidget<public><native>(Widget: widget): void

      # The child widgets of the overlay. Used only during initialization of the
      # widget and not modified by Add/RemoveWidget.
      Slots<public><native>: []overlay_slot = external {}
    }

    # Slot for an overlay widget
    overlay_slot<public><native> := struct {
      # Horizontal alignment of the widget inside the slot.
      # This alignment is only applied after the layout space for the widget
      # slot is created and determines the widget alignment within that space.
      HorizontalAlignment<public><native>: horizontal_alignment = external {}

      # Empty distance in pixels that surrounds the widget inside the slot.
      # Assumes 1080p resolution.
      Padding<public><native>: margin = external {}

      # Vertical alignment of the widget inside the slot.
      # This alignment is only applied after the layout space for the widget
      # slot is created and determines the widget alignment within that space.
      VerticalAlignment<public><native>: vertical_alignment = external {}

      # The widget assigned to this slot.
      Widget<public><native>: widget
    }

    # The main interface for adding and removing `widget`s to a player's UI.
    player_ui<public><native> := class<epic_internal><final> {
      # Adds `Widget` to this `player_ui` using default `player_ui_slot`
      # configuration options.
      AddWidget<public><native>(Widget: widget): void

      # Adds `Widget` to this `player_ui` using `Slot` for
      # configuration options.
      AddWidget<public><native>(Widget: widget, Slot: player_ui_slot): void

      # Removes `Widget` from this `player_ui`.
      RemoveWidget<public><native>(Widget: widget): void

      # Sets the user's focus on this `Widget`. The target `Widget`must be
      # focusable, otherwise this has no effect.
      # If `SetFocus` is called before `AddWidget`, the `widget` will be focused
      # after `AddWidget` is called, unless a SetFocus is called on a different
      # `widget` by the time `AddWidget` is called.
      SetFocus<public><native>(Widget: widget): void
    }

    # `widget` creation configuration options.
    player_ui_slot<public><native> := struct {
      # Controls `widget` input event consumption.
      InputMode<public><native>: ui_input_mode = external {}

      # Controls `widget` rendering order. Greater values will be draw in front
      # of lesser values.
      ZOrder<public><native>: type { _X: int where 0 <= _X, _X <= 2147483647 } = external {}
    }

    # Safe zone box is a container of a single child widget slot that ensures
    # its slot content stays out of unsafe zone across platforms.
    safezone_box<epic_internal><native> := class<final>(widget) {
      # Sets the child widget slot.
      SetWidget<public><native>(InSlot: safezone_box_slot): void

      # The child widget of the safe zone. Used only during initialization of
      # the widget and not modified by SetWidget.
      Slot<public><native>: safezone_box_slot
    }

    # Slot for safe zone box widget.
    safezone_box_slot<epic_internal><native> := struct {
      # The widget assigned to this slot.
      Widget<public><native>: widget
    }

    # Stack box is a container of a list of widgets stacked either vertically
    # or horizontally.
    stack_box<public><native> := class<final>(widget) {
      # Add a new child slot to the stack box. Slots are added at the end.
      AddWidget<public><native>(Slot: stack_box_slot): void

      # The orientation of the stack box. Either stack widgets horizontal
      # or vertical.
      Orientation<public><native>: orientation

      # Removes a slot containing the given widget
      RemoveWidget<public><native>(Widget: widget): void

      # The child widgets of the stack box. Used only during initialization of
      # the widget and not modified by Add/RemoveWidget.
      Slots<public><native>: []stack_box_slot = external {}
    }

    # Slot for a stack_box widget
    stack_box_slot<public><native> := struct {
      # The available space will be distributed proportionally.
      # If not set, the slot will use the desired size of the widget.
      Distribution<public><native>: ?float = external {}

      # Horizontal alignment of the widget inside the slot.
      # This alignment is only applied after the layout space for the widget
      # slot is created and determines the widget alignment within that space.
      HorizontalAlignment<public><native>: horizontal_alignment = external {}

      # Empty distance in pixels that surrounds the widget inside the slot.
      # Assumes 1080p resolution.
      Padding<public><native>: margin = external {}

      # Vertical alignment of the widget inside the slot.
      # This alignment is only applied after the layout space for the widget
      # slot is created and determines the widget alignment within that space.
      VerticalAlignment<public><native>: vertical_alignment = external {}

      # The widget assigned to this slot.
      Widget<public><native>: widget
    }

    # Base widget for text widget.
    text_base<public><native> := class<abstract>(widget) {
      # The justification to display to the user. Used only during
      # initialization of the widget and not modified by SetJustification.
      DefaultJustification<public><native>: text_justification = external {}

      # The policy that determine what happens when the text is longer than its
      # allowed length.
      # Used only during initialization of the widget and not modified
      # by SetOverflowPolicy.
      DefaultOverflowPolicy<public><native>: text_overflow_policy = external {}

      # The text to display to the user. Used only during initialization of the
      # widget and not modified by SetText.
      DefaultText<public><native><localizes>: message = external {}

      # The color of the displayed text. Used only during initialization of the
      # widget and not modified by SetTextColor.
      DefaultTextColor<public><native>: color = external {}

      # The opacity of the displayed text. Used only during initialization of
      # the widget and not modified by SetTextOpacity.
      DefaultTextOpacity<public><native>: type { _X: float where 0.000000 <= _X, _X <= 1.000000 } = external {}

      # The size of the displayed text. Used only during initialization of the
      # widget and not modified by SetTextSize.
      DefaultTextSize<public><native>: float = external {}

      # Gets the text justification in the widget.
      GetJustification<public><native>(): text_justification

      # Gets the policy that determine what happens when the text is longer than
      # its allowed length.
      GetOverflowPolicy<public><native>(): text_overflow_policy

      # Gets the text currently in the widget.
      GetText<public><native>(): string

      # Gets the color of the displayed text.
      GetTextColor<public><native>(): color

      # Gets the opacity of the displayed text.
      GetTextOpacity<public><native>(): type { _X: float where 0.000000 <= _X, _X <= 1.000000 }

      # Gets the size of the displayed text.
      GetTextSize<public><native>(): float

      # Sets the text justification in the widget.
      SetJustification<public><native>(InJustification: text_justification): void

      # Sets the policy that determine what happens when the text is longer than
      # its allowed length.
      SetOverflowPolicy<public><native>(InOverflowPolicy: text_overflow_policy): void

      # Sets the text displayed in the widget.
      SetText<public><native>(InText: message): void

      # Sets the color of the displayed text.
      SetTextColor<public><native>(InColor: color): void

      # Sets the opacity of the displayed text.
      SetTextOpacity<public><native>(InOpacity: type { _X: float where 0.000000 <= _X, _X <= 1.000000 }): void

      # Sets the size of the displayed text.
      SetTextSize<public><native>(InSize: float): void

      # Whether the text should be automatically wrapped.
      var AutoWrap<public>: logic = external {}

      # Whether text wraps onto a new line when it's length exceeds this width;
      # if this value is zero or negative, no wrapping occurs.
      var WrapWidth<public>: float = external {}

      # The wrapping policy to determine where the line can be broken.
      var WrappingPolicy<public>: text_wrapping_policy = external {}
    }

    # Text block widget. Displays text to the user.
    text_block_internal<epic_internal><native> := class(text_base) {}

    # Text justification values:
    #   Left: Justify the text logically to the left based on current culture.
    #   Center: Justify the text in the center.
    #   Right: Justify the text logically to the right based on current culture.
    # The Left and Right value will flip when the local culture
    # is right-to-left.
    text_justification<public><native> := enum {
      Center

      InvariantLeft

      InvariantRight

      Left

      Right
    }

    # Text overflow policy values:
    #   Clip: Overflowing text will be clipped.
    #   Ellipsis: Overflowing text will be replaced with an ellipsis.
    text_overflow_policy<public><native> := enum {
      Clip

      Ellipsis
    }

    # Text wrapping policy values:
    #   LineBreak: Allows breaking a line only at line-break iterator
    #              for wrapping.
    #   PerCharacter: Allows breaking a line after any character for wrapping.
    text_wrapping_policy<public><native> := enum {
      LineBreak

      PerCharacter
    }

    # A widget to display a texture.
    texture_block<public><native> := class(widget) {
      # The size this widget desired to be displayed in. Used only during
      # initialization of the widget and not modified by SetDesiredSize.
      DefaultDesiredSize<public><native>: vector2 = external {}

      # The horizontal tiling option. Used only during initialization of the
      # widget and not modified by SetTiling.
      DefaultHorizontalTiling<public><native>: image_tiling = external {}

      # The image to render. Used only during initialization of the widget and
      # not modified by SetImage.
      DefaultImage<public><native>: texture

      # Tinting applied to the image. Used only during initialization of the
      # widget and not modified by SetTint.
      DefaultTint<public><native>: color = external {}

      # The vertical tiling option. Used only during initialization of the
      # widget and not modified by SetTiling.
      DefaultVerticalTiling<public><native>: image_tiling = external {}

      # Gets the size this widget desired to be displayed in.
      GetDesiredSize<public><native>(): vector2

      # Gets the image to render.
      GetImage<public><native>(): texture

      # Gets the tiling option.
      GetTiling<public><native>(): tuple(image_tiling, image_tiling)

      # Gets the tint applied to the image.
      GetTint<public><native>(): color

      # Sets the size this widget desired to be displayed in.
      SetDesiredSize<public><native>(InDesiredSize: vector2): void

      # Sets the image to render.
      SetImage<public><native>(InImage: texture): void

      # Sets the tiling option when the image is smaller than the
      # allocated size.
      SetTiling<public><native>(InHorizontalTiling: image_tiling, InVerticalTiling: image_tiling): void

      # Sets the tint applied to the image.
      SetTint<public><native>(InColor: color): void
    }

    # `widget` input consumption mode.
    ui_input_mode<public><native> := enum {
      # `widget` consumes all inputs
      All

      # `widget` does not consume any input.
      None
    }

    # Widget created from a umg_widget_class_asset.
    umg_widget<epic_internal><native> := class<epic_internal>(widget) {
      # The widget_blueprint asset to create.
      Asset<epic_internal><native>: umg_widget_class_asset

      GetNamedSlotOptional_<epic_internal><native>(NamedSlotName: []char)<transacts>: ?widget

      GetNamedSlot_<epic_internal><native>(NamedSlotName: []char)<transacts>: widget

      GetViewmodelOptional_<epic_internal><native>(
        viewmodel_type: type,
        ViewmodelName: []char
      )<transacts>: viewmodel_type

      GetViewmodel_<epic_internal><native>(viewmodel_type: type, ViewmodelName: []char)<transacts>: viewmodel_type

      OnPropertyChanged<protected><native>(PropertyName: string)<transacts>: void

      SetNamedSlotOptional_<epic_internal><native>(NamedSlotName: []char, NamedSlotInstance: ?widget)<transacts>: void

      SetNamedSlot_<epic_internal><native>(NamedSlotName: []char, NamedSlotInstance: widget)<transacts>: void

      SetViewmodelOptional_<epic_internal><native>(
        viewmodel_type: type,
        ViewmodelName: []char,
        ViewmodelInstance: viewmodel_type
      )<transacts>: void

      SetViewmodel_<epic_internal><native>(
        viewmodel_type: type,
        ViewmodelName: []char,
        ViewmodelInstance: viewmodel_type
      )<transacts>: void

      SignalEvent<epic_internal><native_callable>(EventToSignal: signalable(tuple())): void = external {}
    }

    # Verse interface to native `umg asset`.
    umg_widget_class_asset<epic_internal><native> := class<final><computes>(client_asset) {}

    # `widget` vertical alignment mode.
    vertical_alignment<public><native> := enum {
      # Align `widget` to the bottom of the slot.
      Bottom

      # Center `widget` vertically within the slot.
      Center

      # `widget` fills the slot vertically.
      Fill

      # Align `widget` to the top of the slot.
      Top
    }

    # Base class for all UI elements drawn on the `player`'s screen.
    widget<public><native> := class<epic_internal><abstract><unique> {
      # Returns the `widget`'s parent `widget`.
      # Fails if no parent exists, such as if this `widget` is not in the
      # `player_ui` or is itself the root `widget`.
      GetParentWidget<public><native>()<transacts><decides>: widget

      # Gets the render opacity of the widget.
      GetRenderOpacity<epic_internal><native>(): float

      # Returns the `widget` that added this `widget` to the `player_ui`. The
      # root `widget` will return itself.
      # Fails if this `widget` is not in the `player_ui`.
      GetRootWidget<public><native>()<transacts><decides>: widget

      # Returns the current `widget_visibility` state.
      GetVisibility<public><native>(): widget_visibility

      # `true` if this `widget` can be modified interactively by the player.
      IsEnabled<public><native>(): logic

      # `true` if this `widget` consumes input when `widget_visibility`
      # is Visible.
      IsHitTestVisible<epic_internal><native>(): logic

      # Enables or disables whether the `player` can interact with
      # this `widget`.
      SetEnabled<public><native>(InIsEnabled: logic): void

      # Enables or disables whether this `widget` consumes input when
      # `widget_visibility` is Visible.
      SetHitTestVisible<epic_internal><native>(InIsHitTestVisible: logic): void

      # Sets the render opacity of the widget.
      SetRenderOpacity<epic_internal><native>(InRenderOpacity: float): void

      # Shows or hides the `widget` without removing itself from the
      # containing `player_ui`.
      # See `widget_visibility` for details.
      SetVisibility<public><native>(InVisibility: widget_visibility): void
    }

    # Parameters for `event`s signalled by a `widget`.
    widget_message<public><native> := struct {
      # The `player` that triggered the `event`.
      Player<public><native>: player

      # The `widget` that triggered the `event`.
      Source<public><native>: widget
    }

    # Used by `widget.SetVisibility` determine how a `widget` is shown in the
    # user interface.
    widget_visibility<public><native> := enum {
      # The `widget` is invisible and does not occupy layout space.
      Collapsed

      # The `widget` is invisible and occupies layout space.
      Hidden

      # The `widget` is visible and occupies layout space.
      Visible
    }
  }

  WorldPartition<public> := module {
    # Verse path: /UnrealEngine.com/Temporary/WorldPartition
    # Module import path: /UnrealEngine.com/Temporary/WorldPartition/VerseWorldPartition
    VerseWorldPartition<public> := module {
      @deprecated { Message := "Use `GetWorldPartitionHelperForEntity` instead." }
      # Deprecated, use GetWorldPartitionHelperForEntity instead which is a less
      # ambiguous/future proof way to obtaining the helper
      GetWorldPartitionHelper<epic_internal><native>()<transacts>: ?world_partition_helper

      GetWorldPartitionHelperForEntity<epic_internal><native>(Entity: entity)<transacts>: ?world_partition_helper

      using { /UnrealEngine.com/Temporary/SpatialMath }
      using { /Verse.org/Assets }
      using { /Verse.org/SceneGraph }
      data_layer_asset<epic_internal><native> := class<epic_internal><final><concrete><computes>(asset) {}

      world_partition_helper<epic_internal><native> := class<concrete> {
        # Adds a static streaming source.
        AddStreamingSource<public><native>(StreamingSource: world_partition_streaming_source)<transacts>: cancelable

        # Adds a streaming source provider callback. The callback is responsible
        # for filling and updating the streaming source when invoked.
        AddStreamingSourceProvider<public><native>(
          UpdateStreamingSourceCallback: type { _(: world_partition_streaming_source): void }
        )<transacts>: cancelable

        # Returns data layer effective runtime state.
        GetDataLayerEffectiveRuntimeState<public><native>(
          DataLayerAsset: data_layer_asset
        )<transacts>: world_partition_streaming_runtime_state

        # Returns whether an array of streaming sources has finished streaming.
        # If no array is passed, the state of all currently added streaming
        # source is queryed.
        IsStreamingCompleted<public><native>(Sources: ?[]world_partition_streaming_source)<transacts>: logic

        # Returns whether an array of streaming query sources satisfies the
        # passed state.
        IsStreamingCompleted<public><native>(
          Sources: []world_partition_streaming_query_source,
          QueryState: world_partition_streaming_runtime_state
        )<transacts>: logic

        # Sets data layer runtime state.
        SetDataLayerRuntimeState<public><native>(
          DataLayerAsset: data_layer_asset,
          State: world_partition_streaming_runtime_state,
          IsRecursive: logic
        )<transacts>: logic
      }

      world_partition_streaming_definition<epic_internal><native> := class<epic_internal><concrete> {
        SetAsCircle<public>(Range: float)<transacts>: void = external {}

        SetAsSphere<public>(Range: float)<transacts>: void = external {}

        # If true, this streaming source will force intersecting cells in 2D
        var Force2D<public><native>: logic = external {}

        # Source Location
        var Location<public><native>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

        # Source orientation (can impact streaming cell prioritization)
        var Rotation<public><native>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {}

        # Source internal shapes. When none are provided, a sphere is
        # automatically used. It's radius is equal to grid's loading range and
        # center equals source's location.
        var Shapes<public><native>: []world_partition_streaming_source_shape = external {}

        # Defines how TargetGrids/TargetHLODLayers will be applied to this
        # streaming source.
        var TargetBehavior<public><native>: world_partition_streaming_source_target_behavior = external {}

        # When set, this will change how this streaming source is applied to the
        # provided runtime streaming grids based on the TargetBehavior.
        var TargetGrids<public><native>: []string = external {}
      }

      world_partition_streaming_query_source<epic_internal><native> := class(world_partition_streaming_definition) {
        # The list of layers to consider for this query
        var DataLayers<public><native>: []data_layer_asset = external {}

        # If False, Location/Radius will not be used to find the cells. Only
        # AlwaysLoaded cells will be returned by the query.
        var SpatialQuery<public><native>: logic = external {}
      }

      # Unloaded: Associated content is unloaded. Loaded: Associated content is
      # loaded but not visible. Activated: Associated content is loaded and
      # visible. Represents possible Streaming Sources runtime states.
      world_partition_streaming_runtime_state<epic_internal><native> := enum {
        # Activated (meaning loaded and visible)
        Activated

        # Loaded (meaning loaded but not visible)
        Loaded

        # Unloaded
        Unloaded
      }

      world_partition_streaming_source<epic_internal><native> := class(world_partition_streaming_definition) {
        # Whether this source will be considered when world partition detects
        # slow loading and waits for cell streaming to complete
        var BlockOnSlowLoading<public><native>: logic = external {}

        # Source unique name
        var Name<public><native>: string = external {}

        # Streaming source priority
        var Priority<public><native>: world_partition_streaming_source_priority = external {}

        # Target streaming state
        var TargetState<public><native>: world_partition_streaming_runtime_state = external {}

        # Use velocity contribution to streaming cells priority streaming.
        var UseVelocityContributionToCellsSorting<public><native>: logic = external {}
      }

      world_partition_streaming_source_priority<epic_internal><native> := enum {
        High

        Highest

        Low

        Lowest

        Normal
      }

      world_partition_streaming_source_shape<epic_internal><native> := class<concrete> {
        # Whether the source shape is a spherical sector instead of a regular
        # sphere source.
        var IsSector<public><native>: logic = external {}

        # Applies a scale to the grid's loading range (used if
        # bUseGridLoadingRange is True)
        var LoadingRangeScale<public><native>: float = external {}

        # Streaming source shape location (local to streaming source).
        var Location<public><native>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

        # Custom streaming source shape radius (not used if bUseGridLoadingRange
        # is True).
        var Radius<public><native>: float = external {}

        # Streaming source shape rotation (local to streaming source).
        var Rotation<public><native>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {}

        # Shape's spherical sector angle in degree (not used if bIsSector
        # is False)
        var SectorAngle<public><native>: float = external {}

        # If True, streaming source shape radius is bound to loading
        # range radius.
        var UseGridLoadingRange<public><native>: logic = external {}
      }

      world_partition_streaming_source_subscription<epic_internal><native> := class(cancelable) {
        Cancel<native><override>()<transacts>: void
      }

      world_partition_streaming_source_target_behavior<epic_internal><native> := enum {
        Exclude

        Include
      }
    }
  }
}

Tests<public> := module {
  # Verse path: /UnrealEngine.com/Tests
  # Module import path: /UnrealEngine.com/Tests/NexusUtils
  NexusUtils<public> := module {
    # Call a console command on all clients
    ExecuteConsoleCommandOnAllClients<epic_internal><native>(ConsoleCommand: string): void

    # Force a client garbage collection for all connected clients
    ForceGarbageCollectionOnAllClients<epic_internal><native>(): void

    GetSavedDir<epic_internal><native>(): string

    # Returns true when running on the new Verse VM (VVM); false on legacy
    # Blueprint VM (BPVM). Build-time decision; never changes at runtime.
    IsVVM<epic_internal><native>()<computes>: logic

    PrintEpicAPIFunctionLog<epic_internal><native>(): void

    # Reads a file at a given path, returns a string array. Optionally prepends
    # path to executables 'Saved' directory
    ReadFile<epic_internal><native>(FilePath: []string)<transacts><decides>: []string

    # Takes a screenshot on clients that are connected to the server this is
    # called onPasses in the file name of the screenshot that gets saved to a
    # fixed directory
    ScreenshotAllClients<epic_internal><native>(ScreenshotFileName: string): void

    StoreValueForAutomation<epic_internal><native>(Key: string, Value: string): void

    # Writes a string array of lines to a file at a given path. Optionally
    # prepends path to executables 'Saved' directory
    WriteFile<epic_internal><native>(FilePath: []string, Lines: []string)<transacts>: void
  }
}

VerseTypeEditor<public> := module {
  using { /Verse.org/Assets }
  # Verse path: /UnrealEngine.com/VerseTypeEditor
  verse_type_editor_asset<epic_internal><native> := class(asset) {}
}

WebAPI<public> := module {
  MakeClient<public><native>(ClientId: client_id)<converges>: client

  body_response<public><native> := class<internal>(response) {
    GetBody<public><native>()<computes>: string
  }

  client<public><native> := class<internal><final><computes> {
    Get<public><native>(Path: string)<suspends>: response
  }

  # Verse path: /UnrealEngine.com/WebAPI
  # Usage:
  #     Licensed users create a derived version of `client_id` in their module.
  #     The Verse class path for your derived `client_id` is then used as the
  #     configuration key in your backend service to map to your endpoint.
  #
  #     WARNING: do not make your derived `client_id` class public. This object
  #     type is your private key to your backend.
  #
  # Example:
  #     my_client_id<internal> := class<final><computes>(client_id)
  #     MyClient<internal> := MakeClient(my_client_id)
  client_id<public><native> := class<abstract><computes> {}

  response<public><native> := class<internal> {}
}
