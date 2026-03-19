# Copyright Epic Games, Inc. All Rights Reserved.
#################################################
# Generated Digest of Verse API
# DO NOT modify this manually!
# Generated from build: ++Fortnite+Release-40.00-CL-51746096
#################################################

# Module import path: /Fortnite.com/AI
AI<public> := module {
  # Returns the `npc_behavior` for `InAgent`.
  (InAgent: agent).GetNPCBehavior<native><public>()<transacts><decides>: npc_behavior

  # Get the focus_interface interface for the specified character.
  (InCharacter: fort_character).GetFocusInterface<public>()<transacts><decides>: focus_interface = external {}

  # Get the current fort_leashable interface for the specified character.
  (InCharacter: fort_character).GetFortLeashable<public>()<transacts><decides>: fort_leashable = external {}

  # Get the navigatable interface for the specified character
  (InCharacter: fort_character).GetNavigatable<public>()<transacts><decides>: navigatable = external {}

  # Generate a navigation_target from an agent.
  MakeNavigationTarget<native><public>(Agent: agent): navigation_target

  # Generate a navigation_target from any position.
  MakeNavigationTarget<native><public>(Position: (/Verse.org/SpatialMath:)vector3): navigation_target

  # Generate a navigation_target from any position.
  MakeNavigationTarget<public>(Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3): navigation_target = external {}

  using { /Fortnite.com/Characters }
  using { /Fortnite.com/Teams }
  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /Verse.org/SpatialMath }
  @available { MinUploadedAtFNVersion := 3900 }
  # Result of a failed AI action
  ai_action_error_type<native><public> := enum<open> {
    # The action has been canceled before completion.
    Canceled

    # The action was not allowed to start.
    Disallowed

    # The action has failed during its execution.
    Failure
  }

  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  @available { MinUploadedAtFNVersion := 3800 }
  # Component to manage functionality specifically for an agent's equipped Sidekick.
  equipped_sidekick_component<native><public> := class<final_super><epic_internal>(sidekick_component, showable) {
    # Signaled whenever the Sidekick's mood changes, either via the underlying mood system, or an override is applied. Returns (Previous Mood, New Mood).
    ChangeMoodEvent<override><native>: listenable(tuple(sidekick_mood, sidekick_mood)) = external {}

    # Get the Sidekick's current mood.
    GetMood<override><native>()<reads>: sidekick_mood

    # Get the agent that owns this Sidekick.
    GetOwningAgent<native><public>()<transacts><decides>: agent

    # Request to play a given reaction on the sidekick.
    # This reaction is not guaranteed to play immediately; instead, the StartPlayReactionEvent should be used to monitor this.
    # This will fail if the Sidekick cannot play the given reaction.
    PlayReaction<override><native>(Reaction: sidekick_reaction)<transacts><decides>: void

    # Signaled when the Sidekick starts to play a reaction, returns the reaction that started playing.
    StartPlayReactionEvent<override><native>: listenable(sidekick_reaction) = external {}

    # Signaled when the Sidekick ends playing a reaction, returns the reaction that played.
    StopPlayReactionEvent<override><native>: listenable(sidekick_reaction) = external {}

    # The Sidekick will run animations to react to the state of the player. Is this system enabled?
    var AutomaticReactionsEnabled<public>: logic = external {}

    # Sidekicks have a built-in player interaction; this can be disabled by setting this to false.
    var DefaultInteractionEnabled<public>: logic = external {}

    # By default, Sidekicks will change their mood depending on actions in the game.
    # This value will lock the Sidekick into the mood passed in, overriding the automatic mood system.
    var MoodOverride<override>: ?sidekick_mood = external {}

    # Is the Sidekick visible?
    var Show<override>: logic = external {}
  }

  focus_interface<public> := interface<epic_internal> {
    # Look At specified Agent. Will never complete unless interrupted.
    MaintainFocus<public>(Agent: agent)<suspends>: void

    # Look At specified location. Will never complete unless interrupted.
    MaintainFocus<public>(Location: (/UnrealEngine.com/Temporary/SpatialMath:)vector3)<suspends>: void
  }

  fort_leashable<public> := interface<epic_internal> {
    # Removes the current leash.
    ClearLeash<public>(): void

    # Set the agent to be the new center of the leash.
    #  'InnerRadius' ranges from 0.0 to 20000.0 (in centimeters).
    #  'OuterRadius' ranges from 0.0 to 20000.0 (in centimeters) and no less than 'InnerRadius'.
    SetLeashAgent<public>(Agent: agent, InnerRadius: float, OuterRadius: float): void

    # Set custom leash position.
    #  'InnerRadius' ranges from 0.0 to 20000.0 (in centimeters).
    #  'OuterRadius' ranges from 0.0 to 20000.0 (in centimeters) and no less than 'InnerRadius'.
    SetLeashPosition<public>(
      Location: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      InnerRadius: float,
      OuterRadius: float
    ): void
  }

  @available { MinUploadedAtFNVersion := 3900 }
  # Fortnite Guards AI actions management
  guard_actions_component<native><public> := class<final_super><epic_internal>(npc_actions_component) {
    # Attack the target. The target must have been detected.
    Attack<native><public>(Target: entity)<suspends>: result(void, ai_action_error_type)

    # Change stance to crouch. Will never complete unless interrupted.
    Crouch<native><public>()<suspends>: result(void, ai_action_error_type)

    # Trigger a jump.
    Jump<native><public>()<suspends>: result(void, ai_action_error_type)

    # Move in range to attack the current target.
    MoveInRangeToAttack<native><public>()<suspends>: result(void, ai_action_error_type)

    # Play a random emote from the character emotes bank.
    PlayRandomEmote<native><public>()<suspends>: result(void, ai_action_error_type)

    # Revive the specified target.
    Revive<native><public>(Target: entity)<suspends>: result(void, ai_action_error_type)

    # Roam around the current position. Use 'Tether' to specify the radius; otherwise, the Fortnite guard will roam anywhere.
    RoamAround<native><public>(?MovementType: movement_type = external {})<suspends>: result(void, ai_action_error_type)

    # Trigger a slide.
    Slide<native><public>()<suspends>: result(void, ai_action_error_type)

    # Go back to standing.
    StandUp<native><public>()<suspends>: result(void, ai_action_error_type)

    # Tether the NPC to a position.
    #  'Radius' is in centimeters.
    Tether<native><public>(Location: (/Verse.org/SpatialMath:)vector3, Radius: float): void

    # Tether the NPC to an entity.
    #  'Radius' is in centimeters.
    Tether<native><public>(Target: entity, Radius: float): void

    # Untether the NPC.
    Untether<native><public>(): void
  }

  @available { MinUploadedAtFNVersion := 3900 }
  # The different alert levels of a Fortnite Guard.
  guard_alert_level<native><public> := enum {
    # The guard has identified a hostile target.
    Alerted

    # The guard has identified a hostile target but can't see it any more.
    LostTarget

    # The guard has seen a hostile target but hasn't identified it yet.
    Suspicious

    # The guard has not detected any hostile target.
    Unaware
  }

  @available { MinUploadedAtFNVersion := 3900 }
  # Fortnite Guard perception management
  guard_awareness_component<native><public> := class<final_super><epic_internal>(npc_awareness_component) {
    # Event when the alert level has changed.
    AlertLevelChangeEvent<native><public>: listenable(guard_alert_level) = external {}

    # Event when a new obstacle is detected.
    DetectObstacleEvent<native><public>: listenable(entity) = external {}

    # Event when the current obstacle was forgotten.
    ForgetObstacleEvent<native><public>: listenable(entity) = external {}

    # Get the current alert level for a specific target.
    GetAlertLevel<native><public>(Target: entity)<reads>: guard_alert_level

    # Event when the primary threat has changed.
    PrimaryThreatChangeEvent<native><public>: listenable(npc_target_info) = external {}

    # Current alert level.
    var<private> AlertLevel<native><public>: guard_alert_level = external {}

    # Potentially detected obstacle.
    var<private> DetectedObstacle<native><public>: ?entity = external {}

    # Information about the primary threat.
    var<private> PrimaryThreat<native><public>: ?npc_target_info = external {}
  }

  movement_type<native><public> := enum<open> {
    (/Fortnite.com/AI/movement_type:)Running

    Sprinting

    (/Fortnite.com/AI/movement_type:)Walking
  }

  # Module import path: /Fortnite.com/AI/movement_types
  movement_types<public> := module {
    Running<public>: movement_type = external {}

    Walking<public>: movement_type = external {}
  }

  navigatable<public> := interface<epic_internal> {
    # Return the current destination of the character
    GetCurrentDestination<public>()<transacts><decides>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3

    # Navigate toward the specified target
    NavigateTo<public>(
      Target: navigation_target,
      ?MovementType: movement_type = external {},
      ?ReachRadius: float = external {},
      ?AllowPartialPath: logic = external {}
    )<suspends>: navigation_result

    # Apply a multiplier on the movement speed (Multiplier is clamped between 0.5 and 2)
    SetMovementSpeedMultiplier<public>(Multiplier: float): void

    # Stop navigation
    StopNavigation<public>(): void

    # Wait for a specific duration
    Wait<public>(?Duration: float = external {})<suspends>: void
  }

  @available { MinUploadedAtFNVersion := 3900 }
  navigation_action_error_type<native><public> := enum<open> {
    # The navigating agent is blocked.
    Blocked

    # Navigation has been interrupted before completion.
    Interrupted

    # The navigation request is invalid.
    Invalid

    # The destination cannot be reached.
    Unreachable
  }

  @available { MinUploadedAtFNVersion := 3900 }
  navigation_action_success_type<native><public> := enum<open> {
    # The destination was partially reached (the destination is currently not reachable).
    PartiallyReached

    # The destination has been reached.
    Reached
  }

  # Result of a navigation request
  navigation_result<native><public> := enum {
    # The navigating agent is blocked
    Blocked

    # Navigation has been interrupted before completion
    Interrupted

    # The destination has been partially reached (AllowPartialPath was used)
    PartiallyReached

    # The destination has been reached
    Reached

    # The destination cannot be reached
    Unreachable
  }

  navigation_target<native><public> := class<epic_internal> {}

  @available { MinUploadedAtFNVersion := 3900 }
  # Fortnite NPC AI actions management
  npc_actions_component<native><public> := class<final_super><epic_internal>(component) {
    # Look at the specified location. If LockFocus is false, the action stops once the NPC is facing the position.
    Focus<native><public>(Location: (/Verse.org/SpatialMath:)vector3, ?LockFocus: logic = external {})<suspends>: void

    # Look at the specified Entity. If LockFocus is false, the action stops once the NPC is facing the entity.
    Focus<native><public>(Target: entity, ?LockFocus: logic = external {})<suspends>: void

    # Return the current destination of the character.
    GetCurrentDestination<native><public>()<transacts><decides>: (/Verse.org/SpatialMath:)vector3

    # Stay idle for a specific duration.
    Idle<native><public>(?Duration: float = external {})<suspends>: void

    # Navigate toward the specified navigation target.
    NavigateTo<native><public>(
      Target: navigation_target,
      ?MovementType: movement_type = external {},
      ?ReachRadius: float = external {},
      ?AllowPartialPath: logic = external {}
    )<suspends>: result(navigation_action_success_type, navigation_action_error_type)

    # Stop navigation.
    StopNavigation<native><public>(): void

    # Multiplier on the movement speed (value is clamped between 0.5 and 2).
    var MovementSpeedMultiplier<public>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 3900 }
  # Fortnite NPC perception management
  npc_awareness_component<native><public> := class<final_super><epic_internal>(component) {
    # Event when a target was detected.
    DetectTargetEvent<native><public>: listenable(npc_target_info) = external {}

    # Event when a target was forgotten.
    ForgetTargetEvent<native><public>: listenable(entity) = external {}

    # Event when a target is heard. Hearing sense must be active.
    HearTargetEvent<native><public>: listenable(npc_target_info) = external {}

    # Event when a target is seen. Sight sense must be active.
    SeeTargetEvent<native><public>: listenable(npc_target_info) = external {}

    # Event when a target is touched. Touch sense must be active.
    TouchTargetEvent<native><public>: listenable(npc_target_info) = external {}

    # Information about all detected targets.
    var<private> DetectedTargets<native><public>: []npc_target_info = external {}
  }

  # Inherit from this to create a custom NPC behavior.
  # The npc_behavior can be defined for a character in a CharacterDefinition asset, or in a npc_spawner_device.
  npc_behavior<native><public> := class<abstract> {
    # Returns the agent associated with this behavior.
    GetAgent<native><public>()<transacts><decides>: agent

    # Returns the entity associated with this behavior.
    GetEntity<native><public>()<transacts><decides>: entity

    # This function is called when the NPC is added to the simulation.
    OnBegin<native_callable><public>()<suspends>: void = external {}

    # This function is called when the NPC is removed from the simulation.
    OnEnd<native_callable><public>(): void = external {}
  }

  @available { MinUploadedAtFNVersion := 3800 }
  # Component to manage functionality specifically for an NPC Sidekick.
  npc_sidekick_component<native><public> := class<final_super><epic_internal>(sidekick_component) {
    # Signaled whenever the Sidekick's mood changes, either via the underlying mood system, or an override is applied. Returns the previous and new mood.
    ChangeMoodEvent<override><native>: listenable(tuple(sidekick_mood, sidekick_mood)) = external {}

    # Get the Sidekick's current mood.
    GetMood<override><native>()<reads>: sidekick_mood

    # Request to play a given reaction on the Sidekick.
    # This reaction is not guaranteed to play immediately; instead, the StartPlayReactionEvent should be used to monitor this.
    # This will fail if the Sidekick cannot play the given reaction.
    PlayReaction<override><native>(Reaction: sidekick_reaction)<transacts><decides>: void

    # Signaled when the Sidekick starts to play a reaction, returns the reaction that started playing.
    StartPlayReactionEvent<override><native>: listenable(sidekick_reaction) = external {}

    # Signaled when the Sidekick ends playing a reaction, returns the reaction that played.
    StopPlayReactionEvent<override><native>: listenable(sidekick_reaction) = external {}

    # By default, Sidekicks will change their mood depending on actions in the game.
    # This value will lock the Sidekick into the mood passed in, overriding the automatic mood system.
    var MoodOverride<override>: ?sidekick_mood = external {}
  }

  @available { MinUploadedAtFNVersion := 3900 }
  # Information about a perceived target.
  npc_target_info<native><public> := class<epic_internal> {
    OnUpdateEvent<native><public>: listenable(tuple()) = external {}

    # The entity that was detected.
    Target<native><public>: entity

    # Attitude toward this target.
    var<private> Attitude<native><public>: team_attitude

    # True if the target can be seen.
    var<private> HasLineOfSight<native><public>: logic

    # Last known position of this target.
    var<private> LastKnownPosition<public>: (/Verse.org/SpatialMath:)vector3 = external {}
  }

  @available { MinUploadedAtFNVersion := 3800 }
  # Component to manage functionality shared by all Sidekick types.
  sidekick_component<native><public> := class<abstract><final_super><epic_internal>(component) {
    # Signaled whenever the Sidekick's mood changes, either via the underlying mood system, or an override is applied. Returns the previous and new mood.
    ChangeMoodEvent<public>: listenable(tuple(sidekick_mood, sidekick_mood))

    # Get the Sidekick's current mood.
    GetMood<public>()<reads>: sidekick_mood

    # Request to play a given reaction on the Sidekick.
    # This reaction is not guaranteed to play immediately; instead, the StartPlayReactionEvent should be used to monitor this.
    # This will fail if the Sidekick cannot play the given reaction.
    PlayReaction<public>(Reaction: sidekick_reaction)<transacts><decides>: void

    # Signaled when the Sidekick starts to play a reaction, returns the reaction that started playing.
    StartPlayReactionEvent<public>: listenable(sidekick_reaction)

    # Signaled when the Sidekick ends playing a reaction, returns the reaction that played.
    StopPlayReactionEvent<public>: listenable(sidekick_reaction)

    # By default, Sidekicks will change their mood depending on actions in the game.
    # This value will lock the Sidekick into the mood passed in, overriding the automatic mood system.
    var MoodOverride<public>: ?sidekick_mood = external {}
  }

  @available { MinUploadedAtFNVersion := 3800 }
  # Sidekicks have a mood that modifies their animations to suit that mood.
  # This is the list of currently supported moods.
  sidekick_mood<native><public> := enum<open> {
    Bored

    Combat

    Neutral

    Worried
  }

  @available { MinUploadedAtFNVersion := 3800 }
  # The set of available reactions that can be played on the Sidekick
  sidekick_reaction<native><public> := enum<open> {
    Angry

    Dance

    Emote

    Happy

    Worried
  }

  @available { MinUploadedAtFNVersion := 3800 }
  # component to manage an entity that supports a Spark mode.
  # Spark mode will transform the entity into a floating spark.
  # The entity will enter `spark mode` whenever it enters impassable terrain or to reduce visual clutter.
  spark_mode_component<native><public> := class<final_super><epic_internal>(component) {
    # Signaled when the Sidekick enters spark mode.
    BeginSparkModeEvent<native><public>: listenable(tuple()) = external {}

    # Signaled when the Sidekick exits spark mode
    EndSparkModeEvent<native><public>: listenable(tuple()) = external {}

    # Automatic switching in and out of spark mode can be turned off, forcing spark mode always, by setting this value to true.
    var SparkModeAlwaysActive<public>: logic = external {}
  }
}

# Module import path: /Fortnite.com/Animation
Animation<public> := module {
  # Module import path: /Fortnite.com/Animation/PlayAnimation
  PlayAnimation<public> := module {
    # Get the play_animation_controller for the specified character.
    (InCharacter: fort_character).GetPlayAnimationController<native><public>()<transacts><decides>: play_animation_controller

    # An interface for playing an animation on an object.
    play_animation_controller<native><public> := interface<epic_internal> {
      # Start an animation sequence and obtain an instance to query and manipulate.
      Play<public>(
        AnimationSequence: animation_sequence,
        ?PlayRate: float = external {},
        ?PlayCount: float = external {},
        ?StartPositionSeconds: float = external {},
        ?BlendInTime: float = external {},
        ?BlendOutTime: float = external {}
      ): play_animation_instance

      # Play an animation sequence.
      PlayAndAwait<public>(
        AnimationSequence: animation_sequence,
        ?PlayRate: float = external {},
        ?PlayCount: float = external {},
        ?StartPositionSeconds: float = external {},
        ?BlendInTime: float = external {},
        ?BlendOutTime: float = external {}
      )<suspends>: play_animation_result
    }

    # An animation instance created from play_animation_controller.Play that can be queried and manipulated.
    play_animation_instance<native><public> := class<epic_internal> {
      # Helper function that waits for the animation to complete or be interrupted.
      Await<public>()<suspends>: play_animation_result = external {}

      # Event triggered when the animation has finished to blend out.
      BlendedInEvent<native><public>: listenable(tuple()) = external {}

      # Event triggered when the animation is beginning to blend out.
      BlendingOutEvent<native><public>: listenable(tuple()) = external {}

      # Event triggered when the animation is completed.
      CompletedEvent<native><public>: listenable(tuple()) = external {}

      # Returns the state of the animation playback.
      GetState<native><public>()<transacts>: play_animation_state

      # Event triggered when the animation is interrupted.
      InterruptedEvent<native><public>: listenable(tuple()) = external {}

      # Helper function that succeeds if the state is Playing, BlendingIn, or BlendingOut.
      IsPlaying<public>()<transacts><decides>: void = external {}

      # Stops the animation.
      Stop<native><public>(): void
    }

    using { /Fortnite.com/Characters }
    using { /Verse.org/Assets }
    # Result of a PlayAndAwait request.
    play_animation_result<native><public> := enum {
      # The animation completed successfully.
      Completed

      # The animation encountered an error during initialization or whilst playing.
      Error

      # The animation was interrupted whilst playing.
      Interrupted
    }

    # The potential states of a play animation instance.
    play_animation_state<native><public> := enum {
      # The animation is blending in.
      BlendingIn

      # The animation is playing and is blending out.
      BlendingOut

      # The animation completed successfully.
      Completed

      # An error occurred at creation or during playback.
      Error

      # The animation was interrupted externally.
      Interrupted

      # The animation has blended in, is playing, and has not begun blending out.
      Playing

      # The animation was stopped internally.
      Stopped
    }
  }
}

# Module import path: /Fortnite.com/Characters
Characters<public> := module {
  # Returns the `fort_character` for `InAgent`. Fails if `InAgent` is not a `fort_character`.
  (InAgent: agent).GetFortCharacter<native><public>()<transacts><decides>: fort_character

  # Returns a `game_action_instigator` interface for `InAgent`.
  (InAgent: agent).GetInstigator<native><public>()<transacts>: game_action_instigator

  # Returns the `agent` for `InInstigator`. Fails if `InInstigator` is not an `agent`.
  (InInstigator: game_action_instigator).GetInstigatorAgent<native><public>()<transacts><decides>: agent

  using { /Fortnite.com/Game }
  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  using { /Verse.org/SpatialMath }
  # Main API implemented by Fortnite characters.
  fort_character<native><public> := interface<unique><epic_internal>(
    positional,
    healable,
    healthful,
    damageable,
    shieldable,
    game_action_instigator,
    game_action_causer
  ) {
    # Apply a force to a ‘fort_character’ with units in Newtons. Will not do anything if physics is disabled.
    ApplyForce<public>(Force: (/Verse.org/SpatialMath:)vector3): void

    # Apply a linear impulse to a ‘fort_character’ with units in Newton*seconds. Will not do anything if physics is disabled.
    ApplyLinearImpulse<public>(LinearImpulse: (/Verse.org/SpatialMath:)vector3): void

    # Signaled when this `fort_character` changes crouch state.
    # Sends `tuple` payload:
    #  - 0: the `fort_character` that changed crouch states.
    #  - 1: `true` if the character is crouching. `false` if the character is not crouching.
    CrouchedEvent<public>(): listenable(tuple(fort_character, logic))

    # Signaled when this `fort_character` is eliminated from the match.
    EliminatedEvent<public>(): listenable(elimination_result)

    # Returns the agent associated with this `fort_character`. Use this when interacting with APIs that require an `agent` reference.
    GetAgent<public>()<transacts><decides>: agent

    # Returns the entity associated with this `fort_character`. Use this when interacting with APIs that require an `entity` reference.
    GetEntity<public>()<transacts><decides>: entity

    # Returns a ‘fort_character’s linear velocity in meters/second.
    GetLinearVelocity<public>()<reads>: (/Verse.org/SpatialMath:)vector3

    # Returns a ‘fort_character’s mass in kilograms.
    GetMass<public>()<reads>: float

    # Returns the location where this `fort_character` is looking or aiming from.
    GetViewLocation<public>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3

    # Returns the rotation where this `fort_character` is looking or aiming at.
    GetViewRotation<public>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Sets this `fort_character` visibility to invisible.
    Hide<public>(): void

    # Succeeds if this `fort_character` is in the world and has not been eliminated. Most fort_character actions will silently fail if this fails. Please test IsActive if you want to handle these failure cases rather than allow them to silently fail.
    IsActive<public>()<transacts><decides>: void

    # Succeeds if this `fort_character` is crouching.
    IsCrouching<public>()<transacts><decides>: void

    # Succeeds if this `fort_character` is in the 'Down But Not Out' state. In this state the character is down but can still be revived by teammates for a period of time.
    IsDownButNotOut<public>()<transacts><decides>: void

    # Succeeds if this `fort_character` is in falling locomotion state.
    IsFalling<public>()<transacts><decides>: void

    # Succeeds if this `fort_character` is in flying locomotion state.
    IsFlying<public>()<transacts><decides>: void

    # Succeeds if this `fort_character` is in gliding locomotion state.
    IsGliding<public>()<transacts><decides>: void

    # Succeeds if this `fort_character` is standing in the air.
    IsInAir<public>()<transacts><decides>: void

    # Succeeds if this `fort_character` is inside water volume.
    IsInWater<public>()<transacts><decides>: void

    # Succeeds if this `fort_character` is standing on the ground.
    IsOnGround<public>()<transacts><decides>: void

    # Succeeds if this `fort_character` can be damaged. Fails if this `fort_character` cannot be damaged.
    IsVulnerable<public>()<transacts><decides>: void

    # Signaled when this `fort_character` jumps. Returns a listenable with a payload of this `fort_character`.
    JumpedEvent<public>(): listenable(fort_character)

    # Puts this `fort_character` into stasis, preventing certain types of movement specified by `Args`.
    PutInStasis<public>(Args: stasis_args)<transacts>: void

    # Release this `fort_character` from stasis.
    ReleaseFromStasis<public>()<transacts>: void

    # Set a ‘fort_character’s linear velocity in meters/second. Will not do anything if physics is disabled.
    SetLinearVelocity<public>(LinearVelocity: (/Verse.org/SpatialMath:)vector3): void

    # Control if this `fort_character` can be damaged.
    SetVulnerability<public>(Vulnerable: logic)<transacts>: void

    # Sets this `fort_character` visibility to visible.
    Show<public>(): void

    # Signaled when this `fort_character` changes sprint state.
    # Sends `tuple` payload:
    #  - 0: the `fort_character` that changed sprint state.
    #  - 1: `true` if the character is sprinting. `false` if the character stopped sprinting.
    SprintedEvent<public>(): listenable(tuple(fort_character, logic))

    # Teleports this `fort_character` to the provided `Position` and applies the yaw and pitch of `Rotation`. Will fail if the `Position` specified is e.g. outside of the playspace or specifies a place where the character cannot fit.
    TeleportTo<public>(
      Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<transacts><decides>: void
  }

  # Parameters for `fort_character.PutInStasis` function.
  stasis_args<native><public> := struct {
    # Controls if `fort_character` can still perform emotes while in stasis.
    AllowEmotes<native><public>: logic = external {}

    # Controls if `fort_character` can still fall while in stasis.
    AllowFalling<native><public>: logic = external {}

    # Controls if `fort_character` can still turn while in stasis.
    AllowTurning<native><public>: logic = external {}
  }
}

Devices<public> := module {
  # Returns the simulation entity at the root of the experience this `creative_device` is operating within.
  #   * The simulation entity is the rootmost entity in an experience.
  #   * Fails if this `creative_device` is not operating in a context with a valid SimulationEntity.
  (CreativeDevice: creative_device).(/Fortnite.com/Devices:)GetSimulationEntity<native><public>()<transacts><decides>: entity

  # Returns the simulation entity at the root of the experience this `creative_object` is operating within.
  #   * The simulation entity is the rootmost entity in an experience.
  #   * Fails if this `creative_object` is not operating in a context with a valid SimulationEntity.
  (CreativeObject: creative_object).(/Fortnite.com/Devices:)GetSimulationEntity<native><public>()<transacts><decides>: entity

  # Returns the `fort_playspace` that `CreativeObject` belongs to.
  (CreativeObject: creative_object_interface).GetPlayspace<native><public>()<transacts>: fort_playspace

  # Returns a queryable `tag_view` which can be used to query the tags on `CreativeObject`.
  (CreativeObject: creative_object_interface).GetTags<native><public>()<transacts>: tag_view

  @available { MinUploadedAtFNVersion := 2930 }
  @deprecated
  # DEPRECATED - use corresponding extension methods that takes a tag type instead of a tag instance.
  # Generates a `creative_object_interface` for every creative object that has been marked with the specified `Tag`. Will not find anything if called on a default constructed object.
  (InCreativeDevice: creative_device).FindCreativeObjectsWithTag<public>(Tag: tag)<transacts>: generator(creative_object_interface) = external {}

  @available { MinUploadedAtFNVersion := 3200 }
  # Generates a `creative_object_interface` for every creative object that has any tag of type `tag_type`. Will not find anything if called on a default constructed object.
  (InCreativeDevice: creative_device).FindCreativeObjectsWithTag<public>(tag_type: castable_subtype(tag))<transacts>: generator(creative_object_interface) = external {}

  @available { MinUploadedAtFNVersion := 2930 }
  @deprecated
  # DEPRECATED - use corresponding extension methods that takes a tag type instead of a tag instance.
  # Generates a `creative_object_interface` for every creative object that has been marked with the specified `Tag`. Will not find anything if called on a default constructed object.
  (InCreativeDevice: creative_device_base).FindCreativeObjectsWithTag<public>(Tag: tag)<transacts>: generator(creative_object_interface) = external {}

  @available { MinUploadedAtFNVersion := 3200 }
  # Generates a `creative_object_interface` for every creative object that has any tag of type `tag_type`. Will not find anything if called on a default constructed object.
  (InCreativeDevice: creative_device_base).FindCreativeObjectsWithTag<public>(tag_type: castable_subtype(tag))<transacts>: generator(creative_object_interface) = external {}

  @available { MinUploadedAtFNVersion := 2930 }
  @deprecated
  # DEPRECATED - use corresponding extension methods that takes a tag type instead of a tag instance.
  # Generates a `creative_object_interface` for every creative object that has been marked with the specified `Tag`. Will not find anything if called on an `entity` that is not in the scene.
  (InEntity: entity).FindCreativeObjectsWithTag<native><public>(Tag: tag)<transacts>: generator(creative_object_interface)

  @available { MinUploadedAtFNVersion := 3200 }
  # Generates a `creative_object_interface` for every creative object that has any tag of type `tag_type`. Will not find anything if called on an `entity` that is not in the scene.
  (InEntity: entity).FindCreativeObjectsWithTag<native><public>(tag_type: castable_subtype(tag))<transacts>: generator(creative_object_interface)

  @available { MinUploadedAtFNVersion := 3300 }
  @deprecated
  # DEPRECATED - use corresponding extension methods that takes a tag type instead of a tag instance.
  # Generates a `creative_object_interface` for every creative object that has been marked with the specified `Tag`. Will not find anything if called on an `npc_behavior` that is not simulating.
  (InNPCBehavior: npc_behavior).FindCreativeObjectsWithTag<native><public>(Tag: tag)<transacts>: generator(creative_object_interface)

  @available { MinUploadedAtFNVersion := 3200 }
  # Generates a `creative_object_interface` for every creative object that has any tag of type `tag_type`. Will not find anything if called on an `npc_behavior` that is not simulating.
  (InNPCBehavior: npc_behavior).FindCreativeObjectsWithTag<native><public>(tag_type: castable_subtype(tag))<transacts>: generator(creative_object_interface)

  using { /Fortnite.com/AI }
  using { /Fortnite.com/Playspaces }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation/Tags }
  # Module import path: /Fortnite.com/Devices/CreativeAnimation
  CreativeAnimation<public> := module {
    # Returns an `animation_controller` used to animate `Prop`. Only a subset of `creative_prop` types can be animated, though this may change in the future. A few examples of props that cannot be animated yet are:
    #  * Walls attached to buildings
    #  * Treasure chests
    #  * Loot llamas
    (Prop: creative_prop).GetAnimationController<public>()<transacts><decides>: animation_controller = external {}

    # Module import path: /Fortnite.com/Devices/CreativeAnimation/InterpolationTypes
    # Convenience interpolation modes. These built in modes are based on the CSS animation standard: https://www.w3.org/TR/css-easing-1/
    InterpolationTypes<public> := module {
      # `Ease` animations start slowly, speed up, then end slowly. The speed of the animation is slightly slower at the end than the start.
      Ease<public>: cubic_bezier_parameters = external {}

      # `EaseIn` animations start slow, then speed up towards the end.
      EaseIn<public>: cubic_bezier_parameters = external {}

      # `EaseInOut` animations are similar to `Ease` but the start and end animation speed is symmetric.
      EaseInOut<public>: cubic_bezier_parameters = external {}

      # `EaseOut` animations start fast, then slow down towards the end.
      EaseOut<public>: cubic_bezier_parameters = external {}

      # `Linear` animations move at a constant speed.
      Linear<public>: cubic_bezier_parameters = external {}
    }

    # Used to move and animate the position of `creative_prop` objects.
    #  * See `creative_prop.GetAnimationController` for information on acquiring an instance of an
    #    `animation_controller` for a given `creative_prop`.
    #  * See `SetAnimation` for details on authoring movement and animations.
    animation_controller<native><public> := class<epic_internal> {
      # Suspends at the callsite until the next `keyframe_delta` is finished. This will also return if the animation is aborted or not playing. See `await_next_keyframe_result` if your code needs to take different paths based on why `AwaitNextKeyframe` returned.
      AwaitNextKeyframe<native><public>()<suspends>: await_next_keyframe_result

      # Returns the current state of this `animation_controller`.
      GetState<native><public>()<transacts>: animation_controller_state

      # Succeeds if this `animation_controller`s target is still valid (i.e., the target has not been disposed of either via `Dispose` or through any external system.)
      IsValid<native><public>()<transacts><decides>: void

      # Signaled each time a keyframe is reached. Callback(KeyframeIndex:int, InReverse:logic). Note that the KeyframeIndex in the callback is generally in [1, NumDeltaKeyframes] except that in a PingPong animation the final keyframe played in reverse is identified as index 0. This is because SetAnimation takes *delta* keyframes whereas this event notifies the listener that a specific keyframe has been reached.
      KeyframeReachedEvent<native><public>: listenable(tuple(int, logic)) = external {}

      # Signaled when the entire animation is complete. This will only fire for `OneShot` animations.
      MovementCompleteEvent<native><public>: listenable(tuple()) = external {}

      # Pauses the animation if it is already playing.
      Pause<public>(): void = external {}

      # Starts or resumes playback of the animation.
      Play<public>(): void = external {}

      # Sets the animation for the `animation_controller`. Animations are processed in the order provided in `Keyframes`. See notes in `keyframe_delta` and `animation_mode` for more details on controlling the animations.
      SetAnimation<public>(Keyframes: []keyframe_delta, ?Mode: animation_mode): void = external {}

      # Signaled when the state has changed. Use `GetState` to get the new state.
      StateChangedEvent<native><public>: listenable(tuple()) = external {}

      # Stops playback and resets the animation to the first keyframe. Also resets the prop transform. Calling this method is valid while the animation is in the `Playing` or `Paused` states.
      Stop<public>(): void = external {}
    }

    # `animation_controller` states.
    animation_controller_state<native><public> := enum {
      # No animation has been successfully set via `animation_controller.SetAnimation`, or that animation has been cleared by a failed call to `animation_controller.SetAnimation`.
      AnimationNotSet

      # The target of the animation is not an animatable prop. This could be because:
      #  * It is not a `creative_prop` that can be animated.
      #  * It was disposed or otherwise destroyed.
      #  * It has the 'Register with Structural Grid' option set in UEFN.
      InvalidObject

      # Animation is paused.
      Paused

      # Animation is playing.
      Playing

      # Animation has either never started, finished, or was explicitly stopped.
      Stopped
    }

    # Animation play modes.
    animation_mode<native><public> := enum {
      # Play the animation in a loop. This requires the animation ends exactly where it began.
      Loop

      # Stop after playing the animation once.
      OneShot

      # Reverse direction after reaching the final `keyframe_delta`, then play the animation in reverse.
      PingPong
    }

    # Results for `animation_controller.AwaitNextKeyframe` function.
    await_next_keyframe_result<native><public> := enum {
      # The animation was canceled either due to the object being destroyed, becoming invalid, or because it was moved via some other API.
      AnimationAborted

      # The next keyframe has been reached successfully.
      KeyframeReached

      # No animation is currently playing and this function call has returned immediately.
      NotPlaying
    }

    using { /UnrealEngine.com/Temporary/SpatialMath }
    # A structure for defining Bezier interpolation parameters.
    # See https://en.wikipedia.org/wiki/B%C3%A9zier_curve for more info on Bezier curves.
    cubic_bezier_parameters<native><public> := struct<computes> {
      # X value of the P1 control point. `0.0 <= X0 <= 1.0` or an error will be generated when calling `animation_controller.SetAnimation`.
      X0<native><public>: float = external {}

      # X value of the P2 control point. `0.0 <= X1 <= 1.0 or an error will be generated when calling `animation_controller.SetAnimation`.
      X1<native><public>: float = external {}

      # Y value of the P1 control point.
      Y0<native><public>: float = external {}

      # Y value of the P2 control point.
      Y1<native><public>: float = external {}
    }

    # Instead of specifying the actual keyframe positions, we specify the keyframe *deltas*. This allows us to treat the initial position of the prop as keyframe 0 and avoid the question of how to get the prop to its initial location. For a `animation_mode.Loop` animation, the net rotation and translation must both be zero. Each delta is interpreted as a world-space transformation to be concatenated onto the previous transform(s).
    keyframe_delta<native><public> := struct {
      # Target position of the `creative_prop`. This is a world-space coordinate in cm, with the initial position of the `creative_prop` acting as coordinate (0,0).
      DeltaLocation<native><public>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3

      # Target rotation for the `creative_prop`. Rotations are relative to the starting rotation of the `creative_prop`
      DeltaRotation<native><public>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

      # Target scale for the `creative_prop`. Scale is multiplicative to the starting Scale of the `creative_prop`
      DeltaScale<native><public>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

      # Interpolation mode for this `keyframe_delta`. See `InterpolationTypes` for standard interpolation options. See `cubic_bezier_parameters` for authoring custom interpolations.
      # Default = `InterpolationTypes.Linear`
      Interpolation<native><public>: cubic_bezier_parameters = external {}

      # Time in seconds the `creative_prop` should animate between its last frame and this frame.
      Time<native><public>: float
    }
  }

  # A default asset to be used when creating an editor-specified `creative_prop_asset` variable.
  DefaultCreativePropAsset<public>: creative_prop_asset = external {}

  @deprecated
  # DEPRECATED - use `FindCreativeObjectsWithTag` instead.
  # Returns an array containing all creative objects which have been marked with the specified `Tag`.
  GetCreativeObjectsWithTag<native><public>(Tag: tag)<transacts>: []creative_object_interface

  @deprecated
  # DEPRECATED - use `FindCreativeObjectsWithTag` instead.
  # Returns an array containing creative objects which have tag(s) matching the specified `SearchCriteria`.
  GetCreativeObjectsWithTags<native><public>(SearchCriteria: tag_search_criteria)<transacts>: []creative_object_interface

  Patchwork<public> := module {
    cable_splitter_device<public> := class<concrete><final>(patchwork_device) {}

    # Apply a distortion effect to Patchwork audio inputs.
    distortion_effect_device<public> := class<concrete><final>(patchwork_device) {}

    # Turn Patchwork note inputs into audio using drum samples.
    drum_player_device<public> := class<concrete><final>(patchwork_device) {}

    # Create drum note patterns for Patchwork devices.
    drum_sequencer_device<public> := class<concrete><final>(patchwork_device) {}

    # Apply an echo effect to Patchwork audio inputs.
    echo_effect_device<public> := class<concrete><final>(patchwork_device) {}

    # Turn Patchwork note inputs into audio using instrument samples.
    instrument_player_device<public> := class<concrete><final>(patchwork_device) {}

    # Modify a setting on another Patchwork device in a regularly repeating pattern.
    lfo_modulator_device<public> := class<concrete><final>(patchwork_device) {}

    # Provides a shared tempo, key, and timeline for Patchwork devices to follow.
    music_manager_device<public> := class<concrete><final>(patchwork_device) {}

    # Transpose Patchwork note inputs to follow a chord progression.
    note_progressor_device<public> := class<concrete><final>(patchwork_device) {}

    # Create melodic note patterns for Patchwork devices.
    note_sequencer_device<public> := class<concrete><final>(patchwork_device) {}

    # Send events to devices based on Patchwork note inputs.
    note_trigger_device<public> := class<concrete><final>(patchwork_device) {}

    # Turn Patchwork note inputs into audio using customizable sound synthesis.
    omega_synthesizer_device<public> := class<concrete><final>(patchwork_device) {}

    # Base class for all Patchwork devices.
    patchwork_device<public> := class<concrete>(creative_device_base) {
      # Disables this device.
      Disable<public>(): void = external {}

      # Enables this device.
      Enable<public>(): void = external {}
    }

    song_sync_device<public> := class<concrete><final>(patchwork_device) {}

    # Output Patchwork audio for players to hear.
    speaker_device<public> := class<concrete><final>(patchwork_device) {}

    # Modify a setting on another Patchwork device in steps over time.
    step_modulator_device<public> := class<concrete><final>(patchwork_device) {}

    # Modify a setting on another Patchwork device when triggered.
    value_setter_device<public> := class<concrete><final>(patchwork_device) {}
  }

  # Spawns a `creative_prop` at the specified `Position` and `Rotation`. `Position` and `Rotation` units are in cm. The relative scale defined in the `creative_prop_asset` will be applied upon spawn.
  # Returns tuple:
  #  0: Instance of a `creative_prop`. False if no `creative_prop` could be created. See `spawn_prop_result` for failure cases.
  #  1: Success or failure results.
  SpawnProp<native><public>(
    Asset: creative_prop_asset,
    Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
    Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
  )<transacts>: tuple(?creative_prop, spawn_prop_result)

  # Spawns a `creative_prop` at the specified `Transform`. `Units are in cm.
  # Returns tuple:
  #  0: Instance of a `creative_prop`. False if no `creative_prop` could be created. See `spawn_prop_result` for failure cases.
  #  1: Success or failure results.
  SpawnProp<native><public>(
    Asset: creative_prop_asset,
    Transform: (/UnrealEngine.com/Temporary/SpatialMath:)transform
  )<transacts>: tuple(?creative_prop, spawn_prop_result)

  # Used to set up islands so players will earn Battle Pass XP when they interact with your island. Accolades are achievements or accomplishments that players can complete to earn XP.
  accolades_device<public> := class<concrete><final>(creative_device_base) {
    # Awards the XP to `agent`.
    Award<public>(Agent: agent): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when testing the accolade to make sure it is awarded as expected. Only signals within unpublished island environments.
    # Sends the `agent` receiving the achievement.
    TestAwardEvent<public>: listenable(agent) = external {}
  }

  using { /Verse.org/Native }
  # Used in conjunction with `advanced_storm_controller_device` to customize individual storm phases.
  advanced_storm_beacon_device<public> := class<concrete><final>(creative_device_base) {
    # Moves the `advanced_storm_beacon_device` to the specified `Position` and `Rotation` over the specified time, in seconds.
    # Existing storms will not target the new location, but newly generated storms will.
    MoveTo<override>(
      Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      OverTime: float
    )<suspends>: move_to_result = external {}

    # Moves the `advanced_storm_beacon_device` to the specified `Transform` over the specified time, in seconds.
    # Existing storms will not target the new location, but newly generated storms will.
    MoveTo<override>(
      Transform: (/UnrealEngine.com/Temporary/SpatialMath:)transform,
      OverTime: float
    )<suspends>: move_to_result = external {}

    # Teleports the `advanced_storm_beacon_device` to the specified `Position` and `Rotation`.
    # Existing storms will not target the new location, but newly generated storms will.
    TeleportTo<override>(
      Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<transacts><decides>: void = external {}

    # Teleports the `advanced_storm_beacon_device` to the specified location defined by `Transform`, also applies rotation and scale accordingly.
    # Existing storms will not target the new location, but newly generated storms will.
    TeleportTo<override>(Transform: (/UnrealEngine.com/Temporary/SpatialMath:)transform)<transacts><decides>: void = external {}
  }

  # Used to control a Battle Royale-style storm with up to 50 phases.
  #
  # Like `basic_storm_controller_device`s, you can use this storm to keep players inside a playable area, but unlike the `basic_storm_controller_device`, this device generates multiple storm phases. When used in conjunction with `advanced_storm_beacon_device`s, you can customize each phase of the storm by applying one or more beacons and setting customization options for the specific phase you assign to that beacon.
  advanced_storm_controller_device<public> := class<concrete><final>(storm_controller_device) {}

  # Used to create patrolling behavior for guards spawned with the `guard_spawner_device`.
  ai_patrol_path_device<public> := class<concrete><final>(creative_device_base) {
    # Assign an AI to this patrol path.
    Assign<public>(Patroller: agent): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Commands patroller to follow the *Next Patrol Path Group* instead of the default *Patrol Path Group*.
    GoToNextPatrolGroup<public>(Patroller: agent): void = external {}

    # Signaled when a guard cannot reach the next `ai_patrol_path_device`.
    NextNodeUnreachableEvent<public>: listenable(agent) = external {}

    # Signaled when a guard reaches this device.
    NodeReachedEvent<public>: listenable(agent) = external {}

    # Signaled when a guard starts moving on the patrol path.
    PatrolPathStartedEvent<public>: listenable(agent) = external {}

    # Signaled when a guard stops moving on the patrol path.
    PatrolPathStoppedEvent<public>: listenable(agent) = external {}
  }

  # Used to boost `agent`s, vehicles, and other objects upwards into the air.
  air_vent_device<public> := class<concrete><final>(creative_device_base) {
    # Activates this device.
    Activate<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Used to track `agent` events used to generate analytics.
  analytics_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Submits an event for `Agent`.
    Submit<public>(Agent: agent): void = external {}
  }

  # Used to select, spawn, and configure a skeletal mesh to play a specific animation.
  animated_mesh_device<public> := class<concrete><final>(creative_device_base) {
    # Pauses playback of the animation.
    Pause<public>(): void = external {}

    # Starts or resumes playback of the animation.
    Play<public>(): void = external {}

    # Starts or resumes reverse playback of the animation.
    PlayReverse<public>(): void = external {}
  }

  # Evaluates attributes for `agent` when signaled from other devices. Acts as branching logic, checking whether the `agent` associated with the signal passes all of the tests setup in this device, then sends a signal on either `PassEvent` or `FailEvent`.
  attribute_evaluator_device<public> := class<concrete><final>(trigger_base_device) {
    # Tests whether the specified agent satisfies the required conditions specified on the device (e.g. eliminations/score), and fires either the `PassEvent` or `FailEvent` accordingly.
    EvaluateAgent<public>(Agent: agent): void = external {}

    # Signaled when the `agent` from `EvaluateAgent` fails the requirements specified by this device.
    # Sends the `agent` originally passed to this device in `EvaluateAgent`.
    FailEvent<public>: listenable(agent) = external {}

    # Signaled when the `agent` from `EvaluateAgent` passes the requirements specified by this device.
    # Sends the `agent` originally passed to this device in `EvaluateAgent`.
    PassEvent<public>: listenable(agent) = external {}
  }

  # Used to manage sound buses via control bus mixes set on the Audio Mixer Device.
  audio_mixer_device<public> := class<concrete><final>(creative_device_base) {
    # Activates the mix set on the audio mixer.
    ActivateMix<public>(): void = external {}

    # Deactivates the mix set on the audio mixer.
    DeactivateMix<public>(): void = external {}

    # Adds `Agent` as a target when using the *CanBeHeardBy* Registered Players or NonRegisteredPlayers options.
    Register<public>(Agent: agent): void = external {}

    # Removes `Agent` as a target when using the *CanBeHeardBy* Registered Players or NonRegisteredPlayers options.
    Unregister<public>(Agent: agent): void = external {}

    # Removes all previously registered `agent`s when using the *CanBeHeardBy* Registered Players or NonRegisteredPlayers options.
    UnregisterAll<public>(): void = external {}
  }

  # Used to configure and play audio from the device location or from registered `agent`s.
  audio_player_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device. No longer allows this device to be triggered from other linked devices (i.e. triggers) and will stop any currently playing audio.
    Disable<public>(): void = external {}

    # Enables this device. Allows this device to be triggered from other linked devices (i.e. triggers) and allow calls to `Play` to succeed.
    Enable<public>(): void = external {}

    # Hides this device from the world.
    Hide<public>()<transacts>: void = external {}

    # Starts playing audio from this device.
    Play<public>(): void = external {}

    # Starts playing audio from this device for `Agent`. This can only be used when the device is set to be *Heard by Instigator*.
    Play<public>(Agent: agent): void = external {}

    # Adds `Agent` as a target to play audio from when activated.
    Register<public>(Agent: agent): void = external {}

    # Shows this device in the world.
    Show<public>()<transacts>: void = external {}

    # Stops any audio playing from this device.
    Stop<public>(): void = external {}

    # Stops any audio playing from this device for `Agent`. This can only be used when the device is set to be *Heard by Instigator*.
    Stop<public>(Agent: agent): void = external {}

    # Removes `Agent` as a target to play audio from when activated.
    Unregister<public>(Agent: agent): void = external {}

    # Removes all previously registered `agent`s as valid targets to play audio from when activated.
    UnregisterAll<public>(): void = external {}
  }

  using { /Fortnite.com/Game }
  # Used to create a customizable turret that can search for nearby targets.
  automated_turret_device<public> := class<concrete><final>(creative_device_base, healthful, healable) {
    # Triggers when someone enters the activation radius while nobody else is there.
    # Sends the activating `agent`. If the activator is a non-agent then `false` is returned.
    ActivatedEvent<public>: listenable(?agent) = external {}

    # Clears the turret's current target and returns the turret to searching for targets.
    #  * If the current target is still in range, it'll likely be the best target, and will be reacquired.
    #  * Combine with disabled targeting for best results.
    ClearTarget<public>(): void = external {}

    # Triggers when the turret is damaged.
    # Sends the triggering `agent`. If the activator is a non-agent then `false` is returned.
    DamagedEvent<public>: listenable(?agent) = external {}

    # Triggers when the turret is destroyed.
    # Sends the triggering `agent`. If the activator is a non-agent then `false` is returned.
    DestroyedEvent<public>: listenable(?agent) = external {}

    # Disables the turret, causing it to close and ignore its activation radius.
    Disable<public>(): void = external {}

    # Enables the turret to rotate, target, and track.
    Enable<public>(): void = external {}

    GetHealth<override>()<transacts>: float = external {}

    GetMaxHealth<override>()<transacts>: float = external {}

    # Returns the `agent` currently targeted by the device.
    GetTarget<public>(): ?agent = external {}

    Heal<override>(Amount: float): void = external {}

    Heal<override>(Args: healing_args): void = external {}

    HealedEvent<override>(): listenable(healing_result) = external {}

    # Sets the range in meters at which the turret will activate to `Range`.
    # This is clamped between `2.0` and `100.0` meters.
    SetActivationRange<public>(Range: float): void = external {}

    # Sets the amount of damage the turret will do per shot to targets to `Damage`.
    SetDamage<public>(Damage: float): void = external {}

    SetHealth<override>(Health: float)<transacts>: void = external {}

    SetMaxHealth<override>(MaxHealth: float)<transacts>: void = external {}

    # Set the supplied `Agent` as the turret's target.
    #  * The target will only change if `Agent` is within the activation radius, has direct line-of-sight to the turret,
    # is on a targetable team as determined by `Possible Targets`, and is not Down But Not Out.
    SetTarget<public>(Agent: agent): void = external {}

    # Sets the range in meters at which the turret will target to `Range`.
    # This is clamped between `2.0` and `100.0` meters. Setting it lower than 2m will disable Targeting.
    SetTargetRange<public>(Range: float): void = external {}

    # Set the turret to the same team as the supplied `Agent`.
    #  * Only usable if `Possible Targets` is not set to `Everyone`.
    (/Fortnite.com/Devices/automated_turret_device:)SetTeam<public>(Agent: agent): void = external {}

    # Triggers when the turret finds a target.
    # Sends the `agent` that was found.
    TargetFoundEvent<public>: listenable(agent) = external {}

    # Triggers when the turret loses a target.
    # Sends the `agent` that was lost.
    TargetLostEvent<public>: listenable(agent) = external {}

    # Set the turret to the Default Team.
    #  * Only usable if `Possible Targets` is not set to `Everyone`.
    UseDefaultTeam<public>(): void = external {}

    # Set the turret to the Wildlife & Creatures team.
    #  * Only usable if `Possible Targets` is not set to `Everyone`.
    UseTeamWildlifeAndCreatures<public>(): void = external {}
  }

  # Used to spawn various types of balls. Can be used to control HUD elements related to the spawned balls.
  ball_spawner_device<public> := class<concrete><final>(creative_device_base) {
    # Hides the floating HUD Icons from players, if these have been configured by the device.
    HideHUD<public>(): void = external {}

    # Shows the floating HUD Icons to players, if these have been configured by the device.
    ShowHUD<public>(): void = external {}
  }

  # A vault door that requires a start of a sequence to damage a number of weakpoints to open.
  bank_vault_device<public> := class<concrete><final>(creative_device_base, bank_vault_interface) {
    # Triggers when a weakpoint is activated. The weakpoint will begin to glow, but does not become vulnerable until a subsequent `WeakpointVulnerableEvent`.
    #  * Sends the `agent` that activated the vault or none if the sequence was triggered by a function, and the `int` index of the weakpoint from 0-4, in order of activation.
    ActivateWeakpointEvent<override>: listenable(tuple(?agent, int)) = external {}

    # Destroy the active weakpoint. Requires the device to be enabled. Must have active weakpoint.
    DestroyActiveWeakpoint<override>(): void = external {}

    # Triggers when a weakpoint is destroyed.
    #  * Sends the last `agent` that damaged the weakpoint or the `agent` that started the sequence if no external damage was done or none if the sequence was triggered by a function, and the `int` index of the weakpoint from 0-4, in order of activation.
    DestroyWeakpointEvent<override>: listenable(tuple(?agent, int)) = external {}

    # Disable the device. Pauses vault sequence.
    Disable<override>(): void = external {}

    # Enable the device.
    Enable<override>(): void = external {}

    # Destroys the remaining weakpoints and opens the vault door. Requires the device to be enabled.
    ForceOpen<override>(): void = external {}

    # Get active weakpoint's health. If there is no active weakpoint, returns false.
    GetActiveWeakpointHealth<override>()<transacts><decides>: float = external {}

    # Gets the active weakpoint's index starting at `0`, regardless of device's enabled state. Returns false if there is no active weakpoint, such as when the sequence is not active or directly after a weakpoint is destroyed.
    GetActiveWeakpointIndex<override>()<transacts><decides>: int = external {}

    # Gets the total number of weakpoints.
    GetWeakpointCount<override>(): int = external {}

    # Succeeds if the device is enabled, fails if it's disabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Whether the vault sequence is currently active and not paused.
    IsSequenceActive<override>()<transacts><decides>: void = external {}

    # Triggers when the vault is opened either by the destruction of its weakpoints or by an event.
    #  * Sends the last `agent` that damaged a weakpoint or the `agent` that started the sequence if no external damage was done or none if the sequence was triggered by a function.
    OpenEvent<override>: listenable(?agent) = external {}

    # Disable the weakpoint vulnerability and freeze the progress of each one. Weakpoints can only be damaged while the vault sequence is active.
    PauseSequence<override>(): void = external {}

    # Restores vault to default state, deactivates the device, and heals all weakpoints to max health. Requires the device to be enabled.
    (/Fortnite.com/Devices/bank_vault_interface:)Reset<override>(): void = external {}

    # Restores the active weakpoint to full health. Requires the device to be enabled. Must have active weakpoint.
    RestoreActiveWeakpoint<override>(): void = external {}

    # Set active weakpoint's health. Setting it to `0.0` will destroy the weakpoint. Clamps to maximum of WeakpointMaxHealth.
    SetActiveWeakpointHealth<override>(NewHealth: float): void = external {}

    # Begin the sequence of events to open the vault door without thermite, or unpauses the sequence if it was paused. Requires the device to be enabled. Weakpoints can only be damaged while the vault sequence is active.
    StartSequence<override>(): void = external {}

    # Triggers when the vault sequence is started by a player or event.
    #  * Sends the `agent` that triggered this event, if applicable.
    StartSequenceEvent<override>: listenable(?agent) = external {}

    # Triggers when a weakpoint becomes vulnerable.
    #  * Sends the `agent` that activated the vault or none if the sequence was triggered by a function, and the `int` index of the weakpoint from 0-4, in order of activation.
    WeakpointVulnerableEvent<override>: listenable(tuple(?agent, int)) = external {}

    # The max health of this device's weakpoints.
    var MaxWeakpointHealth<override>: float = external {}

    # Whether the player needs thermite when interacting with the door to start the vault opening sequence.
    var RequireThermite<override>: logic = external {}

    # Damage dealt to the active weakpoint each second. Negative numbers heal the weakpoint. Weakpoints can only be damaged while the vault sequence is active.
    var WeakpointDamagePerSecond<override>: float = external {}

    # Whether the weakpoint takes damage from weapons and items while vault sequence is active.
    var WeakpointTakesExternalDamage<override>: logic = external {}
  }

  bank_vault_interface<public> := interface<epic_internal>(enableable) {
    # Triggers when a weakpoint is activated. The weakpoint will begin to glow, but does not become vulnerable until a subsequent `WeakpointVulnerableEvent`.
    #  * Sends the `agent` that activated the vault or none if the sequence was triggered by a function, and the `int` index of the weakpoint from 0-4, in order of activation.
    ActivateWeakpointEvent<public>: listenable(tuple(?agent, int))

    # Destroy the active weakpoint. Requires the device to be enabled. Must have active weakpoint.
    DestroyActiveWeakpoint<public>(): void

    # Triggers when a weakpoint is destroyed.
    #  * Sends the last `agent` that damaged the weakpoint or the `agent` that started the sequence if no external damage was done or none if the sequence was triggered by a function, and the `int` index of the weakpoint from 0-4, in order of activation.
    DestroyWeakpointEvent<public>: listenable(tuple(?agent, int))

    # Destroys the remaining weakpoints and opens the vault door. Requires the device to be enabled.
    ForceOpen<public>(): void

    # Get active weakpoint's health. If there is no active weakpoint, returns false.
    GetActiveWeakpointHealth<public>()<transacts><decides>: float

    # Gets the active weakpoint's index starting at `0`, regardless of device's enabled state. Returns false if there is no active weakpoint, such as when the sequence is not active or directly after a weakpoint is destroyed.
    GetActiveWeakpointIndex<public>()<transacts><decides>: int

    # Gets the total number of weakpoints.
    GetWeakpointCount<public>(): int

    # Whether the vault sequence is currently active and not paused.
    IsSequenceActive<public>()<transacts><decides>: void

    # Triggers when the vault is opened either by the destruction of its weakpoints or by an event.
    #  * Sends the last `agent` that damaged a weakpoint or the `agent` that started the sequence if no external damage was done or none if the sequence was triggered by a function.
    OpenEvent<public>: listenable(?agent)

    # Disable the weakpoint vulnerability and freeze the progress of each one. Weakpoints can only be damaged while the vault sequence is active.
    PauseSequence<public>(): void

    # Restores vault to default state, deactivates the device, and heals all weakpoints to max health. Requires the device to be enabled.
    (/Fortnite.com/Devices/bank_vault_interface:)Reset<public>(): void

    # Restores the active weakpoint to full health. Requires the device to be enabled. Must have active weakpoint.
    RestoreActiveWeakpoint<public>(): void

    # Set active weakpoint's health. Setting it to `0.0` or false will destroy the weakpoint. Clamps to maximum of WeakpointMaxHealth.
    SetActiveWeakpointHealth<public>(newHealth: float): void

    # Begin the sequence of events to open the vault door without thermite, or unpauses the sequence if it was paused. Requires the device to be enabled. Weakpoints can only be damaged while the vault sequence is active.
    StartSequence<public>(): void

    # Triggers when the vault sequence is started by a player or event.
    #  * Sends the `agent` that triggered this event, if applicable.
    StartSequenceEvent<public>: listenable(?agent)

    # Triggers when a weakpoint becomes vulnerable.
    #  * Sends the `agent` that activated the vault or none if the sequence was triggered by a function, and the `int` index of the weakpoint from 0-4, in order of activation.
    WeakpointVulnerableEvent<public>: listenable(tuple(?agent, int))

    # Whether the player needs thermite when interacting with the door to start the vault opening sequence.
    var RequireThermite<public>: logic

    # Damage dealt to the active weakpoint each second. Negative numbers heal the weakpoint. Weakpoints can only be damaged while the vault sequence is active.
    var WeakpointDamagePerSecond<public>: float

    # Whether the weakpoint takes damage from weapons and items while vault sequence is active.
    var WeakpointTakesExternalDamage<public>: logic

    # The max health of this device's weakpoints.
    var<internal> MaxWeakpointHealth<public>: float
  }

  # Creates an impenetrable zone that can block `agent` movement and weapon fire.
  barrier_device<public> := class<concrete><final>(creative_device_base) {
    # Adds the specified `agent` to a list of additional `agent`s that the Barrier should ignore. This list is in addition to the Ignore Team and Ignore Class options. Note: Has no effect on bullets.
    AddToIgnoreList<public>(Agent: agent): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Removes all `agent`s from the ignore list. `Agent`s will still be ignored if they are on an ignored team or of an ignored class.
    RemoveAllFromIgnoreList<public>(): void = external {}

    # Removes the specified `agent` from the ignore list. The `agent` will still be ignored if they are on an ignored team or of an ignored class.
    RemoveFromIgnoreList<public>(Agent: agent): void = external {}
  }

  # Base class for devices that spawn items.
  base_item_spawner_device<public> := class<abstract><epic_internal>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when an `agent` picks up the spawned item.
    # Sends the `agent` that picked up the item.
    ItemPickedUpEvent<public>: listenable(agent) = external {}
  }

  # A simplified storm device that provides a way to create a single-phase storm and control its basic behaviors.
  # To control multiple phases of the storm see `advanced_storm_controller_device`.
  basic_storm_controller_device<public> := class<concrete><final>(storm_controller_device) {}

  # Used to show an in world visual effect and/or a HUD marker at the desired location.
  beacon_device<public> := class<concrete><final>(creative_device_base) {
    # Adds the specified `agent` to a list of `agent`s that the Beacon will be shown to. This list of `agent`s is maintained separately from the Team Visibility set of `agent`s.
    AddToShowList<public>(Agent: agent): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Removes all `agent`s from the show list. `Agent`s will still see the Beacon if they meet the Team Visibility check.
    RemoveAllFromShowList<public>(): void = external {}

    # Removes the specified `agent` from the show list. The `agent` will still see the Beacon if they meet the Team Visibility check.
    RemoveFromShowList<public>(Agent: agent): void = external {}
  }

  # Used to display custom text messages on a billboard.
  billboard_device<public> := class<concrete><final>(creative_device_base) {
    # Returns `true` if the device border is enabled.
    GetShowBorder<public>()<transacts>: logic = external {}

    # Returns the *Text Size* of the device *Text*.
    GetTextSize<public>()<transacts>: int = external {}

    # Hides the billboard text.
    HideText<public>(): void = external {}

    # Sets the visibility of the device border mesh. This also determines whether the device collision is enabled.
    SetShowBorder<public>(Show: logic): void = external {}

    # Sets the device *Text*.
    SetText<public>(Text: message): void = external {}

    # Sets the *Text Size* of the device *Text*. Clamped to range [8, 24].
    SetTextSize<public>(Size: int): void = external {}

    # Shows the billboard text.
    ShowText<public>(): void = external {}

    # Updates the device display to show the current *Text*.
    UpdateDisplay<public>(): void = external {}
  }

  # Used to create a bouncer that can launch players, vehicles, and more into the air with optional effects.
  bouncer_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when the condition in the *On Bounced Trigger* option is met and someone or something is launched.
    #  * Sends the `agent` that bounced. If a vehicle bounced, sends the driver. If a projectile bounced, sends its instigator.
    #  * Sends `false` if something else bounced, including a vehicle with no driver
    BouncedEvent<public>: listenable(?agent) = external {}

    # Disables bouncing on this device, as well as any visual and audio effects.
    Disable<public>(): void = external {}

    # Enables bouncing on this device, as well as any visual and audio effects.
    Enable<public>(): void = external {}

    # Signaled when the heal effect starts for an `agent`.
    HealStartEvent<public>: listenable(agent) = external {}

    # Signaled when the heal effect stops for an `agent`.
    HealStopEvent<public>: listenable(agent) = external {}
  }

  # Used to create a button which can trigger other devices when an agent interacts with it.
  button_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Returns the duration of the interaction required to activate this device (in seconds).
    GetInteractionTime<public>()<transacts>: float = external {}

    # Returns the maximum amount of times this button can be interacted with before it will be disabled.
    #  * `GetTriggerMaxCount` will be between `0` and `10`.
    #  * `0` indicates no limit on trigger count.
    GetMaxTriggerCount<public>()<transacts>: int = external {}

    # Returns the number of times that this button can still be interacted with before it will be disabled. Will return `0` if `GetMaxTriggerCount` is unlimited.
    GetTriggerCountRemaining<public>()<transacts>: int = external {}

    # Signaled when an `agent` successfully interacts with the button for `GetInteractionTime` seconds.
    # Sends the `agent` that interacted with the button.
    InteractedWithEvent<public>: listenable(agent) = external {}

    # Sets the text that displays when an `agent` is close to this button and looks at it. `Text` is limited to `64` characters.
    SetInteractionText<public>(Text: message): void = external {}

    # Sets the duration of the interaction required to activate this device (in seconds).
    SetInteractionTime<public>(Time: float): void = external {}

    # Sets the maximum amount of times this button can be interacted with before it will be disabled.
    #  * `MaxCount` must be between `0` and `10`.
    #  * `0` indicates no limit on trigger count.
    SetMaxTriggerCount<public>(MaxCount: int): void = external {}
  }

  # Used to place a campfire in the world that an `agent` can use to heal themselves.
  campfire_device<public> := class<concrete><final>(creative_device_base) {
    # Adds wood to this device.
    AddWood<public>(): void = external {}

    # Signaled when an `agent` enters the area of effect for this device.
    # Sends the entering `agent`.
    AgentEntersEffectAreaEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` exits the area of effect for this device.
    # Sends the exiting `agent`.
    AgentExitsEffectAreaEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` is affected by a pulse generated by this device.
    # Sends the affected `agent`.
    AgentPulsedEvent<public>: listenable(agent) = external {}

    # Signaled when this device generates a pulse.
    CampfirePulseEvent<public>: listenable(tuple()) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Signaled when this device is disabled.
    DisabledEvent<public>: listenable(tuple()) = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when this device is enabled.
    EnabledEvent<public>: listenable(tuple()) = external {}

    # Extinguishes this device.
    Extinguish<public>(Agent: agent): void = external {}

    # Signaled when this device is extinguished by an `agent`.
    # Sends the extinguishing `agent`.
    ExtinguishedEvent<public>: listenable(agent) = external {}

    # Lights this device.
    Light<public>(Agent: agent): void = external {}

    # Signaled when this device is lit by an `agent`.
    # Sends the lighting `agent`.
    LitEvent<public>: listenable(agent) = external {}
  }

  # Used to create a zone that can trigger effects once players enter it. Can be set up to be capturable by a team, to provide a score while held, or to require a specific item as a drop-off.
  capture_area_device<public> := class<concrete><final>(creative_device_base) {
    # Activates the objective pulse for this device.
    ActivateObjectivePulse<public>(): void = external {}

    # Signaled when an `agent` enters this device area.
    # Sends the `agent` that entered this device area.
    AgentEntersEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` exits this device area.
    # Sends the `agent` that exited this device area.
    AgentExitsEvent<public>: listenable(agent) = external {}

    # Allows this device to be captured.
    AllowCapture<public>(): void = external {}

    # Signaled when this device is contested.
    # Sends the `agent` that is contesting this device.
    AreaIsContestedEvent<public>: listenable(agent) = external {}

    # Signaled when this device is scored.
    # Sends the `agent` that scored this device.
    AreaIsScoredEvent<public>: listenable(agent) = external {}

    # Signaled when this device control changes.
    # Sends the `agent` that triggered this device control change.
    ControlChangeEvent<public>: listenable(agent) = external {}

    # Signaled when this device control change starts.
    # Sends the `agent` that is triggering this device control change.
    ControlChangeStartsEvent<public>: listenable(agent) = external {}

    # Deactivates the objective pulse for this device.
    DeactivateObjectivePulse<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Disallows this device from being captured.
    DisallowCapture<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when the first `agent` enters this device area.
    # Sends the `agent` that entered this device area.
    FirstAgentEntersEvent<public>: listenable(agent) = external {}

    # Returns an array of agents that are currently occupying the Capture Area.
    GetAgentsInVolume<public>()<reads>: []agent = external {}

    # Returns the *Capture Height* (in meters) of the capture area.
    GetHeight<public>()<reads>: float = external {}

    # Returns the *Capture Radius* (in meters) of the capture area.
    GetRadius<public>()<reads>: float = external {}

    # Gives control of this device to the capturing `agent`'s team.
    GiveControl<public>(Agent: agent): void = external {}

    # Is true when `Agent` is in the Capture Area.
    IsInArea<public>(Agent: agent)<transacts><decides>: void = external {}

    # Signaled when an item is consumed by this device.
    # Sends the `agent` that provided the item to this device.
    ItemIsConsumedEvent<public>: listenable(agent) = external {}

    # Signaled when an item is delivered to this device.
    # Sends the `agent` that delivered the item to this device.
    ItemIsDeliveredEvent<public>: listenable(agent) = external {}

    # Signaled when the last `agent` exits this device area.
    # Sends the `agent` that exited this device area.
    LastAgentExitsEvent<public>: listenable(agent) = external {}

    # Clears control of this device for all teams.
    Neutralize<public>(): void = external {}

    # Signaled when this device enters the neutralized state.
    # Sends the `agent` that was responsible for neutralizing the area (the player in the area at the time of neutralization, prioritized by the one who has been in the area the longest), if one exists.
    NeutralizeEvent<public>: listenable(?agent) = external {}

    # Resets control of this device for all teams.
    (/Fortnite.com/Devices/capture_area_device:)Reset<public>(): void = external {}

    # Sets the *Capture Height* (in meters) of the capture area.
    SetHeight<public>(Height: float): void = external {}

    # Sets the *Capture Radius* (in meters) of the capture area.
    SetRadius<public>(Radius: float): void = external {}

    # Toggles between `AllowCapture` and `DisallowCapture`.
    ToggleCaptureAllowed<public>(): void = external {}

    # Toggles between `Enable` and `Disable`.
    ToggleEnabled<public>(): void = external {}

    # The current capture progress of the capture area.
    # As a team captures the area, the value will increase from 0.0 to 1.0, with 1.0 representing a fully captured area.
    # If the device supports neutralization or decay, the value will drop back towards 0.0 as it returns to neutral.
    # If the device is disabled, the capture progress is set to 0.0.
    var<private> CaptureProgress<public>: float = external {}
  }

  # Spawns and tracks a single item as a game objective (e.g. flag).
  capture_item_spawner_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when spawned item is captured.
    # Sends the `agent` that captured the item.
    ItemCapturedEvent<public>: listenable(agent) = external {}

    # Signaled when spawned item is dropped.
    # Sends the `agent` that dropped the item.
    ItemDroppedEvent<public>: listenable(agent) = external {}

    # Signaled when spawned item is picked up.
    # Sends the `agent` that picked up the item.
    ItemPickedUpEvent<public>: listenable(agent) = external {}

    # Signaled when spawned item is returned.
    # Sends the `agent` that returned the item.
    ItemReturnedEvent<public>: listenable(agent) = external {}
  }

  # Payload of `device_event_carryable_spawner_agent_impact`.
  carryable_spawner_agent_impact_result<native><public> := struct<epic_internal> {
    # Damage applied by the impact.
    Damage<native><public>: float

    # Whether the impact was a direct result of being thrown (as opposed to an indirect hit from bouncing or rolling).
    ImpactedFromThrow<native><public>: logic

    # The agent responsible for the impact. Either the thrower, or if none exists, the agent who instigated the carryable to spawn.
    Source<native><public>: ?agent

    # Agent impacted by the carryable.
    Target<native><public>: ?agent
  }

  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /Verse.org/Assets }
  # Used to spawn a carryable object into the experience.
  carryable_spawner_device<public> := class<concrete><final>(creative_device_base, enableable) {
    # Signaled when the carryable collides with an agent.
    # Damage applied is based off the collision velocity, as well as the device's *Impact Damage* settings.
    # This event will fire even if the damage applied is 0.
    AgentCollideEvent<public>: listenable(carryable_spawner_agent_impact_result) = external {}

    # Despawn the carryable, if it exists.
    Despawn<public>(): void = external {}

    # Disables this device, preventing it from listening for inputs and sending events.
    # When disabled, the carryable is unspawned, if it exists.
    Disable<override>(): void = external {}

    # Signaled when `agent` drops the carryable.
    # Includes manual drop as well as force drop, which can occur on entering a state that doesn't support carrying, such as elimination.
    DropEvent<public>: listenable(agent) = external {}

    # Enables this device, allowing it to listen for inputs and send events.
    Enable<override>(): void = external {}

    # Explode the carryable, if it exists.
    Explode<public>(): void = external {}

    # Explode the carryable, if it exists.
    # Assigns the provided `agent` as the explosion instigator.
    Explode<public>(Agent: agent): void = external {}

    # Signaled when the carryable explodes.
    # Returns the instigating `agent`, if one exists.
    #  * The `agent` provided to the *Explode* function, or the agent who dealt lethal damage to the carryable.
    #  * Otherwise, the `agent` who most recently carried the item.
    # Returns an array of `agent`s affected by the explosion.
    ExplodeEvent<public>: listenable(tuple(?agent, []agent)) = external {}

    # Forces the carryable to be carried by the provided `player`, teleporting it into their hands.
    # If not in a viable state to carry the item (such as in a vehicle), or if the `player` fails the device's filters, it is ignored.
    ForcePlayerToCarry<public>(Player: player): void = external {}

    # Succeeds if the object is enabled, fails if it is disabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Fails if the carryable does not exist in-world.
    IsSpawned<public>()<reads><decides>: void = external {}

    # Signaled when `agent` picks up the carryable.
    PickUpEvent<public>: listenable(agent) = external {}

    # Signaled when `agent` stops carrying the carryable.
    # This includes dropping, throwing, despawning, or force pickup by another player.
    ReleaseEvent<public>: listenable(agent) = external {}

    # Set the material of the carryable.
    # Index describes which material index on the mesh the material will apply to.
    # This will update immediately if already spawned, and also apply to any carryable spawned from this device in the future.
    SetCarryableMaterial<public>(Material: material, ?Index: int = external {}): void = external {}

    # Set the mesh of the carryable.
    # This will update immediately if already spawned, and also apply to any carryable spawned from this device in the future.
    SetCarryableMesh<public>(Mesh: mesh): void = external {}

    # Spawn the carryable from the device if it doesn't currently exist.
    Spawn<public>(): void = external {}

    # Signaled when the carryable spawns, either by the `Spawn` function, or by timer.
    SpawnEvent<public>: listenable(tuple()) = external {}

    # Signaled when `agent` throws the carryable.
    ThrowEvent<public>: listenable(agent) = external {}

    # Maps to the device option for *Takes Damage*.
    # Whether or not the carryable takes damage / can be destroyed.
    var CanTakeDamage<public>: logic = external {}

    # Maps to the device option for *Explosion Character Damage*.
    # Describes how much damage is done to characters caught in the carryable explosion.
    var ExplosionDamage<public>: float = external {}

    # Maps to the device option for *Explosion Environmental Damage*.
    # Describes how much damage is done to world objects caught in the carryable explosion.
    var ExplosionEnvironmentalDamage<public>: float = external {}

    # Maps to the device option for *Explosion Impulse*.
    # Describes the strength of the knockback impulse applied by the carryable explosion.
    var ExplosionImpulse<public>: float = external {}

    # Maps to the device option for *Explosion Radius*.
    # Describes the radius (in meters) of the carryable explosion.
    var ExplosionRadius<public>: float = external {}

    # Maps to the device option for *Impact Character Damage*.
    # Describes how much damage is done to characters hit by the carryable.
    # This value is scaled by the impact magnitude to calculate the applied damage.
    var ImpactDamage<public>: float = external {}

    # Maps to the device option for *Impact Environmental Damage*.
    # Describes how much damage is done to world objects hit by the carryable.
    # This value is scaled by the impact magnitude to calculate the applied damage.
    var ImpactEnvironmentalDamage<public>: float = external {}

    # Maps to the device option for *Initial Spawn Angle*.
    # The angle (in degrees) of the cone from which the carryable will be randomly tossed when it first spawns.
    var InitialSpawnAngle<public>: float = external {}

    # Maps to the device option for *Initial Spawn Velocity*.
    # The velocity (in meters per second) applied to the carryable when it first spawns.
    var InitialSpawnVelocity<public>: float = external {}

    # Maps to the device option for *Starting Health*.
    # Describes how much health the carryable spawns with.
    var StartingHealth<public>: float = external {}

    # The carryable transform, if the carryable exists in-world.
    var<private> CarryableObjectTransform<public>: ?(/UnrealEngine.com/Temporary/SpatialMath:)transform = external {}

    # The `agent` carrying the carryable, if one exists.
    var<private> CarryingAgent<public>: ?agent = external {}
  }

  # Creates a chair where `Agent`s can sit.
  chair_device<public> := class<concrete><final>(creative_device_base) {
    # Disables the Chair.
    # A disabled Chair cannot be interacted with
    # and any `agent` currently occupying the Chair will be ejected.
    Disable<public>(): void = external {}

    # Prevents any seated `agent` from leaving the Chair manually.
    # While Exit is disabled, call Eject to force them out.
    DisableExit<public>(): void = external {}

    # Ejects any `agent` currently in the chair.
    Eject<public>(): void = external {}

    # Makes `Agent` exit this chair if they are currently in the chair.
    Eject<public>(Agent: agent): void = external {}

    # Enables the Chair.
    # An enabled Chair can be interacted with and occupied
    # by any `agent` that meets the requirements.
    Enable<public>(): void = external {}

    # Allows any seated `agent` to leave the chair manually.
    EnableExit<public>(): void = external {}

    # Signaled when an `agent` stops sitting on the Chair.
    # Sends the standing `Agent`.
    ExitedEvent<public>: listenable(agent) = external {}

    # Returns the `agent` currently occupying the chair.
    GetSeatedAgent<public>(): ?agent = external {}

    # Succeeds if the chair is currently occupied.
    IsOccupied<public>()<transacts><decides>: void = external {}

    # Succeeds if `Agent` is currently in the chair .
    IsSeated<public>(Agent: agent)<transacts><decides>: void = external {}

    # Makes `Agent` sit on this chair if they meet the requirements.
    Seat<public>(Agent: agent): void = external {}

    # Signaled when an `agent` sits on the Chair.
    # Sends the sitting `agent`.
    SeatedEvent<public>: listenable(agent) = external {}
  }

  # Allows players to change their outfit in game!
  changing_booth_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when a `player` enters the changing booth device.
    PlayerEnterEvent<public>: listenable(player) = external {}

    # Signaled when a `player` exits the changing booth device.
    PlayerExitEvent<public>: listenable(player) = external {}
  }

  # Sends an Event for every signal it receives. A simple relay to connect multiple devices together.
  # It can also broadcast an event to the playspace and listen for any other channel devices broadcasting
  # to the playspace.
  channel_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when either `Transmit` is called.
    ReceivedTransmitEvent<public>: listenable(?agent) = external {}

    # Calls `ReceivedTransmitEvent`, optionally with `Agent` as the instigator.
    Transmit<public>(Agent: ?agent): void = external {}
  }

  # Used to configure a single interactive mannequin, that can visualize characters, clothing, and perform emotes.
  character_device<public> := class<concrete>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Hides this device.
    Hide<public>(): void = external {}

    # Signaled when an `agent` interacts with this device.
    # Sends the `agent` that interacted with this device.
    InteractedWithEvent<public>: listenable(agent) = external {}

    # Plays an emote on the character created by this device.
    PlayEmote<public>(): void = external {}

    # Shows this device.
    Show<public>(): void = external {}
  }

  # Used to trigger level sequences that allow coordination of cinematic animation, transformation, and audio tracks.
  cinematic_sequence_device<public> := class<concrete><final>(creative_device_base) {
    # Returns the playback rate of the sequence.
    GetPlayRate<public>()<transacts>: float = external {}

    # Returns the playback position (in frames) of the sequence.
    GetPlaybackFrame<public>()<transacts>: int = external {}

    # Returns the playback position (in time/seconds) of the sequence.
    GetPlaybackTime<public>()<transacts>: float = external {}

    # Go to the end and stop the sequence.
    GoToEndAndStop<public>(): void = external {}

    # Go to the end and stop the sequence. An instigating 'Agent' is required when the device is set to anything except *Everyone*.
    GoToEndAndStop<public>(Agent: agent): void = external {}

    # Pauses the sequence.
    Pause<public>(): void = external {}

    # Pauses the sequence. An instigating 'Agent' is required when the device is set to anything except *Everyone*.
    Pause<public>(Agent: agent): void = external {}

    # Plays the sequence. This will only work when the device is set to *Everyone*
    Play<public>(): void = external {}

    # Plays the sequence. An instigating 'Agent' is required when the device is set to anything except *Everyone*.
    Play<public>(Agent: agent): void = external {}

    # Plays the sequence in reverse. This will only work when the device is set to *Everyone*
    PlayReverse<public>(): void = external {}

    # Plays the sequence in reverse. An instigating 'Agent' is required when the device is set to anything except *Everyone*.
    PlayReverse<public>(Agent: agent): void = external {}

    # Set the playback rate of the sequence.
    SetPlayRate<public>(PlayRate: float): void = external {}

    # Set the playback position (in frames) of the sequence.
    SetPlaybackFrame<public>(PlaybackFrame: int): void = external {}

    # Set the playback position (in time/seconds) of the sequence.
    SetPlaybackTime<public>(PlaybackTime: float): void = external {}

    # Stops the sequence.
    Stop<public>(): void = external {}

    # Stops the sequence. An instigating 'Agent' is required when the device is set to anything except *Everyone*.
    Stop<public>(Agent: agent): void = external {}

    # Signaled when the sequence is stopped.
    StoppedEvent<public>: listenable(tuple()) = external {}

    # Toggles between `Play` and `Stop`.
    TogglePause<public>(): void = external {}

    # Toggles between `Play` and `Stop`. An instigating 'Agent' is required when the device is set to anything except *Everyone*.
    TogglePause<public>(Agent: agent): void = external {}
  }

  # Used together with `class_designer_device` to control how/when created classes can be accessed by `agent`s.
  class_and_team_selector_device<public> := class<concrete><final>(creative_device_base) {
    # Changes the `Agent`'s class.
    ChangeClass<public>(Agent: agent): void = external {}

    # Changes the selecting team.
    ChangeSelectorTeam<public>(Agent: agent): void = external {}

    # Changes the `Agent`'s team.
    ChangeTeam<public>(Agent: agent): void = external {}

    # Changes the `Agent`'s team and class.
    ChangeTeamAndClass<public>(Agent: agent): void = external {}

    # Signaled when an `agent` changes class.
    # Sends the `agent` whose class changed.
    ClassSwitchedEvent<public>: listenable(agent) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when an `agent` changes teams.
    # Sends the `agent` whose team changed.
    TeamSwitchedEvent<public>: listenable(agent) = external {}
  }

  # Used together with `class_and_team_selector_device` to create class based gameplay. Defines custom class attributes and inventory loadouts.
  class_designer_device<public> := class<concrete><final>(creative_device_base) {
    # Returns an array of agents that are currently of *Class* defined by this device.
    GetClassMembers<public>()<reads>: []agent = external {}

    # Is true if `Agent` is on *Class* defined by this device.
    IsOfClass<public>(Agent: agent)<transacts><decides>: void = external {}
  }

  # Used to allow players to select their *Class* from a *Class Selector UI*.
  class_selector_ui_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when an `agent` changes a class.
    # Sends the `agent` that selected a class and the `int` class that the player has changed to.
    ClassChangedEvent<public>: listenable(tuple(agent, int)) = external {}

    # Signaled when an `agent` selects a class.
    # Sends the `agent` that selected a class.
    ClassSelectedEvent<public>: listenable(agent) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Show the *Class Selector UI* to `Agent`.
    Show<public>(Agent: agent): void = external {}

    # Signaled when an `agent` closes the UI.
    # Sends the `agent` that closed the UI.
    UIClosedEvent<public>: listenable(agent) = external {}

    # Signaled when the UI is opened.
    # Sends the `agent` that is responsible for opening the UI.
    UIOpenedEvent<public>: listenable(agent) = external {}
  }

  # Used to place a collectible item into the world.
  collectible_object_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when the collectible item is collected.
    # Sends the `agent` that collected the item.
    CollectedEvent<public>: listenable(agent) = external {}

    # Makes the collectible invisible.
    Hide<public>(): void = external {}

    # Immediately respawns the object for the instigating agent.
    # This will be affected by the option *Consume If Collected By*.
    (/Fortnite.com/Devices/collectible_object_device:)Respawn<public>(Agent: agent): void = external {}

    # Immediately respawns the object for all agents.
    RespawnForAll<public>(): void = external {}

    # Makes the collectible visible.
    Show<public>(): void = external {}
  }

  # Used to create a tile that changes colors when `agent`s interact with it.
  color_changing_tiles_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when this device changes color.
    # Sends the `agent` that interacted with this device.
    ActivatedEvent<public>: listenable(agent) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Hides this device from the world.
    Hide<public>(): void = external {}

    # Resets this device to its initial settings.
    (/Fortnite.com/Devices/color_changing_tiles_device:)Reset<public>(): void = external {}

    # Sets the color of the tile to `Agent`'s team color.
    (/Fortnite.com/Devices/color_changing_tiles_device:)SetTeam<public>(Agent: agent): void = external {}

    # Shows this device in the world.
    Show<public>(): void = external {}
  }

  # Used to create a specialized button which can only be activated when `agent`s are carrying specific items.
  conditional_button_device<public> := class<concrete><final>(creative_device_base) {
    # Activates this device. `Agent` is used as the instigator of the action.
    Activate<public>(Agent: agent): void = external {}

    # Signaled when this device is activated.
    # Sends the `agent` that activated this device.
    ActivatedEvent<public>: listenable(agent) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Returns the time (in seconds) that an interaction with this device will take to complete.
    GetInteractionTime<public>()<transacts>: float = external {}

    # Returns how many items an `Agent` has of the item stored at `KeyItemIndex`.
    GetItemCount<public>(Agent: agent, KeyItemIndex: int): int = external {}

    # Returns the total quantity of a specific key item type that needs to be collected in order to activate the switch.
    GetItemCountRequired<public>(KeyItemIndex: int)<transacts>: int = external {}

    # Returns the score to be awarded for a key item.
    GetItemScore<public>(KeyItemIndex: int)<transacts>: int = external {}

    # Returns the remaining quantity of a specific key item type that needs to be collected in order to activate the switch.
    GetRemainingItemCountRequired<public>(KeyItemIndex: int)<transacts>: int = external {}

    # Returns if the `Agent` has all of the items required to interact with this Device.
    HasAllItems<public>(Agent: agent)<transacts><decides>: void = external {}

    # Returns if the `Agent` is currently holding any of the items stored in the Device.
    IsHoldingItem<public>(Agent: agent)<transacts><decides>: void = external {}

    # Returns if the `Agent` is currently holding the item stored at `KeyItemIndex`.
    IsHoldingItem<public>(Agent: agent, KeyItemIndex: int)<transacts><decides>: void = external {}

    # Signaled when this device fails to activate because `agent` didn't have the required items.
    # Sends the `agent` that attempted to activate the device.
    NotEnoughItemsEvent<public>: listenable(agent) = external {}

    # Resets this device to its original settings.
    (/Fortnite.com/Devices/conditional_button_device:)Reset<public>(): void = external {}

    # Sets the text that appears when `agent`s approach the device. `Text` is limited to `150` characters and will revert back to default if empty.
    SetInteractionText<public>(Text: message): void = external {}

    # Sets the time (in seconds) that an interaction with this device should take to complete.
    SetInteractionTime<public>(Time: float): void = external {}

    # Sets the quantity of a specific key item type that needs to be collected in order to activate the switch.
    # `KeyItemIndex` ranges from `0` to number of key item types - 1.
    SetItemCountRequired<public>(KeyItemIndex: int, Count: int): void = external {}

    # Sets the score to be awarded for a key item. `KeyItemIndex` ranges from `0` to number of key item types - 1.
    SetItemScore<public>(KeyItemIndex: int, Score: int): void = external {}

    # Toggles the conditional button state. `Agent` is used as the instigator of the action.
    Toggle<public>(Agent: agent): void = external {}
  }

  # Used to set and trigger conversations made via the Conversation Graph. The conversation triggered is assigned to the device.
  conversation_device<public> := class<concrete><final>(creative_device_base, enableable) {
    # Check if an `agent` can initiate a conversation.
    CanInitiateConversation<public>(Agent: agent)<transacts><decides>: void = external {}

    # Signalled when a conversation has ended early by EndConversation or EndConversationForAll.
    CancelEvent<public>: listenable(agent) = external {}

    # Disables this device.
    # A disabled conversation device will not listen for inputs and trigger conversations.
    Disable<override>(): void = external {}

    # Enables this device.
    # An enabled conversation device will listen for inputs and trigger conversations.
    Enable<override>(): void = external {}

    # Ends the assigned conversation with the `agent`.
    EndConversation<public>(Agent: agent): void = external {}

    # Ends all active conversations with this device.
    EndConversationForAll<public>(): void = external {}

    # Signalled when a conversation has ended.
    EndEvent<public>: listenable(agent) = external {}

    # Returns the count of currently-active conversations with this device.
    GetActiveConversationsCount<public>()<transacts>: int = external {}

    # Hide the conversation UI for an 'agent'. Responses cannot be selected while the UI is hidden. This will work with Box and Custom UI.
    HideConversation<public>(Agent: agent): void = external {}

    # Begins the assigned conversation with the `agent`.
    # The conversation will not start if the device or the `agent` are otherwise incapable of having a conversation.
    InitiateConversation<public>(Agent: agent): void = external {}

    # Check if an `agent` is in an active conversation.
    IsAgentInConversation<public>(Agent: agent)<transacts><decides>: void = external {}

    # Check if the device is enabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Signaled when a choice node tied to this event is selected by an `agent`.
    # Sends the `agent` that triggered the event, and `EventNumber` is the number specified in the Conversation Event node.
    OnConversationEvent<public>: listenable(tuple(agent, int)) = external {}

    # Show the conversation UI for an 'agent'. This will work with Box and Custom UI.
    ShowConversation<public>(Agent: agent): void = external {}

    # Sets the number of conversations allowed at once with the device.
    # This will not make any conversations exit if there are more current conversations than allowed after this call.
    var AllowedConversationCount<public>: int = external {}

    # The constant rate that characters are revealed over the course of a second when a Speech node activates.
    # The exact characters in the respective speech node are revealed and do not combine into glyphs.
    # When the value is changed, active conversations are not updated. Works with the Box and Custom UI.
    # The value of CharactersPerSecond is the default value used when initiating a conversation.
    # CharactersPerSecond will be clamped between 0.25 and 100.0. If set to false all the characters will reveal instantly.
    var CharactersPerSecond<public>: ?float = external {}

    # The range that the Indicator Bubble will be seen at. Clamps to range[0, 25].
    var IndicatorBubbleRange<public>: float = external {}

    # Whether the device will show conversation text in worldspace when using the Radial UI type.
    var ShowConversationTextInWorldSpace<public>: logic = external {}

    # whether the device will show the Indicator Bubble when nearby.
    var ShowIndicatorBubble<public>: logic = external {}

    # Whether the device will show the Speaker when nearby.
    var ShowNameWhenNearby<public>: logic = external {}

    # The Speaker Name of the device. When the value is changed, active conversations are not updated.
    # The value of SpeakerName is the default value used when initiating a conversation.
    var SpeakerName<public>: message = external {}
  }

  # Used to place a crash pad that can bounce players and protect them from fall damage.
  crash_pad_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when an `agent` is launched by this device.
    # Sends the launched `agent`.
    LaunchedEvent<public>: listenable(agent) = external {}
  }

  # Inherit from this to create a custom creative device. Inherited classes will appear in the UEFN content browser the next time Verse compiles. Instances of your derived `creative_device` can then be placed in the island by dragging them from the content browser into the scene.
  creative_device<native><public> := class<concrete>(creative_object_interface) {
    # Gets the global transform of this device.
    GetGlobalTransform<public>()<transacts>: (/Verse.org/SpatialMath:)transform = external {}

    # Returns the transform of the `creative_device` with units in cm.
    GetTransform<override>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)transform = external {}

    # Hides this device in the world.
    Hide<native><public>()<transacts>: void

    # Moves the `creative_device` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_device` it will be stopped and put into the `AnimationNotSet` state.
    MoveTo<public>(
      Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      OverTime: float
    )<suspends>: move_to_result = external {}

    # Moves the `creative_device` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_device` it will be stopped and put into the `AnimationNotSet` state.
    MoveTo<public>(
      Transform: (/UnrealEngine.com/Temporary/SpatialMath:)transform,
      OverTime: float
    )<suspends>: move_to_result = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    # Moves the `creative_device` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_device` it will be stopped and put into the `AnimationNotSet` state.
    MoveTo<public>(Transform: (/Verse.org/SpatialMath:)transform, OverTime: float)<suspends>: move_to_result = external {}

    # Override to add custom logic when the game experience begins.
    OnBegin<native_callable><public>()<suspends>: void = external {}

    # Override to add custom logic when the game experience ends. Any coroutines spawned inside `OnEnd` may never execute.
    OnEnd<native_callable><public>(): void = external {}

    # Sets the global transform of this device.
    SetGlobalTransform<public>(NewGlobalTransform: (/Verse.org/SpatialMath:)transform)<transacts>: void = external {}

    # Shows this device in the world.
    Show<native><public>()<transacts>: void

    # Teleports the `creative_device` to the specified `Position` and `Rotation`.
    TeleportTo<public>(
      Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<transacts><decides>: void = external {}

    # Teleports the `creative_device` to the specified location defined by `Transform`, also applies rotation and scale accordingly.
    TeleportTo<public>(Transform: (/UnrealEngine.com/Temporary/SpatialMath:)transform)<transacts><decides>: void = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    # Teleports the `creative_device` to the specified location defined by `Transform`, also applies rotation and scale accordingly.
    TeleportTo<public>(Transform: (/Verse.org/SpatialMath:)transform)<transacts><decides>: void = external {}
  }

  # Internal asset for representing creative devices.
  creative_device_asset<native><public> := class<computes><final><epic_internal> {}

  # Base class for creative_device.
  creative_device_base<native><public> := class<abstract><epic_internal>(creative_object) {}

  # Base class for creative devices and props.
  creative_object<native><public> := class<epic_internal>(creative_object_interface) {
    # Gets the global transform of this object.
    GetGlobalTransform<public>()<transacts>: (/Verse.org/SpatialMath:)transform = external {}

    # Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay.
    # Otherwise a runtime error will result.
    GetTransform<override>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)transform = external {}

    # Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state.
    MoveTo<public>(
      Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      OverTime: float
    )<suspends>: move_to_result = external {}

    # Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state.
    MoveTo<public>(
      Transform: (/UnrealEngine.com/Temporary/SpatialMath:)transform,
      OverTime: float
    )<suspends>: move_to_result = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    # Moves the `creative_device` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_device` it will be stopped and put into the `AnimationNotSet` state.
    MoveTo<public>(Transform: (/Verse.org/SpatialMath:)transform, OverTime: float)<suspends>: move_to_result = external {}

    # Sets the global transform of this object.
    SetGlobalTransform<public>(NewGlobalTransform: (/Verse.org/SpatialMath:)transform)<transacts>: void = external {}

    # Teleports the `creative_object` to the specified `Position` and `Rotation`.
    TeleportTo<public>(
      Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<transacts><decides>: void = external {}

    # Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly.
    TeleportTo<public>(Transform: (/UnrealEngine.com/Temporary/SpatialMath:)transform)<transacts><decides>: void = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    # Teleports the `creative_device` to the specified location defined by `Transform`, also applies rotation and scale accordingly.
    TeleportTo<public>(Transform: (/Verse.org/SpatialMath:)transform)<transacts><decides>: void = external {}
  }

  creative_object_interface<native><public> := interface<epic_internal>(positional) {}

  # A Fortnite prop that has been placed or spawned in the island.
  creative_prop<native><public> := class<concrete><final>(creative_object, invalidatable) {
    # Apply an angular impulse to a ‘creative_prop’ with units in Newton*meter*seconds. Will not do anything if physics is disabled.
    ApplyAngularImpulse<native><public>(AngularImpulse: (/Verse.org/SpatialMath:)vector3): void

    # Apply a force to a ‘creative_prop’ with units in Newtons. Will not do anything if physics is disabled.
    ApplyForce<native><public>(Force: (/Verse.org/SpatialMath:)vector3): void

    # Apply a linear impulse to a ‘creative_prop’ with units in Newton*seconds. Will not do anything if physics is disabled.
    ApplyLinearImpulse<native><public>(LinearImpulse: (/Verse.org/SpatialMath:)vector3): void

    # Apply a torque to a ‘creative_prop’ with units in Newton*meters. Will not do anything if physics is disabled.
    ApplyTorque<native><public>(Torque: (/Verse.org/SpatialMath:)vector3): void

    # Destroys the `creative_prop` and remove it from the island.
    Dispose<native><override>(): void

    # Returns a ‘creative_prop’s angular velocity in radians/second.
    GetAngularVelocity<native><public>()<reads>: (/Verse.org/SpatialMath:)vector3

    # Get whether a ‘creative_prop’ is dynamic (affected by physics functions).
    GetDynamic<native><public>()<reads>: logic

    # Returns a ‘creative_prop’s linear velocity in meters/second.
    GetLinearVelocity<native><public>()<reads>: (/Verse.org/SpatialMath:)vector3

    # Returns a ‘creative_prop’s mass in kilograms.
    GetMass<native><public>()<reads>: float

    # Hides the `creative_prop` in the world and disable collisions.
    Hide<native><public>()<transacts>: void

    # Succeeds if this object has been disposed of either via `Dispose()` or through an external system.
    IsDisposed<native><final><public>()<transacts><decides>: void

    # Succeeds if this object has not been disposed of either via `Dispose()` or through an external system.
    IsValid<native><override>()<transacts><decides>: void

    # Set a ‘creative_prop’s angular velocity in radians/seconds. Will not do anything if physics is disabled.
    SetAngularVelocity<native><public>(AngularVelocity: (/Verse.org/SpatialMath:)vector3): void

    # Set whether a ‘creative_prop’ is dynamic (affected by physics functions). Will not do anything if physics is disabled OR the prop does not have a FortPhysicsComponent.
    SetDynamic<native><public>(Dynamic: logic): void

    # Set a ‘creative_prop’s linear velocity in meters/second. Will not do anything if physics is disabled.
    SetLinearVelocity<native><public>(LinearVelocity: (/Verse.org/SpatialMath:)vector3): void

    # Changes the Material of the Mesh used by this instance. Optionally can specify which Mesh element index to apply the material to, otherwise defaults to the 0 (default) Mesh element
    SetMaterial<native><public>(Material: material, ?Index: int = external {})<transacts>: void

    # Changes the Mesh used by this instance.
    SetMesh<native><public>(Mesh: mesh)<transacts>: void

    # Shows the `creative_prop` in the world and enable collisions.
    Show<native><public>()<transacts>: void

    # Enable/disable whether this prop can be damaged. If disabled, the creative prop will not take damage from attacks.
    var CanBeDamaged<public>: logic = external {}
  }

  # Asset used to spawn `creative_prop` instances.
  creative_prop_asset<native><public> := class<computes><concrete><final><epic_internal> {}

  using { /Verse.org/SpatialMath }
  # Used to customize one creature type at a time. Place multiple `creature_manager_device`s for each type of creature on your island.
  # Changing properties will respect the `Affected Creatures` property of the
  # device. If `Affected Creatures` is set to `New Pawns Only`, only new spawns will
  # get the changed property values. If set to `New and Existing Pawns`, all creatures
  # spawned from this device and new ones will have the new properties.
  creature_manager_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when a creature of the selected *Creature Type* is eliminated.
    # Sends the `agent` that eliminated the creature.
    MatchingCreatureTypeEliminatedEvent<public>: listenable(agent) = external {}

    # Determines if the selected Creature type can be knocked back by weapon impacts.
    var AllowWeaponKnockback<public>: logic = external {}

    # If a value is given, the `DamageToEnvironment` value of the creature is overridden.
    # If an override is not specified, the default `DamageToEnvironment` of the creature is used.
    # This value is clamped between 0 and 500.
    var DamageToEnvironment<public>: ?float = external {}

    # If a value is given, the `DamageToPlayer` value of the creature is overridden.
    # If an override is not specified, the default `DamageToPlayer` of the creature is used.
    # This value is clamped between 0 and 500.
    var DamageToPlayer<public>: ?float = external {}

    # If set, the health value of the creature is overridden.
    # If an override is not specified, the default Health of the creature is used.
    # This value is clamped between 1 and 10000.
    var MaxHealth<public>: ?int = external {}

    # If a value is given, the `SpeedMultiplier` value is applied to the default speed of the creature.
    # If an override is not specified, the creature moves at its default speed.
    # This value is clamped between 0.0 and 2.0.
    var MovementSpeed<public>: ?float = external {}

    # If a value is given, the `Score` value of the creature is overridden.
    # If an override is not specified, the default `Score` of the creature is used.
    # This value is clamped between 0 and 100.
    var Score<public>: ?int = external {}
  }

  # Used to spawn a creature at a specified location.
  creature_placer_device<public> := class<concrete><final>(creative_device_base) {
    # Despawns the creature.
    Despawn<public>(): void = external {}

    # Signaled when the creature is eliminated.
    #  * Sends the `agent` that eliminated the creature.
    #  * Sends `false` if the creature was eliminated by something other than an `agent` (e.g. a vehicle).
    EliminatedEvent<public>: listenable(?agent) = external {}

    # Spawns the creature.
    Spawn<public>(): void = external {}

    # Spawn a creature at the given position. When Rotation is not provided, it will default to the Device’s rotation.
    # Returns the agent spawned or false if the device has reached its maximum spawn count.
    # This function is ‘<suspends>’ because it takes time to load the creature before it can be returned.
    SpawnAt<public>(
      Position: (/Verse.org/SpatialMath:)vector3,
      ?Rotation: ?(/Verse.org/SpatialMath:)rotation = external {}
    )<suspends>: ?agent = external {}

    # Signaled when a creature is spawned.
    # Sends the `agent` creature who was spawned.
    SpawnedEvent<public>: listenable(agent) = external {}
  }

  # Used to spawn one or more waves of creatures of customizable types at selected time intervals.
  creature_spawner_device<public> := class<concrete><final>(creative_device_base) {
    # Destroys this device.
    DestroySpawner<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Eliminates all creatures spawned by this device.
    EliminateCreatures<public>(): void = external {}

    # Signaled when a creature is eliminated.
    #  `Source` is the `agent` that has eliminated the creature. If the creature was eliminated by a non-agent then `Source` is 'false'.
    #  `Target` is the creature that was eliminated.
    EliminatedEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Returns the spawn limit of the device.
    GetSpawnLimit<public>()<transacts>: int = external {}

    # Spawn a creature at the given position. When Rotation is not provided, it will default to the Device’s rotation.
    # Returns the agent spawned or false if the device has reached its maximum spawn count.
    # This function is ‘<suspends>’ because it takes time to load the creature before it can be returned.
    SpawnAt<public>(
      Position: (/Verse.org/SpatialMath:)vector3,
      ?Rotation: ?(/Verse.org/SpatialMath:)rotation = external {}
    )<suspends>: ?agent = external {}

    # Signaled when a creature is spawned.
    # Sends the `agent` creature who was spawned.
    SpawnedEvent<public>: listenable(agent) = external {}
  }

  # Spawns a crowd to cheer you on.
  crowd_volume_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Used to create a light which can have its color and brightness manipulated in response to in-game events.
  customizable_light_device<public> := class<concrete><final>(creative_device_base) {
    # Dims the light by *Dimming Amount*.
    DimLight<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Resets the light to its initial state.
    (/Fortnite.com/Devices/customizable_light_device:)Reset<public>(): void = external {}

    # Toggles between `TurnOn` and `TurnOff`.
    Toggle<public>(): void = external {}

    # Turns off the light.
    TurnOff<public>(): void = external {}

    # Turns on the light.
    TurnOn<public>(): void = external {}

    # Brightens the light by *Dimming Amount*.
    UndimLight<public>(): void = external {}
  }

  # Used to amplify an `agent`'s damage temporarily. This applies to any weapon the `agent` is using at the time of the powerup.
  damage_amplifier_powerup_device<public> := class<concrete><final>(powerup_device) {
    # Returns the current *Magnitude* for the powerup.
    # For the Damage Amplifier Powerup, this is the damage multiplier.
    GetMagnitude<public>()<transacts>: float = external {}

    # Sets the *Magnitude* for this powerup, clamped to the Min and Max defined in the device.
    # Will not apply to any currently applied effects.
    # For the Damage Amplifier Powerup, this is the damage multiplier.
    SetMagnitude<public>(Magnitude: float): void = external {}
  }

  # Used to specify an area volume which can damage `agent`s, vehicles, and creatures.
  damage_volume_device<public> := class<concrete><final>(effect_volume_device) {
    # Signaled when an `agent` enters the volume.
    # Sends the `agent` entering the volume.
    AgentEntersEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` exits the volume.
    # Sends the `agent` exiting the volume.
    AgentExitsEvent<public>: listenable(agent) = external {}

    # Returns an array of agents that are currently occupying the volume.
    GetAgentsInVolume<public>()<reads>: []agent = external {}

    # Returns the damage to be applied each tick within the volume.
    GetDamage<public>()<transacts>: int = external {}

    # Is true when `Agent` is in the zone.
    IsInVolume<public>(Agent: agent)<transacts><decides>: void = external {}

    # Signaled when a `creative_prop` enters the device volume.
    PropEnterEvent<public>: listenable(creative_prop) = external {}

    # Signaled when a `creative_prop` exits the device volume.
    PropExitEvent<public>: listenable(creative_prop) = external {}

    # Sets the damage to be applied each tick within the volume. `Damage` is clamped between `1` and `500`.
    SetDamage<public>(Damage: int): void = external {}

    # Updates *Selected Class* to `Agent`'s class.
    UpdateSelectedClass<public>(Agent: agent): void = external {}

    # Updates *Selected Team* to `Agent`'s team.
    UpdateSelectedTeam<public>(Agent: agent): void = external {}
  }

  # Used to project a hologram of a character performing dance emotes.
  dance_mannequin_device<public> := class<concrete><final>(creative_device_base) {
    # Activates the hologram using *Default Preset* options.
    ActivateDefaultPreset<public>(): void = external {}

    # Activates the hologram using *Preset 2* options.
    ActivatePreset2<public>(): void = external {}

    # Activates the hologram using *Preset 3* options.
    ActivatePreset3<public>(): void = external {}

    # Activates the hologram using `Agent`'s skin and emotes.
    ActivateSkinAndEmoteCapture<public>(Agent: agent): void = external {}

    # Deactivates the hologram.
    DeactivateSkinAndEmoteCapture<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Payload of `device_event_ai_interaction`.
  device_ai_interaction_result<native><public> := struct<epic_internal> {
    # Optional agent that triggered the interaction
    Source<native><public>: ?agent

    # Optional agent targeted by `Source`.
    Target<native><public>: ?agent
  }

  # Used to apply a cosmetic disguise to the player.
  # The disguise to apply is defined on the device, as are the conditions for when the disguise breaks.
  disguise_device<public> := class<concrete><final>(creative_device_base, enableable) {
    # Signaled when any disguise is successfully applied to `player`.
    # Includes disguises applied by any disguise device, or by a disguise kit.
    ApplyAnyDisguiseEvent<public>: listenable(player) = external {}

    # Applies the disguise to the provided `player`.
    # If the provided `player` does not pass the device's filter settings, or if another disguise is already present and the device's *Stomp Existing Disguise* option is set to false, the disguise will not be applied.
    ApplyDisguise<public>(Player: player): void = external {}

    # Signaled when a disguise from this device is successfully applied to `player`.
    ApplyDisguiseEvent<public>: listenable(player) = external {}

    # Signaled when any applied disguise on `player` is broken.
    # Includes disguises applied by any disguise device, or by a disguise kit.
    # The second optional `agent` describes who broke the disguise (the damage source if broken by damage or elimination).
    # The conditions triggering a disguise to break are set in the device's user options.
    BreakAnyDisguiseEvent<public>: listenable(tuple(player, ?agent)) = external {}

    # Signaled when a disguise applied by this device on `player` is broken.
    # The second optional `agent` describes who broke the disguise (the damage source if broken by damage or elimination).
    # The conditions triggering a disguise to break are set in the device's user options.
    BreakDisguiseEvent<public>: listenable(tuple(player, ?agent)) = external {}

    # Disables this device, preventing it from listening to inputs.
    # Disguises applied by this device are not removed when the device is disabled.
    Disable<override>(): void = external {}

    # Enables this device, allowing it to listen for inputs.
    Enable<override>(): void = external {}

    # Succeeds if the provided `player` has any disguise applied.
    # Includes disguises applied by any disguise device, or by a disguise kit.
    IsAnyDisguiseApplied<public>(Player: player)<transacts><decides>: void = external {}

    # Succeeds if the provided `player` has a disguise applied from this device.
    IsDisguiseApplied<public>(Player: player)<transacts><decides>: void = external {}

    # Succeeds if the object is enabled, fails if it is disabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Removes any applied disguise from `player`.
    # Includes disguises applied by any disguise device, or by a disguise kit.
    RemoveAnyDisguise<public>(Player: player): void = external {}

    # Signaled when any applied disguise on `player` is removed.
    # Includes disguises applied by any disguise device, or by a disguise kit.
    # Removal can occur from calling the *Remove Disguise* function, or from getting replaced by another disguise.
    # This event will not trigger if the disguise is broken.
    RemoveAnyDisguiseEvent<public>: listenable(player) = external {}

    # Removes the disguise applied by this device, if it exists, from the provided `player`.
    RemoveDisguise<public>(Player: player): void = external {}

    # Signaled when a disguise applied by this device on `player` is removed.
    # Removal can occur from calling the *Remove Disguise* function, or from getting replaced by another disguise.
    # This event will not trigger if the disguise is broken.
    RemoveDisguiseEvent<public>: listenable(player) = external {}

    # Maps to the user option for *Should Apply Disguise on Spawn*.
    # If this is true, the device will apply a disguise to the player as soon as they spawn, so long as they pass the device's filter options.
    var ShouldApplyDisguiseOnPlayerSpawn<public>: logic = external {}
  }

  # Used to customize (or prevent) the 'down but not out' player state between 'healthy' and 'removed from game'.
  down_but_not_out_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when an `agent` is set to the `down but not out` player state.
    # Sends the `agent` that was downed.
    AgentDownedEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` in the `down but not out` player state is dropped.
    # Sends the `agent` that was dropped.
    AgentDroppedEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` in the `down but not out` player state is picked up.
    # Sends the `agent` that was picked up.
    AgentPickedUpEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` in the `down but not out` player state is revived.
    # Sends the `agent` that was revived.
    AgentRevivedEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` in the `down but not out` player state is thrown.
    # Sends the `agent` that was thrown.
    AgentThrownEvent<public>: listenable(agent) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Sets the `Agent` to the `down but not out` player state.
    Down<public>(Agent: agent): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Sets the `Agent` to the `healthy` player state if they are in the `down but not out` player state.
    Revive<public>(Agent: agent): void = external {}

    # Signaled when an `agent` is the aggressor of a shake down.
    # Sends the `agent` that is the aggressor.
    ShakeDownEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` is the victim of a shake down.
    # Sends the `agent` that is the victim.
    ShakenDownEvent<public>: listenable(agent) = external {}
  }

  # Use to create a sprite that players can trade in a weapon for a random legendary weapon or a custom item list.
  earth_sprite_device<public> := class<concrete><final>(creative_device_base, enableable) {
    # Disable the device.
    Disable<override>(): void = external {}

    # Disable the device’s ability to grant items. Can still interact and consume weapons.
    DisableItemGranting<public>(): void = external {}

    # Prevents the `agent` from trading.
    DisableTradingForPlayer<public>(Agent: agent): void = external {}

    # Enable the device, and resets all trade counts the Sprite is tracking.
    Enable<override>(): void = external {}

    # Enable the device’s ability to grant items.
    EnableItemGranting<public>(): void = external {}

    # Allows a `agent` to trade, and will reset the `agent`'s trade count for this Sprite.
    EnableTradingForPlayer<public>(Agent: agent): void = external {}

    # Triggers when the grant timer has completed.
    # Sends the triggering `agent`.
    GrantTimerCompletedEvent<public>: listenable(?agent) = external {}

    # Makes the Earth Sprite invisible.
    Hide<public>(): void = external {}

    # Succeeds if the device is enabled, fails if it's disabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Makes the Earth Sprite visible.
    Show<public>(): void = external {}

    # Triggers when a player gives the Earth Sprite a weapon.
    # Sends the triggering `agent`.
    WeaponConsumedEvent<public>: listenable(agent) = external {}
  }

  # Base class for types of volumes with special gameplay properties.
  effect_volume_device<public> := class<abstract><epic_internal>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Used to send custom messages to the elimination feed.
  elimination_feed_device<public> := class<concrete><final>(creative_device_base) {
    # Activates this device.
    # Requires *Activated by Team / Class* be set to `All`.
    Activate<public>(): void = external {}

    # Activates this device. `Agent` is used as the instigator of the action.
    Activate<public>(Agent: agent): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Used to spawn items when an `agent` or specified target is eliminated.
  elimination_manager_device<public> := class<concrete><final>(base_item_spawner_device) {
    # Signaled when a qualifying elimination occurs.
    # Sends the eliminated `agent`.
    EliminatedEvent<public>: listenable(agent) = external {}

    # Signaled when a qualifying elimination occurs.
    # Sends the eliminator `agent`. If the eliminator is a non-agent then `false` is returned.
    EliminationEvent<public>: listenable(?agent) = external {}
  }

  # Used to configure rules that can end the current round or game.
  end_game_device<public> := class<concrete><final>(creative_device_base) {
    # Ends the round/game. Uses `Agent`'s team to determine if the round/game ends when *Activating Team* is enabled.
    Activate<public>(Agent: agent): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Used to customize high level properties of the game mode.
  experience_settings_device<public> := class<concrete><final>(creative_device_base) {}

  # Hazard which deals damage in a radius around it when destroyed or triggered.
  explosive_device<public> := class<concrete><final>(creative_device_base) {
    # Triggers this device to explode. Passes `Agent` as the instigator of the resulting `ExplodedEvent`.
    Explode<public>(Agent: agent): void = external {}

    # Signaled when this device explodes.
    # Sends the `agent` that caused the explosion.
    ExplodedEvent<public>: listenable(agent) = external {}

    # Hides this device from the world.
    Hide<public>(): void = external {}

    # Resets this device.
    (/Fortnite.com/Devices/explosive_device:)Reset<public>(): void = external {}

    # Shows this device in the world.
    Show<public>(): void = external {}
  }

  # Used to specify an area which allows (or prevents) various objects, terrain, or buildings from being set on fire.
  fire_volume_device<public> := class<concrete><final>(effect_volume_device) {
    # Extinguishes objects inside this device area.
    Extinguish<public>(): void = external {}

    # Ignites objects inside this device area.
    Ignite<public>(): void = external {}
  }

  # Used to spawn fireflies that can be collected by `agent`s.
  firefly_spawner_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when a firefly is collected.
    # Sends the `agent` collected the firefly.
    OnFirefliesCollected<public>: listenable(agent) = external {}

    # Resets respawn count.
    ResetRespawnCount<public>(): void = external {}

    # Spawns new fireflies. The previous fireflies will be destroyed before a new fireflies spawn.
    (/Fortnite.com/Devices/firefly_spawner_device:)Respawn<public>(): void = external {}
  }

  # Used to add fishing mechanics to experiences, such as:
  #  * Fishing competitions between players.
  #  * Collecting fish as a resource.
  #  * Fishing minigames with their own rewards.
  fishing_zone_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when an `agent` catches a fish.
    # Sends the `agent` that caught the fish.
    CaughtEvent<public>: listenable(agent) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Signaled when all items have been caught and removed.
    # Sends the `agent` that caught the last fish.
    EmptyEvent<public>: listenable(agent) = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Resets the number of available uses for this device back to *Uses Allowed*.
    (/Fortnite.com/Devices/fishing_zone_device:)Reset<public>(): void = external {}

    # Returns all caught and removed items to the inventory. This only works when *Pool Type* is set to *Device Inventory*.
    Restock<public>(): void = external {}
  }

  # Used to provide fuel sources for vehicles. Can also be used to deal considerable damage to `agent`s and the environment when destroyed.
  fuel_pump_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Grants fuel to `Agent`.
    Empty<public>(Agent: agent): void = external {}

    # Signaled when the fuel pump is emptied.
    # Sends the `agent` that emptied the fuel pump.
    EmptyEvent<public>: listenable(agent) = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Resets fuel stock to *Fuel Capacity* value.
    (/Fortnite.com/Devices/fuel_pump_device:)Reset<public>(): void = external {}
  }

  # Used to update the camera’s current viewpoint and rotation based on current camera mode.
  gameplay_camera_device<public> := class<abstract><epic_internal>(creative_device_base) {
    # Adds the camera to the `Agent`’s camera stack and pushes it to be the active camera.
    AddTo<public>(Agent: agent): void = external {}

    # Adds the camera to all `Agent`s camera stacks and pushes it to be the active camera.
    AddToAll<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Removes the camera from the `Agent`’s camera stack and pops from being the active camera replacing it with the next one in the stack.
    RemoveFrom<public>(Agent: agent): void = external {}

    # Removes the camera from all `Agent`s camera stacks and pops from being the active camera replacing it with the next one in the stack.
    RemoveFromAll<public>(): void = external {}
  }

  # Used to update the camera's viewpoint from the perspective of the player character.
  gameplay_camera_first_person_device<public> := class<concrete><final>(gameplay_camera_device) {}

  # Used to update the camera’s current viewpoint and rotation based on a fixed angle.
  gameplay_camera_fixed_angle_device<public> := class<concrete><final>(gameplay_camera_device) {}

  # Used to update the camera’s current viewpoint and rotation based on a fixed point.
  gameplay_camera_fixed_point_device<public> := class<concrete><final>(gameplay_camera_device) {}

  # Used to update the camera's viewpoint to follow the target and be rotated manually.
  gameplay_camera_orbit_device<public> := class<concrete><final>(gameplay_camera_device) {}

  # Used to update the gameplay controls scheme based on current control mode.
  gameplay_controls_device<public> := class<abstract><epic_internal>(creative_device_base) {
    # Adds the gameplay control to the `Player`’s gameplay controls stack and pushes it to be the active control.
    AddTo<public>(Agent: agent): void = external {}

    # Adds the gameplay control to all `Agent`s gameplay controls stack and pushes it to be the active control.
    AddToAll<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Removes the gameplay control from the `Agent`’s gameplay controls stack and pops from being the active control replacing it with the next one in the stack.
    RemoveFrom<public>(Agent: agent): void = external {}

    # Removes the gameplay control from all `Agent`s gameplay controls stack and pops from being the active control replacing it with the next one in the stack.
    RemoveFromAll<public>(): void = external {}
  }

  # Used to adapt the controls to side scroller functionality
  gameplay_controls_side_scroller_device<public> := class<concrete><final>(gameplay_controls_device) {}

  # Used to adapt the controls to the camera perspective
  gameplay_controls_third_person_device<public> := class<concrete><final>(gameplay_controls_device) {}

  # Used to let `agent`s slide on any surface with accompanying visual and audio effects.
  grind_powerup_device<public> := class<concrete><final>(powerup_device) {}

  # Used to create customizable Grind Rails.
  grind_rail_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device, preventing players from grinding on the rail.
    Disable<public>(): void = external {}

    # Enables this device, letting players grind on the rail.
    Enable<public>(): void = external {}

    # Signaled when an `agent` starts grinding on this `grind_rail_device`.
    EndedGrindingEvent<public>: listenable(agent) = external {}

    # Hides the track. Players can still grind on the track if it is enabled.
    Hide<public>(): void = external {}

    # Sets the color of the Grind Rail.
    SetRailColor<public>(Color: color): void = external {}

    # Make this track visible.
    Show<public>(): void = external {}

    # Signaled when an `agent` starts grinding on this `grind_rail_device`.
    StartedGrindingEvent<public>: listenable(agent) = external {}
  }

  # Used with `guard_spawner_device.Accuracy` to define how accurate the NPC is when it fires at targets.
  guard_spawner_accuracy<public> := enum<open> {
    # Fairly accurate, hitting targets consistently.
    High

    # Not accurate, missing most shots fired.
    Low

    # Somewhat accurate, hitting targets occasionally.
    Moderate

    # Very accurate, hitting most shots fired.
    VeryHigh
  }

  # Used to spawn guards that can patrol and attack other `agent`s.
  # Changing properties will only affect newly spawned guards.
  guard_spawner_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when a guard has identified an opponent.
    # `Source` is the guard who is aware.
    # `Target` is the agent who alerted the guard.
    AlertedEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Signaled when guard is damaged.
    # `Source` is the `agent` that damaged the guard. If the guard was damaged by a non-agent then `false` is returned.
    # `Target` is the guard that was damaged.
    DamagedEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Despawns guards.
    Despawn<public>(): void = external {}

    # Despawns guards. `Instigator` will be considered as the eliminator of those guards.
    Despawn<public>(Instigator: agent): void = external {}

    # Disables this device. Guards will despawn if *Despawn Guards When Disabled* is set.
    Disable<public>(): void = external {}

    # Dismisses all hired guards that were recruited by `Instigator`.
    DismissAgentHiredGuards<public>(Instigator: agent): void = external {}

    # Dismisses all hired guards.
    DismissAllHiredGuards<public>(): void = external {}

    # Signaled when a guard is dismissed by a player.
    # `Source` is the `agent` who dismissed the guard.
    # `Target` is the guard that was dismissed.
    DismissedEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Signaled when a guard is eliminated.
    # `Source` is the `agent` that eliminated the guard. If the guard was eliminated by a non-agent then `Source` is 'false'.
    # `Target` is the guard that was eliminated.
    EliminatedEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Signaled when a guard eliminates an agent.
    # `Source` is the guard that eliminated the agent.
    # `Target` is the agent that was eliminated.
    EliminatingEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Enables this device. Guards will start to spawn.
    Enable<public>(): void = external {}

    # Forces guards to attack `Target`, bypassing perception checks.
    # 'ForgetTime' ranges from 0.0 to 600.0 (in seconds, default is 600.0), it is the time after which the target will be ignored if not found.
    # 'ForgetDistance' ranges from 0.0 to 100000.0 (in centimeters, default is 100000.0), it is the distance at which the target will be ignored if not found.
    ForceAttackTarget<public>(
      Target: agent,
      ?ForgetTime: float = external {},
      ?ForgetDistance: float = external {}
    ): void = external {}

    # Get all agents created by this device.
    GetAgents<public>()<transacts>: []agent = external {}

    # Gets the name of the guard in the hire the guard conversation and elimination feed.
    GetName<public>(): string = external {}

    # Returns the spawn limit of the device.
    GetSpawnLimit<public>()<transacts>: int = external {}

    # Hires guards to `Instigator`'s team.
    Hire<public>(Instigator: agent): void = external {}

    # Signaled when a guard is hired by a player.
    # `Source` is the `agent` who hired the guard.
    # `Target` is the guard that was hired.
    HiredEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Resets the spawn count allowing spawning of a new batch of guards.
    (/Fortnite.com/Devices/guard_spawner_device:)Reset<public>(): void = external {}

    # Allows guards to be hired.
    SetGuardsHireable<public>(): void = external {}

    # Prevents guards from being hired.
    SetGuardsNotHireable<public>(): void = external {}

    # Sets the name of the guard in the hire the guard conversation and elimination feed.
    SetName<public>(InText: message): void = external {}

    # Tries to spawn a guard.
    Spawn<public>(): void = external {}

    # Tries to spawn a guard. If *Auto Hire When Spawned* is set to *Triggering Player* the guard will be hired by `Instigator`.
    Spawn<public>(Instigator: agent): void = external {}

    # Spawn a guard at the given position. When Rotation is not provided, it will default to the Device`s rotation.
    # Returns the agent spawned or false if the device has reached its maximum spawn count.
    # This function is `<suspends>` because it takes time to load the NPC before it can be returned.
    SpawnAt<public>(
      Position: (/Verse.org/SpatialMath:)vector3,
      ?Rotation: ?(/Verse.org/SpatialMath:)rotation = external {}
    )<suspends>: ?agent = external {}

    # Signaled when a guard is spawned.
    # Sends the `agent` guard who was spawned.
    SpawnedEvent<public>: listenable(agent) = external {}

    # Signaled when a guard becomes suspicious.
    # Sends the `agent` guard who is suspicious.
    SuspiciousEvent<public>: listenable(agent) = external {}

    # Signaled when a guard has lost track of a target.
    # `Source` is the guard that lost track of a target.
    # `Target` is the `agent` no longer targeted by the guard.
    TargetLostEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Signaled when a guard becomes unaware.
    # Sends the `agent` guard who is unaware.
    UnawareEvent<public>: listenable(agent) = external {}

    # Determines how the guard uses its `VisibilityRange` as defined by `guard_spawner_visibility_range_restriction`.
    var Accuracy<public>: guard_spawner_accuracy = external {}

    # If true, agents can hire the guard.
    var CanBeHired<public>: logic = external {}

    # Determines if the guard despawns when it is dismissed.
    var DespawnOnDismissal<public>: logic = external {}

    # Determines if the guard displays its alertness level over its head.
    var DisplayAlertness<public>: logic = external {}

    # Determines the starting health of the guard.
    # This value is clamped between 1 and 10000.
    var InitialHealth<public>: float = external {}

    # Determines the starting shield of the guard.
    # This value is clamped between 1 and 10000.
    var InitialShield<public>: float = external {}

    # Whether the guard can receive damage.
    var Invincible<public>: logic = external {}

    # The health value of the guard.
    # This value is clamped between 1 and 10000.
    var MaxHealth<public>: float = external {}

    # Determines the maximum shield value of the guard.
    # This value is clamped between 1 and 10000.
    var MaxShield<public>: float = external {}

    # Determines if the guard obeys ping commands from its hired player.
    var ObeyCommands<public>: logic = external {}

    # Distance in centimeters from its spawn position from which the guard will peacefully roam.
    # This value is clamped between 200.0 and 25000.0.
    var PatrolRange<public>: float = external {}

    # Determines if the guard is healed when it is hired.
    var RestoreHealthAndShieldOnHire<public>: logic = external {}

    # If true, displays the guard’s health to players.
    var ShowHealthBar<public>: logic = external {}

    # Determines the range, in centimeters, from which the guard will respond.
    # This value is clamped between 0.0 and 25000.0.
    var VisibilityRange<public>: float = external {}

    # Determines how the guard uses its `VisibilityRange` as defined by `guard_spawner_visibility_range_restriction`.
    var VisibilityRangeRestriction<public>: guard_spawner_visibility_range_restriction = external {}
  }

  # Used with `guard_spawner_device.VisibilityRangeRestriction` to define how the guard uses `guard_spawner_device.VisibilityRange`
  guard_spawner_visibility_range_restriction<public> := enum<open> {
    # The NPC uses its `VisibilityRange` both when it is unaware and when it has a target.
    Always

    # The NPC only uses its `VisibilityRange` when it does not have a target. Otherwise, the guard has an infinite range.
    OnlyWhenUnaware
  }

  # An interface for shared functionality between different spire devices
  has_spire_functionality<public> := interface<epic_internal>(enableable) {
    # Triggers when the Spire becomes activated from players entering the `Activation Distance`
    ActivateEvent<public>: listenable(?agent)

    # Triggers when the Spire becomes deactivated, either from players leaving the `Activation Distance`
    DeactivateEvent<public>: listenable(tuple())

    # Sets the Spire’s health to zero, destroying it.
    Destroy<public>(): void

    # Triggers when the Spire is destroyed from damage or events
    DestroyEvent<public>: listenable(?agent)

    # If this Spire is currently activated.
    #  * Succeeds if activated. Fails if deactivated
    #  * An activated will react to enemies and take damage
    #  * Becomes activated from being enabled and players entering the `Activation Distance`
    IsActivated<public>()<transacts><decides>: void

    # Succeeds if this Spire’s health has reached 0. Fails otherwise
    IsDestroyed<public>()<transacts><decides>: void

    # Succeeds if this Spire is in a spawned state. Fails if the Spire is destroyed or has not spawned.
    IsSpawned<public>()<transacts><decides>: void

    # Resets the Spire to its initial state.
    (/Fortnite.com/Devices/has_spire_functionality:)Reset<public>(): void

    # Spawns the Spire, causing it to become visible and enabling collision
    #  *  Does nothing if the Spire is already spawned or destroyed
    Spawn<public>(): void

    # Determines the distance where approaching players activate the Spire.
    var ActivationDistance<public>: float

    # The Spire's current health. Clamped between 0 and `MaxHealth`.
    #  * Setting this value does nothing if the Spire is destroyed.
    var Health<public>: float

    # Determines if a Spire-specific icon should be displayed on the map while the Spire is spawned
    var ShowMapIcon<public>: logic

    # The maximum health of this Spire.
    var<private> MaxHealth<public>: float
  }

  # Use to create a cactus with healing fruits that can be burst to heal nearby players.
  healing_cactus_device<public> := class<concrete><final>(creative_device_base) {
    # Burst the plant if the device is enabled, passing in the triggering `agent`.
    # If there is no triggering `agent`, players will only be healed if `Heal Targets` is set to `Everyone`.
    Burst<public>(): void = external {}

    # Burst the plant if the device is enabled, passing in the triggering `agent`.
    # If there is no triggering `agent`, players will only be healed if `Heal Targets` is set to `Everyone`.
    Burst<public>(Agent: agent): void = external {}

    # Triggers when the plant bursts, passing in the triggering `agent`.
    BurstEvent<public>: listenable(?agent) = external {}

    # Disables the device to prevent interaction and growth.
    Disable<public>(): void = external {}

    # Enables the device to allow interaction and let it grow.
    Enable<public>(): void = external {}

    # Grows the plant if the device is enabled. If `Infinite Regrowths` is `false`, this is limited by `Maximum Regrowths`.
    # If someone is too close, the plant won't grow until they move away.
    Grow<public>(): void = external {}

    # Triggers when the plant grows.
    GrowEvent<public>: listenable(tuple()) = external {}
  }

  # Used to regenerate an `agent`'s health and/or shields.
  health_powerup_device<public> := class<concrete><final>(powerup_device) {
    # Returns the current *Magnitude* for the powerup.
    # For the Health Powerup, this is the amount of health or shield that the powerup will add or remove,
    GetMagnitude<public>()<transacts>: float = external {}

    # Sets the *Magnitude* for this powerup, clamped to the Min and Max defined in the device.
    # Will not apply to any currently applied effects.
    # For the Health Powerup, this is the amount of health or shield that the powerup will add or remove,
    SetMagnitude<public>(Magnitude: float): void = external {}
  }

  # An indestructible chest that can be locked and unlocked.
  hero_chest_device<public> := class<concrete><final>(creative_device_base, enableable) {
    # Disable the device. While disabled, the chest can't be interacted with.
    Disable<override>(): void = external {}

    # Enable the device, allowing interaction.
    Enable<override>(): void = external {}

    # Returns the chest rank as a `string`.
    GetRankAsString<public>(): string = external {}

    # Succeeds if the device is enabled, fails if it's disabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Succeeds if the chest is locked for `Agent`.
    IsLocked<public>(Agent: agent)<transacts><decides>: void = external {}

    # Succeeds if the chest's default locked state is Locked.
    #  * The default locked state is initialized by the *Start Locked* user option and is overridden by *LockForAll* and *UnlockForAll*.
    IsLockedForAll<public>()<transacts><decides>: void = external {}

    # Succeeds if the chest is currently open, fails if it's closed.
    IsOpen<public>()<transacts><decides>: void = external {}

    # Lock the chest for `Agent`. Has no effect if the chest is open.
    Lock<public>(Agent: agent): void = external {}

    # Lock the chest for everyone, and set this chest's default state to Locked.
    LockForAll<public>(): void = external {}

    # Open the chest.
    Open<public>(): void = external {}

    # Triggers whenever the chest is opened, returning the `agent` who opened it if applicable.
    OpenEvent<public>: listenable(?agent) = external {}

    # Close the chest, refresh its loot, and set the chest to its default locked state for everyone.
    #  * The default locked state is initialized by the *Start Locked* user option and is overridden by *LockForAll* and *UnlockForAll*.
    (/Fortnite.com/Devices/hero_chest_device:)Reset<public>(): void = external {}

    # Unlock the chest for `Agent`. Has no effect if the chest is open.
    Unlock<public>(Agent: agent): void = external {}

    # Unlock the chest for everyone, and set this chest's default state to Unlocked.
    UnlockForAll<public>(): void = external {}

    # Determines the hologram that appears above the chest, as well as the loot the chest contains.
    #  * From low to high, the ranks are C, B, A, and S.
    var ChestRank<public>: hero_chest_rank = external {}

    # Descriptive text shown when interacting while the chest is locked.
    #  * By default, this says 'You cannot open this right now.'.
    var LockedDescription<public>: message = external {}

    # Main text shown when interacting while the chest is locked.
    #  * The default is 'Rank X Chest' where X is the value of *Rank*.
    var LockedLabel<public>: message = external {}

    # Additional text shown when interacting while the chest is locked.
    #  * By default, this says 'Unable to open'.
    var LockedSublabel<public>: message = external {}

    # Whether to show the rank hologram while the chest is closed.
    var ShowHologram<public>: logic = external {}
  }

  hero_chest_rank<public> := enum<open> {
    A

    B

    C

    S
  }

  # Used to apply a temporary hero transformation to a player.
  # The transformation to apply is specified on the device, as are the conditions for when the transformation will end.
  hero_device<public> := class<concrete><final>(creative_device_base) {
    # Applies the hero transformation to the provided `player`.
    # If the provided `player` does not pass the device's filter settings, or if another transformation is already present and the device's *Stomp Existing Transformation* option is set to false, the transformation will not be applied.
    ApplyTransformation<public>(Player: player): void = external {}

    # Signaled when a hero transformation from this device is successfully applied to `player`.
    ApplyTransformationEvent<public>: listenable(player) = external {}

    # Succeeds if the provided `player` has a hero transformation applied from this device.
    IsTransformationApplied<public>(Player: player)<transacts><decides>: void = external {}

    # Removes the transformations applied by this device, if it exists, from all players
    RemoveAllMyTransformations<public>(): void = external {}

    # Removes any applied hero transformations from `player`.
    # Includes hero transformations applied by any hero device instance.
    RemoveAnyTransformation<public>(Player: player): void = external {}

    # Removes the transformation applied by this device, if it exists, from the provided `player`.
    RemoveTransformation<public>(Player: player): void = external {}

    # Signaled when a transformation applied by this device on `player` is removed.
    # Removal can occur from calling the *Remove Transformation* function, or from getting replaced by another transformation.
    # This event will not trigger if the transformation is ended due to outlined conditions or elimination.
    RemoveTransformationEvent<public>: listenable(player) = external {}

    # Signaled when a transformation applied by this device on `player` ends.
    # The second optional `agent` describes who ended the transformation if ended by elimination.
    # The conditions outlining when a transformation will end are set in the device's user options.
    TransformedPlayerEliminateEvent<public>: listenable(tuple(player, ?agent)) = external {}
  }

  # The hiding prop device can be used to give players a place to hide, or to allow players a special way to commence a Hidden Travel to another Hiding prop.
  hiding_prop_device<public> := class<concrete><final>(creative_device_base, enableable) {
    # Signaled when a player hides in this Hiding prop.
    BeginPlayerHideEvent<public>: listenable(player) = external {}

    # Disable this device.
    #  When this device is disabled, it cannot be interacted with.
    Disable<override>(): void = external {}

    # Eject all players hiding in this hiding prop.
    #  Returns an array of all players that were ejected.
    EjectAllHiddenPlayers<public>(): []player = external {}

    # Eject a specific player from this hiding prop.
    EjectHiddenPlayer<public>(Player: player)<transacts><decides>: void = external {}

    # Enable this device.
    #  When this device is enabled, it can be interacted with.
    Enable<override>(): void = external {}

    # Signaled when a player stops hiding in this hiding prop.
    EndPlayerHideEvent<public>: listenable(player) = external {}

    # Hides all players within the provided meters of a hiding prop.
    #  Returns an array of all players that were hidden.
    #  This event will not allow more players than is specified in 'MaxNumberOfOccupants' to be hidden in this device.
    HideNearbyPlayers<public>(DistanceInMeters: float): []player = external {}

    # Succeeds if the object is enabled, fails if it's disabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Signaled when a hidden travel completes to another hiding prop.
    PlayerHiddenTravelEvent<public>: listenable(tuple(player, hiding_prop_device)) = external {}

    # This value maps to the 'Attempt No Repeat Destinations' user option.
    #  If this is set to On, the prop will avoid sending a player to the previous hiding prop twice in a row, unless there is no other hiding prop available.
    #  Modifying this value will take effect the next time a player attempts a hidden travel.
    #  Leaving this value unset means that this hiding_prop_device will not be able to initiate hidden travel.
    var AttemptNoRepeatDestinations<public>: logic = external {}

    # This value maps to the 'Block Hide Time' user option.
    #  When a player leaves the prop, this determines the amount of time another player must wait before they can hide in the prop.
    #  Modifying this value will not affect any player who is currently blocked from hiding, but will affect all players who eject from the hiding prop after it has been modified.
    var BlockHideTime<public>: float = external {}

    # This value controls whether or not Hidden Travel is enabled or disabled
    #  Modifying this value will take effect the next time a player attempts a hidden travel.
    var EnableHiddenTravel<public>: logic = external {}

    # This value maps to the 'Hidden Travel Group' user option.
    #  To make use of the hidden travel feature, you must assign this hiding prop to a Hidden Travel Group.
    #  Modifying this value will take effect the next time a player attempts a hidden travel.
    #  Leaving this value unset will make it so other hiding_prop_device are ineligible to travel to this one.
    var HiddenTravelGroup<public>: ?int = external {}

    # This value maps to the 'Hidden Travel Target Group' user option.
    #  Determines which group of hiding props can be targeted as a hidden travel destination.
    #  You can set this to the same value as the Hidden Travel Group option, or if you have multiple groups of hiding props you can target a different group.
    #  Modifying this value will take effect the next time a player attempts a hidden travel.
    #  Leaving this value unset means that this hiding_prop_device will not be able to cause a Hidden Travel when players hide inside of it.
    var HiddenTravelTargetGroup<public>: ?int = external {}

    # This value maps to the 'Max Hiding Time' user option.
    #  Sets a maximum amount of time a player can hide in the prop before being ejected.
    #  Setting this value to False will disable any limit to how long a player can hide.
    #  Modifying this value will instantly take effect, if any players hiding are now exceeding the Max Hiding time, they will be immediately ejected.
    var MaxHideTime<public>: ?float = external {}

    # This value maps to the 'Max Number Of Occupants' user option.
    #  Determines how many players can hide in this prop at one time.
    #  Modifying this value will not eject any players who are currently hiding, but will otherwise take effect immediately.
    var MaxNumberOfOccupants<public>: int = external {}

    # This value maps to the 'Should Wobble While Hiding' user option.
    #  Modifying this value will take effect the next time a player hides inside of this device.
    #  By default, the prop alerts other players with sound and animation that a player is hiding in the prop. Set this to Off to disable these effects.
    var ShouldWobbleWhileHiding<public>: logic = external {}
  }

  # A strange organic object that may have something or someone inside of it.
  hive_stash_device<public> := class<concrete><final>(creative_device_base, enableable, healthful) {
    # Clear the link between the hive stash and a spawner device.
    ClearSpawnerLink<public>(): void = external {}

    # Disable the device, preventing players from interacting with it. Changes to health and state, such as those caused by damage, can still be applied.
    Disable<override>(): void = external {}

    # Enable the device, allowing players to interact with it.
    Enable<override>(): void = external {}

    # Get the device's current health.
    GetHealth<override>()<transacts>: float = external {}

    # Get the device's current maximum health.
    GetMaxHealth<override>()<transacts>: float = external {}

    # Succeeds if the device currently has a linked spawner, fails otherwise.
    HasLinkedSpawner<public>()<transacts><decides>: void = external {}

    # Succeeds if the device is enabled, fails if it's disabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Succeeds if the hive stash is currently open, fails otherwise.
    IsOpen<public>()<transacts><decides>: void = external {}

    # Open the hive stash. If a spawner is linked, trigger it and rescue the resulting `agent` from the hive stash.
    #  * When the `agent` is rescued, if *ShouldPlayRescuedAnimation* is `true`, they will play a short animation to get off the hive stash.
    Open<public>(): void = external {}

    # Triggers whenever the hive stash is opened, returning the instigating `agent` if applicable.
    OpenEvent<public>: listenable(?agent) = external {}

    # Teleport `Agent` to the hive stash. If *ShouldPlayRescuedAnimation* is `true`, they will play a short animation to get off the hive stash.
    #  * If the hive stash is closed, it will burst open first, ignoring a linked spawner. This will not clear a linked spawner.
    #  * Has no effect if `Agent` cannot be teleported for any reason, such as not being in the game anymore.
    RescueAgent<public>(Agent: agent): void = external {}

    # Triggers when the rescue animation ends.
    #  * Returns the rescued `agent`.
    RescueAnimationEndEvent<public>: listenable(agent) = external {}

    # Triggers whenever an `agent` is rescued, either by the hive stash opening with a linked spawner, or by calling *RescueAgent* while the hive stash is closed.
    #  * Returns the rescued `agent`.
    RescueEvent<public>: listenable(agent) = external {}

    # Reset the hive stash. This closes it, sets it to full health, and sets *ShouldPlayRescuedAnimation*, *CanBeDamaged*, *CanDropItems*, *InteractTextOverride*, and *HiveStashStyle* to their initial values.
    #  * This can also clear the link to a spawner depending on *ShouldKeepLinkOnReset*.
    #  * The hive stash will not reset if the rescue animation is currently playing.
    (/Fortnite.com/Devices/hive_stash_device:)Reset<public>(): void = external {}

    # Set the device's current health.
    SetHealth<override>(Health: float)<transacts>: void = external {}

    # Link the hive stash to `GuardSpawner`. This overrides the hive stash's existing link if one exists.
    #  * If the hive stash opens with a linked spawner, trigger the spawner and rescue the resulting `agent` from the hive stash.
    #  * The rescued `agent` respects its spawner's events, functions, spawn count, and spawn limits.
    SetLinkedSpawner<public>(GuardSpawner: guard_spawner_device): void = external {}

    # Link the hive stash to `NPCSpawner`. This overrides the hive stash's existing link if one exists.
    #  * If the hive stash opens with a linked spawner, trigger the spawner and rescue the resulting `agent` from the hive stash.
    #  * The rescued `agent` respects its spawner's events, functions, spawn count, and spawn limits.
    SetLinkedSpawner<public>(NPCSpawner: npc_spawner_device): void = external {}

    # If `Agent` was spawned by a `guard_spawner_device` or `npc_spawner_device`, link the hive stash to that spawner. This overrides the hive stash's existing link if one exists.
    #  * Fails if `Agent` is not from a `guard_spawner_device` or `npc_spawner_device`, or if `Agent` was already eliminated.
    #  * If the hive stash opens with a linked spawner, trigger the spawner and rescue the resulting `agent` from the hive stash.
    #  * The rescued `agent` respects its spawner's events, functions, spawn count, and spawn limits.
    SetLinkedSpawnerFromAgent<public>(Agent: agent)<transacts><decides>: void = external {}

    # Set the device's current maximum health.
    SetMaxHealth<override>(MaxHealth: float)<transacts>: void = external {}

    # Whether the hive stash can be damaged.
    #  * `true` by default.
    var CanBeDamaged<public>: logic = external {}

    # Whether the hive stash drops items when opened. This can happen in addition to an `agent` being rescued.
    #  * `true` by default.
    var CanDropItems<public>: logic = external {}

    # Determines what players can see inside the hive stash, as well as its interaction text. This does not affect what happens when it opens.
    #  * `Empty` shows nothing and says `Break Open`.
    #  * `Loot` shows a chest and says `Break Open`.
    #  * `Trapped` shows a floating character and says `Rescue`.
    var HiveStashStyle<public>: hive_stash_style = external {}

    # If set, this overrides the text shown when interacting while the hive stash is closed.
    var InteractTextOverride<public>: message = external {}

    # Whether to keep or clear a spawner link when *Reset* is called. Links can always be cleared with *ClearSpawnerLink*.
    #  * `true` by default.
    var ShouldKeepLinkOnReset<public>: logic = external {}

    # Whether an `agent` spawned from registered data or teleported by *FreeAgent* plays a short animation to get them off the hive stash.
    #  * The animation may not work properly on skeletons other than the average player skeleton.
    #  * `true` by default.
    var ShouldPlayRescuedAnimation<public>: logic = external {}
  }

  hive_stash_style<public> := enum<open> {
    Empty

    Loot

    Trapped
  }

  # Used to create a holographic screen that displays a clock or other curated images.
  holoscreen_device<public> := class<concrete><final>(creative_device_base) {}

  # Used to show or hide parts of the HUD for players or teams. Use this with other devices such as the `hud_message_device`, `map_indicator_device`, and `billboard_device` to control exactly how much information players can see during a game, as well as how and when they see that information.
  hud_controller_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Resets the *Affected Class* option to its starting value.
    ResetAffectedClass<public>(): void = external {}

    # Resets the *Affected Team* option to its starting value.
    ResetAffectedTeam<public>(): void = external {}

    # Sets the *Affected Class* option to `Agent`'s class.
    UpdateAffectedClass<public>(Agent: agent): void = external {}

    # Sets the *Affected Team* option to `Agent`'s team.
    UpdateAffectedTeam<public>(Agent: agent): void = external {}
  }

  # Used to show custom HUD messages to one or more `agent`s.
  hud_message_device<public> := class<concrete><final>(creative_device_base) {
    # Clears all queued *Messages* from all players that are affected by this HUD Message Device.
    ClearAllMessages<public>(): void = external {}

    # Called when all queued *Messages* from all players that are affected by this HUD Message Device have been cleared.
    ClearAllMessagesEvent<public>: listenable(agent) = external {}

    # Returns the time (in seconds) for which the HUD message will be displayed. `0.0` means the message is displayed persistently.
    GetDisplayTime<public>()<transacts>: float = external {}

    # Hides the HUD message.
    Hide<public>(): void = external {}

    @available { MinUploadedAtFNVersion := 3100 }
    # Hides the currently set HUD *Message* on `Agent`s screen.
    # Use this when the device is setup to target specific `agent`s.
    Hide<public>(Agent: agent): void = external {}

    # Called when a *Message* has been Hidden on-screen. Returns an `Agent` if it was Hidden from a specified `Agent`'s screen.
    HideMessageEvent<public>: listenable(agent) = external {}

    # Sets the time (in seconds) the HUD message will be displayed. `0.0` will display the HUD message persistently.
    SetDisplayTime<public>(Time: float): void = external {}

    # Sets the *Message* to be displayed when the HUD message is activated. `Text` is clamped to 150 characters.
    SetText<public>(Text: message): void = external {}

    # Shows the currently set *Message* HUD message on screen. Will replace any previously active message.
    Show<public>(): void = external {}

    # Shows the currently set HUD *Message* on `Agent`s screen. Will replace any previously active message.
    # Use this when the device is setup to target specific `agent`s.
    Show<public>(Agent: agent): void = external {}

    # Displays a Custom message to a specific *Agent* that you define.Setting *DisplayTime* to `0.0` will display the HUD message persistently.If not defined, or less than `0.0` the message will show for the time set on the device.
    Show<public>(Agent: agent, Message: message, ?DisplayTime: float = external {}): void = external {}

    # Displays a Custom message that you define for all PlayersSetting *DisplayTime* to `0.0` will display the HUD message persistently.If not defined, or less than `0.0` the message will show for the time set on the device.
    Show<public>(Message: message, ?DisplayTime: float = external {}): void = external {}

    # Called when a *Message* has been Shown on-screen. Returns an `Agent` if it was Shown on a specified `Agent`'s screen.
    ShowMessageEvent<public>: listenable(agent) = external {}
  }

  # Used to listen for the player activating or releasing certain inputs.
  # The input is defined by the *Input* option.
  # Players can configure the key for the input in the Creative Input Actions section of the Keyboard Settings.
  input_trigger_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    # A disabled Input Trigger will not listen for inputs
    # and will never show on the HUD.
    Disable<public>(): void = external {}

    # Enables this device.
    # An Input Trigger will listen for inputs from players that meet the device requirements.
    Enable<public>(): void = external {}

    # Succeeds if `Agent` is currently holding the input.
    IsHeld<public>(Agent: agent)<transacts><decides>: void = external {}

    # Signaled when the tracked input is pressed by an `agent`.
    # Sends the `agent` that pressed the input.
    PressedEvent<public>: listenable(agent) = external {}

    # Adds `Agent` to the registered player list.
    # *Registered Player Behavior* determines whether registered players meet the device requirements.
    Register<public>(Agent: agent): void = external {}

    # Signaled when the tracked input is released by an `agent`.
    # Sends the `agent` that released the input.
    # Sends the `float` duration that the input was held.
    ReleasedEvent<public>: listenable(tuple(agent, float)) = external {}

    # Removes `Agent` from the registered player list.
    # *Registered Player Behavior* determines whether registered players meet the device requirements.
    Unregister<public>(Agent: agent): void = external {}

    # Clears the list of registered players.
    # *Registered Player Behavior* determines whether registered players meet the device requirements.
    UnregisterAll<public>(): void = external {}
  }

  # Used to grant items to `agent`s. Items can either be dropped at the `agent`'s location or added directly to their inventory.
  item_granter_device<public> := class<concrete><final>(creative_device_base) {
    # Clears saved data for `Agent`, preventing them from receiving items while offline. This only works when *Grant While Offline* is set to *Yes*.
    ClearSaveData<public>(Agent: agent): void = external {}

    # Cycles to the next item. If *Grant on Cycle* is set `Agent` will be granted the item.
    CycleToNextItem<public>(Agent: agent): void = external {}

    # Cycles to the previous item. If *Grant on Cycle* is set `Agent` will be granted the item.
    CycleToPreviousItem<public>(Agent: agent): void = external {}

    # Cycles to a random item. If *Grant on Cycle* is set `Agent` will be granted the item.
    CycleToRandomItem<public>(Agent: agent): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Returns the number of items this Item Granter will award for the item at the specified `Index`.
    # This will return 0 if `Index` is invalid.
    # If *Cycle Behavior* is *Stop*, `Index` is clamped to the number of items in the Item Granter.
    #  If *Cycle Behavior* is *Wrap*, `Index` is modulo'd to the number of items in the Item Granter.
    GetItemGrantCountAtIndex<public>(Index: int)<transacts>: int = external {}

    # Returns the current Item Index that this device will grant when activated.
    GetItemIndex<public>()<transacts>: int = external {}

    # Grants an item to `Agent`.
    GrantItem<public>(Agent: agent): void = external {}

    @available { MinUploadedAtFNVersion := 3100 }
    # Grants an item at a specific `ItemIndex` to an `Agent`.
    #  `Index` should be between `0` and the available item count - 1.
    #  If Value is out of bounds, which item is granted is determined by *Cycle Behavior*.
    GrantItemIndex<public>(Agent: agent, ItemIndex: int): void = external {}

    @available { MinUploadedAtFNVersion := 3100 }
    # Grants an item at a specific `ItemIndex` to all players.
    #  Only functions when *Receiving Players* is set to *All* or *Team Index*.
    #  `Index` should be between `0` and the available item count - 1.
    #  If Value is out of bounds, which item is granted is determined by *Cycle Behavior*.
    GrantItemIndex<public>(ItemIndex: int): void = external {}

    # Grants an item without requiring an agent reference.
    #  This only works when *Receiving Players* is set to *All* or *Team Index*.
    GrantItemToAll<public>(): void = external {}

    # Signaled when an item is granted to an `agent`.
    # Sends the `agent` that was granted the item, as well as the number of items granted.
    GrantItemWithCountEvent<public>: listenable(tuple(agent, int)) = external {}

    # Signaled when an item is granted to an `agent`.
    # Sends the `agent` that was granted the item.
    ItemGrantedEvent<public>: listenable(agent) = external {}

    # Restocks this device back to its starting inventory count.
    RestockItems<public>(): void = external {}

    # Sets the number of items this Item Granter will award for the item at the specified `ItemIndex`.
    # `Count` must be greater than 0.
    # If *Cycle Behavior* is *Stop*, `ItemIndex` is clamped to the number of items in the Item Granter.
    #  If *Cycle Behavior* is *Wrap*, `ItemIndex` is modulo'd to the number of items in the Item Granter.
    SetItemGrantCountAtIndex<public>(ItemIndex: int, Count: int): void = external {}

    # Sets the next item to be granted.
    #  * `Index` should be between `0` and the available item count - 1.
    #  * Calling `SetNextItem` with an invalid index will do nothing.
    SetNextItem<public>(Index: int): void = external {}

    # Gets or sets the default number of items that will be awarded for all items in the Item Granter that have not been overwritten.
    # `Count` must be greater than 0.
    var DefaultItemCount<public>: int = external {}
  }

  # Allows pickup items to be placed in the world..
  item_placer_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Used to cause `agent`s to drop or lose items from their inventory. For example, if an `agent` is *Down But Not Out*, they could drop items from their inventory, and other `agent`s could then pick up those items.
  item_remover_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Remove items from `Agent`s inventory. The items that are removed can be configured using *Affected Items*.
    Remove<public>(Agent: agent): void = external {}
  }

  # Allows the item shop to be opened when activated
  item_shop_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Used to configuration and spawn items that players can pick up and use.
  item_spawner_device<public> := class<concrete><final>(base_item_spawner_device) {
    # Cycles device to next configured item.
    CycleToNextItem<public>(): void = external {}

    # Returns device *Respawn Item on Timer* option (see `SetTimeBetweenSpawns`)
    GetEnableRespawnTimer<public>()<transacts>: logic = external {}

    # Returns the *Time Between Spawns* (in seconds) after an item is collected before the next is spawned, if this device has *Respawn Item on Timer* enabled (see `SetEnableRespawnTimer`)
    GetTimeBetweenSpawns<public>()<transacts>: float = external {}

    # Sets device *Respawn Item on Timer* option (see `SetTimeBetweenSpawns`)
    SetEnableRespawnTimer<public>((local:)Respawn: logic): void = external {}

    # Sets the *Time Between Spawns* (in seconds) after an item is collected before the next is spawned, if this device has *Respawn Item on Timer* enabled (see `SetEnableRespawnTimer`)
    SetTimeBetweenSpawns<public>(Time: float): void = external {}

    # Spawns the current item.
    SpawnItem<public>(): void = external {}
  }

  # Used to customize the state and accessibility of doors. `lock_device` only works with assets that have a door attached.
  lock_device<public> := class<concrete><final>(creative_device_base) {
    # Closes the door. `Agent` is the instigator of the action.
    Close<public>(Agent: agent): void = external {}

    # Locks the door. `Agent` is the instigator of the action.
    Lock<public>(Agent: agent): void = external {}

    # Opens the door. `Agent` is the instigator of the action.
    Open<public>(Agent: agent): void = external {}

    # Toggles between `Lock` and `Unlock`. `Agent` is the instigator of the action.
    ToggleLocked<public>(Agent: agent): void = external {}

    # Toggles between `Open` and `Close`. `Agent` is the instigator of the action.
    ToggleOpened<public>(Agent: agent): void = external {}

    # Unlocks the door. `Agent` is the instigator of the action.
    Unlock<public>(Agent: agent): void = external {}
  }

  # Used to control the behavior of the map & minimap.
  # Activation for a given `agent` can occur automatically via the device's *Activate Automatically* user option, by the `agent` entering and exiting the device's volume if using the *Activate on Trigger* user option, or via events from other devices or verse.
  # When more than one map controller is activated for a given `agent`, the one with the highest *Map Priority* user option applies.
  map_controller_device<public> := class<concrete><final>(creative_device_base) {
    # Adds the map controller to all `agent`s in the experience.
    # If multiple map controllers are active for an `agent`, the one with the highest *Map Priority* is used.
    Activate<public>(): void = external {}

    # Adds the map controller to the provided `Agent`'s map controller stack.
    # If multiple map controllers are active for an `agent`, the one with the highest *Map Priority* is used.
    Activate<public>(Agent: agent): void = external {}

    # Removes the map controller from all `agent`s in the experience.
    # The next highest priority active map controller will be used, or if none exists, the default behavior will be restored.
    Deactivate<public>(): void = external {}

    # Removes the map controller from the provided `Agent`'s map controller stack.
    # The next highest priority active map controller will be used, or if none exists, the default behavior will be restored.
    Deactivate<public>(Agent: agent): void = external {}

    # Disables the device.
    # Disabling the device will deactivate it for all `agents` in the experience, turn off the trigger functionality, and prevent it from responding to events.
    Disable<public>(): void = external {}

    # Enables the device.
    # Enabling the device will allow it to be activated, both by incoming events, and by trigger if using *Activate on Trigger*.
    Enable<public>(): void = external {}

    # Returns the *Capture Box Size* (in meters).
    GetCaptureBoxSize<public>()<transacts>: float = external {}

    # Sets the *Capture Box Size* (in meters).
    # *Capture Box Size* refers to the length and width of the area used for both the map capture image as well as the activation trigger.
    # Value is clamped between `25.0` and `2500.0` meters.
    SetCaptureBoxSize<public>(Size: float): void = external {}
  }

  # Used to create custom points of interest and markers on the minimap and overview map.
  map_indicator_device<public> := class<concrete><final>(creative_device_base) {
    # Activates an objective pulse at `Agent`'s location pointing toward this device.
    ActivateObjectivePulse<public>(Agent: agent): void = external {}

    # Deactivates the objective pulse at `Agent`'s location.
    DeactivateObjectivePulse<public>(Agent: agent): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Used to take players to different islands and to link experiences together.
  matchmaking_portal_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Results for `MoveTo`.
  move_to_result<public> := enum {
    # The destination has been reached.
    DestinationReached

    # The destination will not be reached. See debug log in UEFN for more info.
    WillNotReachDestination
  }

  # Used to temporarily modify the speed of `agent`s and vehicles.
  movement_modulator_device<public> := class<concrete><final>(creative_device_base) {
    # Activates this device's movement effect on `Agent`.
    Activate<public>(Agent: agent): void = external {}

    # Signaled when this device is activated by an `agent`.
    # Sends the `agent` that activated this device.
    ActivationEvent<public>: listenable(agent) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Used to specify a zone where custom gameplay effects can be applied (e.g. gravity, no build, no weapons).
  mutator_zone_device<public> := class<concrete><final>(effect_volume_device) {
    # Signaled when an `agent` in this zone begins emoting. This will not signal if the `agent` is on the *Safe Team* or if *Affects Players* is disabled.
    # Sends the `agent` that started emoting.
    AgentBeginsEmotingEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` in this zone ends emoting. This will not signal if the `agent` is on the *Safe Team* or if *Affects Players* is disabled.
    # Sends the `agent` that stopped emoting.
    AgentEndsEmotingEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` enters this zone.
    # Sends the `agent` entering this zone.
    AgentEntersEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` exits this zone.
    # Sends the `agent` exiting this zone.
    AgentExitsEvent<public>: listenable(agent) = external {}

    # Returns an array of agents that are currently occupying the volume.
    GetAgentsInVolume<public>()<reads>: []agent = external {}

    # Is true when `Agent` is in the zone.
    IsInVolume<public>(Agent: agent)<transacts><decides>: void = external {}

    # Updates *Selected Class* to `Agent`'s class.
    UpdateSelectedClass<public>(Agent: agent): void = external {}

    # Updates *Selected Team* to `Agent`'s team.
    UpdateSelectedTeam<public>(Agent: agent): void = external {}
  }

  # Used to create an environmental prop that applies Nitro to those around it when it is destroyed.
  nitro_barrel_spawner_device<public> := class<concrete><final>(creative_device_base) {
    # Allows the barrel to respawn after it explodes, waiting *RespawnDelay* seconds.
    AllowRespawn<public>(): void = external {}

    # Disables and hides the barrel.Disabling the device will remove an existing barrel and reset the respawn delay.
    Disable<public>(): void = external {}

    # Prevents the barrel from respawning.The *RespawnDelay* countdown will not start. If the countdown has already started, the barrel will not respawn when it ends.
    DisallowRespawn<public>(): void = external {}

    # Enables and shows the barrel.Enabling the device when it's disabled will spawn a new barrel.
    Enable<public>(): void = external {}

    # Triggers when the barrel explodes after being launched. Sends the launching `agent`.If the launcher is a non-agent, sends `false`.
    ExplodedEvent<public>: listenable(?agent) = external {}

    # Returns the force multiplier to launch the barrel.
    GetLaunchForceMultiplier<public>(): float = external {}

    # Returns the delay between exploding and respawning (if allowed), in seconds.
    GetRespawnDelay<public>(): float = external {}

    # Succeeds if the barrel is enabled and visible.
    IsEnabled<public>()<transacts><decides>: void = external {}

    # Succeeds if the barrel has respawn allowed.
    IsRespawnAllowed<public>()<transacts><decides>: void = external {}

    # Triggers when an `agent` launches the barrel. Sends the launching `agent`.If the launcher is a non-agent, sends `false`.
    LaunchedEvent<public>: listenable(?agent) = external {}

    # Sets the multiplier applied to the force used when launching.This is clamped between `0.25` and `2.0`.
    SetLaunchForceMultiplier<public>(LaunchForceMultiplier: float): void = external {}

    # Sets the delay time to respawn the barrel, clamped between `0.0` and `1000.0` seconds.This will override the delay timer if set during the delay countdown.
    SetRespawnDelay<public>(RespawnDelay: float): void = external {}
  }

  # Use to create a flaming hoop that accelerates and applies nitro to players and vehicles.
  nitro_hoop_device<public> := class<concrete><final>(creative_device_base) {
    # Allow the device to enter the cooldown state after a player or vehicle triggers it.
    AllowCooldown<public>(): void = external {}

    # Triggers when the device enters the cooldown state, becoming disabled.
    # This is not triggered by manually calling `Disable`.
    CooldownStartEvent<public>: listenable(tuple()) = external {}

    # Disable the device. This causes the device to enter the cooldown state until the device is re-enabled by `Enable`, `DisallowCooldown`, or `Enable on Phase`.
    Disable<public>(): void = external {}

    # Prevent the device from entering the cooldown state after use. Until `AllowCooldown` is called, triggering the device will not begin cooldown.
    # If the device is currently in the cooldown state, this ends the cooldown state and re-enables the device.
    DisallowCooldown<public>(): void = external {}

    # Enable the device. If the device is currently in the cooldown state, this also ends the cooldown state.
    Enable<public>(): void = external {}

    # Triggers when the device becomes enabled after being disabled, potentially through the cooldown state.
    EnabledEvent<public>: listenable(tuple()) = external {}

    # Return the duration of the cooldown delay in seconds. This is the delay between triggering a cooldown and entering the cooldown phase.
    GetCooldownDelay<public>(): float = external {}

    # Return the default duration of the cooldown state in seconds.
    GetDefaultCooldownDuration<public>(): float = external {}

    # Succeeds if the device is currently enabled.
    # The device is not enabled if it is in the cooldown state, or has otherwise been manually disabled.
    IsEnabled<public>()<transacts><decides>: void = external {}

    # Triggers when a player triggers the device.
    # Sends the triggering `agent`.
    PlayerTriggeredEvent<public>: listenable(agent) = external {}

    # Set the duration of the cooldown delay to `Seconds`. This is the delay between triggering a cooldown and entering the cooldown phase.
    #  * The cooldown delay does not apply to cooldowns triggered by *StartCooldown* or *Disable*.
    #  * `Seconds` is clamped between `0.0` and `5.0`.
    SetCooldownDelay<public>(Seconds: float): void = external {}

    # Set the default duration of the cooldown state to `Seconds`.
    #  * `Seconds` is clamped between `1.0` and `60.0`.
    SetDefaultCooldownDuration<public>(Seconds: float): void = external {}

    # Enter the cooldown state for `Seconds` seconds. If the device is already in the cooldown state, re-enable it after `Seconds` seconds.
    # `Seconds` is clamped to a minimum of `1.0`.
    StartCooldown<public>(Seconds: float): void = external {}

    # Triggers when a vehicle triggers the device.
    # Sends the driver as the triggering `agent`. If the vehicle has no driver then `false` is returned.
    VehicleTriggeredEvent<public>: listenable(?agent) = external {}
  }

  # Used to spawn NPCs made with Character Definition asset.
  npc_spawner_device<public> := class<concrete><final>(creative_device_base) {
    # Despawns all characters. If set, `Instigator` will be considered as the eliminator of those characters.
    DespawnAll<public>(Instigator: ?agent): void = external {}

    # Disables this device. Characters will despawn if *Despawn AIs When Disabled* is set.
    Disable<public>(): void = external {}

    # Signaled when a character is eliminated.
    # `Source` is the `agent` that eliminated the character. If the character was eliminated by a non-agent then `Source` is 'false'.
    # `Target` is the character that was eliminated.
    EliminatedEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Enables this device. Characters will start to spawn.
    Enable<public>(): void = external {}

    # Get all agents created by this device.
    GetAgents<public>()<transacts>: []agent = external {}

    # Resets the spawn count allowing spawning of a new batch of characters.
    (/Fortnite.com/Devices/npc_spawner_device:)Reset<public>(): void = external {}

    # Tries to spawn a character.
    Spawn<public>(): void = external {}

    # Spawn a NPC at the given position. When Rotation is not provided, it will default to the Device`s rotation.
    # Returns the agent spawned or false if the device has reached its maximum spawn count.
    # This function is `<suspends>` because it takes time to load the NPC before it can be returned.
    SpawnAt<public>(
      Position: (/Verse.org/SpatialMath:)vector3,
      ?Rotation: ?(/Verse.org/SpatialMath:)rotation = external {}
    )<suspends>: ?agent = external {}

    # Signaled when a character is spawned.
    # Sends the `agent` character who was spawned.
    SpawnedEvent<public>: listenable(agent) = external {}
  }

  # Provides a collection of destructible devices that you can select from to use as objectives in your game.
  objective_device<public> := class<concrete><final>(creative_device_base, healthful, damageable, healable) {
    # Activates an objective pulse at `Agent`'s location pointing toward this device.
    ActivateObjectivePulse<public>(Agent: agent): void = external {}

    Damage<override>(Amount: float): void = external {}

    Damage<override>(Args: damage_args): void = external {}

    DamagedEvent<override>(): listenable(damage_result) = external {}

    # Deactivates the objective pulse at `Agent`'s location.
    DeactivateObjectivePulse<public>(Agent: agent): void = external {}

    # Destroys the objective item. This is done regardless of the visibility or health of the item.
    Destroy<public>(Agent: agent): void = external {}

    # Signaled when this device has been destroyed by an `agent`.
    # Sends the `agent` that destroyed this device.
    DestroyedEvent<public>: listenable(agent) = external {}

    GetHealth<override>()<transacts>: float = external {}

    GetMaxHealth<override>()<transacts>: float = external {}

    Heal<override>(Amount: float): void = external {}

    Heal<override>(Args: healing_args): void = external {}

    HealedEvent<override>(): listenable(healing_result) = external {}

    # Hides this device from the world.
    Hide<public>(): void = external {}

    SetHealth<override>(Health: float)<transacts>: void = external {}

    # Sets the device either invulnerable or damageable
    SetInvulnerable<public>(Invulnerable: logic): void = external {}

    SetMaxHealth<override>(MaxHealth: float)<transacts>: void = external {}

    # Shows this device in the world.
    Show<public>(): void = external {}
  }

  # A boss-like environmental encounter that will attack players with different abilities
  overlord_spire_device<public> := class<concrete><final>(creative_device_base, has_spire_functionality) {
    # Triggers when the Spire becomes activated from players entering the `Activation Distance`
    ActivateEvent<override>: listenable(?agent) = external {}

    # Triggers when the Spire begins charging up its beam attack
    BeginBeamEvent<public>: listenable(tuple()) = external {}

    # Triggers when the Spire starts spawning homing projectiles to fire
    BeginHomingProjectileEvent<public>: listenable(tuple()) = external {}

    # Triggers when the Spire begins to perform the scream.
    BeginScreamEvent<public>: listenable(tuple()) = external {}

    # Triggers when the Spire begins its slam attack
    BeginSlamEvent<public>: listenable(tuple()) = external {}

    # Triggers when the Spire begins trying to recover from the slam attack, when the appendage weakpoint is stuck in the ground.
    BeginSlamRecoverEvent<public>: listenable(tuple()) = external {}

    # Removes the target set from `SetTarget` and allows the Spire to return to its normal targeting pattern
    ClearTarget<public>(): void = external {}

    # Triggers when the Spire becomes deactivated, either from players leaving the `Activation Distance`
    DeactivateEvent<override>: listenable(tuple()) = external {}

    # Sets the Spire's health to zero, destroying it.
    #  *  Does nothing if the Spire has not spawned or is already destroyed.
    Destroy<override>(): void = external {}

    # Triggers when the Spire is destroyed from damage or events
    #  * Includes the `agent` that destroyed it, if any.
    DestroyEvent<override>: listenable(?agent) = external {}

    # Disable the device which causes the Spire to become deactivated, stopping the behaviors and attacks, as well as preventing activation when players are within the `Activation Distance`.
    #  * Does nothing if the Spire is destroyed or already disabled.
    Disable<override>(): void = external {}

    # Enable the device, causing the Spire to become activated when players are within the `Activation Distance`.
    #  * Does nothing if the Spire is destroyed or already enabled.
    Enable<override>(): void = external {}

    # Triggers when the Spire finishes shooting its beam attack
    EndBeamEvent<public>: listenable(tuple()) = external {}

    # Triggers when the last homing projectile has exploded
    EndHomingProjectileEvent<public>: listenable(tuple()) = external {}

    # Triggers when the Spire has finished performing the scream
    EndScreamEvent<public>: listenable(tuple()) = external {}

    # Triggers when the Spire has finished recovering from the slam attack
    EndSlamEvent<public>: listenable(tuple()) = external {}

    # Triggers when the Spire finishes recovering from the slam attack and the appendage weakpoint is no longer stuck in the ground.
    EndSlamRecoverEvent<public>: listenable(tuple()) = external {}

    # Fades out the preview clouds above where the Spire spawns.
    HideClouds<public>(): void = external {}

    # If this Spire is currently activated.
    #  * Succeeds if activated. Fails if deactivated
    #  * An activated will react to enemies and take damage * Becomes activated from being enabled and players entering the `Activation Distance`
    IsActivated<override>()<transacts><decides>: void = external {}

    # Succeeds if this Spire's health has reached 0. Fails otherwise
    IsDestroyed<override>()<transacts><decides>: void = external {}

    # Succeeds if the device is enabled. Fails if the Spire is disabled. While disabled, the Spire is deactivated and will not react to approaching players, nor take damage.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Succeeds if this Spire is in a spawned state. Fails if the Spire is destroyed or has not spawned.
    IsSpawned<override>()<transacts><decides>: void = external {}

    # Resets the Spire to its initial state.
    (/Fortnite.com/Devices/has_spire_functionality:)Reset<override>(): void = external {}

    # Sets the main target of the Spire, causing the Spire to focus attacks on the 'TargetAgent' while they are within the `Activation Distance`.
    #  * `TargetAgent` is an invalid `agent`, this function will clear the target.
    SetTarget<public>(TargetAgent: ?agent): void = external {}

    # Fades in the preview clouds above where the Spire spawns.
    ShowClouds<public>(): void = external {}

    # Spawns the Spire, causing it to become visible and enabling collision
    #  *  Does nothing if the Spire is already spawned or destroyed
    Spawn<override>(): void = external {}

    # Triggers when the Spire is spawned, either from players entering the `Activation Distance` or by events.
    SpawnEvent<public>: listenable(tuple()) = external {}

    # Triggers when the Spire’s player target is changed to a different player
    TargetChangeEvent<public>: listenable(agent) = external {}

    # Determines the distance where approaching players activate the Spire.
    #  * Values are clamped between `500.0` and `10000.0` cm
    var ActivationDistance<override>: float = external {}

    # Determines the distance/angle that the beam will travel
    #  * Values are clamped between `0.0` and `360.0` degrees
    var BeamArc<public>: float = external {}

    # Determines the amount of time that the Spire must wait to use the beam attack after previously using it
    #  * Values are clamped between `0.0` and `60.0` seconds
    var BeamCooldownTime<public>: float = external {}

    # Determines how much total damage the beam attack does per second to buildings.
    #  * Values are clamped between `0.0` and `1000.0`
    #  * A portion of the damage is applied multiple times per second while a target is within the beam.
    var BeamDamagePerSecondToBuildings<public>: float = external {}

    # Determines how much total damage the beam attack does per second to creatures.
    #  * Values are clamped between `0.0` and `1000.0`
    #  * A portion of the damage is applied multiple times per second while a target is within the beam.
    var BeamDamagePerSecondToCreatures<public>: float = external {}

    # Determines how much total damage the beam attack does per second to guards.
    #  * Values are clamped between `0.0` and `1000.0`
    #  * A portion of the damage is applied multiple times per second while a target is within the beam.
    var BeamDamagePerSecondToGuards<public>: float = external {}

    # Determines how much total damage the beam attack does per second to players.
    #  * Values are clamped between `0.0` and `1000.0`
    #  * A portion of the damage is applied multiple times per second while a target is within the beam.
    var BeamDamagePerSecondToPlayers<public>: float = external {}

    # Determines how much total damage the beam attack does per second to vehicles.
    #  * Values are clamped between `0.0` and `1000.0`
    #  * A portion of the damage is applied multiple times per second while a target is within the beam.
    var BeamDamagePerSecondToVehicles<public>: float = external {}

    # Determines how much total damage the beam attack does per second to wildlife.
    #  * Values are clamped between `0.0` and `1000.0`
    #  * A portion of the damage is applied multiple times per second while a target is within the beam.
    var BeamDamagePerSecondToWildlife<public>: float = external {}

    # Determines how long the Spire takes to complete the beam attack
    #  * Values are clamped between `1.0` and `60.0` seconds
    var BeamDuration<public>: float = external {}

    # The Spire's current health. Clamped between 0 and `MaxHealth`.
    #  * Setting this value does nothing if the Spire is destroyed.
    var Health<override>: float = external {}

    # Determines the amount of time that the Spire must wait to use the homing projectile attack after previously using it
    #  * Values are clamped between `0.0` and `60.0` seconds
    var HomingProjectileCooldownTime<public>: float = external {}

    # Determines how much total damage the homing projectile attack does to creatures.
    #  * Values are clamped between `0.0` and `10000.0`
    var HomingProjectileDamageCreatures<public>: float = external {}

    # Determines how much total damage the homing projectile attack does to buildings.
    #  * Values are clamped between `0.0` and `10000.0`
    var HomingProjectileDamageToBuildings<public>: float = external {}

    # Determines how much total damage the homing projectile attack does to guards.
    #  * Values are clamped between `0.0` and `10000.0`
    var HomingProjectileDamageToGuards<public>: float = external {}

    # Determines how much total damage the homing projectile attack does to players.
    #  * Values are clamped between `0.0` and `10000.0`
    var HomingProjectileDamageToPlayers<public>: float = external {}

    # Determines how much total damage the homing projectile attack does to vehicles.
    #  * Values are clamped between `0.0` and `10000.0`
    var HomingProjectileDamageToVehicles<public>: float = external {}

    # Determines how much total damage the homing projectile attack does to wildlife.
    #  * Values are clamped between `0.0` and `10000.0`
    var HomingProjectileDamageWildlife<public>: float = external {}

    # Determines the maximum speed that homing projectiles can accelerate to.
    #  * Values are clamped between `100.0` and `5000.0` meters per second
    var HomingProjectileMaxSpeed<public>: float = external {}

    # Determines if the Spire is able to use the beam attack. Setting this to false will not interrupt the attack if it is currently in progress.
    var IsBeamAttackEnabled<public>: logic = external {}

    # Determines if the Spire is able to use the homing projectile attack. Setting this to false will not interrupt the attack if it is currently in progress.
    var IsHomingProjectileAttackEnabled<public>: logic = external {}

    # Determines if the Spire is able to perform the scream attack.
    #  * The scream is an ability used when the spire drops below a health threshold. It performs an animation and events can be hooked up to it for things like spawning a wave of Guards to fight for it.
    #  * Setting this to false will not interrupt the ability if it is currently in progress.
    var IsScreamAttackEnabled<public>: logic = external {}

    # Determines if the Spire is able to use the slam attack. Setting this to false will not interrupt the attack if it is currently in progress.
    var IsSlamAttackEnabled<public>: logic = external {}

    # The maximum health of this Spire.
    var MaxHealth<override>: float = external {}

    # Determines the maximum amount of time that the Spire must wait to use another ability after previously using one
    #  * The actual time to wait after each ability is chosen at random between this value and MinimumTimeBetweenAbilities
    #  * This is effectively a global cooldown across all abilities.
    #  * Values are clamped between `0.0` and `60.0` seconds
    var MaximumTimeBetweenAbilities<public>: float = external {}

    # Determines the minimum amount of time that the Spire must wait to use another ability after previously using one
    #  * The actual time to wait after each ability is chosen at random between this value and MaximumTimeBetweenAbilities
    #  * This is effectively a global cooldown across all abilities.
    #  * Values are clamped between `0.0` and `60.0` seconds
    var MinimumTimeBetweenAbilities<public>: float = external {}

    # Determines the number of homing projectiles that can be fired per attack.
    #  * Values are clamped between `1` and `20` projectiles
    var NumberOfHomingProjectiles<public>: int = external {}

    # Determines if a Spire-specific icon should be displayed on the map while the Spire is spawned
    var ShowMapIcon<override>: logic = external {}

    # Determines how much total damage the slam attack does to creatures.
    #  * Values are clamped between `0.0` and `10000.0`
    var SlamAttackDamageCreatures<public>: float = external {}

    # Determines how much total damage the slam attack does to buildings.
    #  * Values are clamped between `0.0` and `10000.0`
    var SlamAttackDamageToBuildings<public>: float = external {}

    # Determines how much total damage the slam attack does to guards.
    #  * Values are clamped between `0.0` and `10000.0`
    var SlamAttackDamageToGuards<public>: float = external {}

    # Determines how much total damage the slam attack does to players.
    #  * Values are clamped between `0.0` and `10000.0`
    var SlamAttackDamageToPlayers<public>: float = external {}

    # Determines how much total damage the slam attack does to vehicles.
    #  * Values are clamped between `0.0` and `10000.0`
    var SlamAttackDamageToVehicles<public>: float = external {}

    # Determines how much total damage the slam attack does to wildlife.
    #  * Values are clamped between `0.0` and `10000.0`
    var SlamAttackDamageWildlife<public>: float = external {}

    # Determines the amount of time the Spire must wait to use the slam attack after previously using it
    #  * Values are clamped between `0.0` and `60.0` seconds
    var SlamCooldownTime<public>: float = external {}

    # Determines the radius that the slam attack initially affects before the shockwave spreads.
    #  * Values are clamped between `100.0` and `1000.0` meters
    var SlamInitialRadius<public>: float = external {}

    # Determines the amount of time it takes for the Spire to recover from the slam attack.
    #  * Values are clamped between `0.0` and `60.0` seconds
    #  * The higher the value, the longer the weakpoint is exposed.
    var SlamRecoveryTime<public>: float = external {}

    # Determines the time it takes for the slam attack's shockwave to reach the maximum radius.
    #  * Values are clamped between `1.0` and `30.0` seconds
    var SlamShockwaveDuration<public>: float = external {}

    # Determines the maximum radius that the slam attack's shockwave can spread
    #  * Values are clamped between `100.0` and `5000.0` meters
    var SlamShockwaveMaxRadius<public>: float = external {}

    # Succeeds if the Spire must wait until all projectiles have spawned before moving on to the next attack
    #  * Fails if the Spire will move on to the next attack when it finishes the spawning animation.
    #  * This setting is useful to make the encounter more challenging by allowing the Spire to shoot a large number of homing projectiles and to move on to another attack while they are still spawning
    var WaitForAllProjectilesToSpawnBeforeNextAttack<public>: logic = external {}
  }

  # Specialized `trigger_base_device` that will fire output events based on line of sight between `agent`s and the device.
  perception_trigger_device<public> := class<concrete><final>(trigger_base_device) {
    # Signaled when an `agent` has direct line of sight to this device.
    # Sends the `agent` that has seen this device.
    AgentLooksAtDeviceEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` has lost direct line of sight to this device.
    # Sends the `agent` that has lost sight of this device.
    AgentLooksAwayFromDeviceEvent<public>: listenable(agent) = external {}

    # Signaled when this device loses direct line of sight to an `agent`.
    # Sends the `agent` this device has lost sight of.
    DeviceLosesSightOfAgentEvent<public>: listenable(agent) = external {}

    # Signaled when this device has direct line of sight to an `agent`.
    # Sends the `agent` seen by this device.
    DeviceSeesAgentEvent<public>: listenable(agent) = external {}

    # Returns an array of agents that are currently of the class defined by this device.
    GetLookingAtDeviceAgents<public>()<reads>: []agent = external {}

    # Returns an array of agents that are currently of the class defined by this device.
    GetPerceivedAgents<public>()<reads>: []agent = external {}

    # Succeeds when `Agent` is registered to this checkpoint.
    IsLookingAtDevice<public>(Agent: agent)<transacts><decides>: void = external {}

    # Succeeds when `Agent` is registered to this checkpoint.
    IsPerceived<public>(Agent: agent)<transacts><decides>: void = external {}
  }

  # Physics boulder that can be dislodged and damage `agent`s, vehicles, creatures, and structures.
  physics_boulder_device<public> := class<concrete><final>(physics_object_base_device) {
    # Signaled when the balanced boulder is destroyed.
    BalancedBoulderDestroyedEvent<public>: listenable(tuple()) = external {}

    # Signaled when the balanced boulder is spawned on the base.
    BalancedBoulderSpawnedEvent<public>: listenable(tuple()) = external {}

    # Signaled when the base of the boulder is destroyed.
    BaseDestroyedEvent<public>: listenable(tuple()) = external {}

    # Destroys the boulder's base.
    DestroyBase<public>(): void = external {}

    # Destroys the current rolling boulder.
    DestroyRollingBoulder<public>(): void = external {}

    # Releases the boulder sitting on the base, if there is one.
    ReleaseRollingBoulder<public>(): void = external {}

    # Signaled when the rolling boulder is destroyed.
    RollingBoulderDestroyedEvent<public>: listenable(tuple()) = external {}
  }

  # Base class for various physics-based gameplay elements (e.g. boulders/trees).
  physics_object_base_device<public> := class<abstract><epic_internal>(prop_spawner_base_device) {}

  # Physics tree that can be chopped down, and damage players, vehicles, creatures, and structures.
  physics_tree_device<public> := class<concrete><final>(physics_object_base_device) {
    # Destroys the current log.
    DestroyLog<public>(): void = external {}

    # Destroys the current stump.
    DestroyStump<public>(): void = external {}

    # Signaled when the log created by a tree is destroyed.
    LogDestroyedEvent<public>: listenable(tuple()) = external {}

    # Releases the log from the tree, if there is one.
    ReleaseLog<public>(): void = external {}

    # Signaled when the stump created by a tree is destroyed.
    StumpDestroyedEvent<public>: listenable(tuple()) = external {}

    # Signaled when a tree has taken enough damage to be knocked down.
    TreeKnockedDownEvent<public>: listenable(tuple()) = external {}

    # Signaled when a tree is spawned.
    TreeSpawnedEvent<public>: listenable(tuple()) = external {}
  }

  # A triggered bumper that can knock players back, damage them, and award points.
  pinball_bumper_device<public> := class<concrete><final>(creative_device_base) {
    # Activates this device.
    Activate<public>(): void = external {}

    # Signaled when this device is activated by an `agent`.
    # Sends the `agent` that activated this device.
    ActivatedEvent<public>: listenable(agent) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Used to move, damage, and give scores to players that interact with it. By default, it is activated by any player touching its front face, which rotates it counterclockwise and knocks those players away from it and slightly upward.
  pinball_flipper_device<public> := class<concrete><final>(creative_device_base) {
    # Causes `Agent` to activate this device.
    Activate<public>(Agent: agent): void = external {}

    # Signaled when this device is activated by an `agent`.
    # Sends the `agent` that activated this device.
    ActivatedEvent<public>: listenable(agent) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Used to set an `agent`'s spawn point when activated. This can also clear the `agent`'s inventory.
  player_checkpoint_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when this device is first activated by any `agent`.
    # Sends the `agent` that activated this device.
    FirstActivationEvent<public>: listenable(agent) = external {}

    # Signaled each time a new `agent` activates this device.
    # Sends the `agent` that activated this device.
    FirstActivationPerAgentEvent<public>: listenable(agent) = external {}

    # Returns an array of agents that are currently registered to this checkpoint.
    GetRegisteredAgents<public>()<reads>: []agent = external {}

    # Succeeds when `Agent` is registered to this checkpoint.
    IsRegistered<public>(Agent: agent)<transacts><decides>: void = external {}

    # Registers this checkpoint for `Agent`. This sets the respawn point and can clear `Agent`'s inventory depending on this device's settings. Multiple `agent`s can be registered to this device at one time.
    Register<public>(Agent: agent): void = external {}
  }

  # Used to track and react to how many players are in a particular area, and optionally display that information in game.
  player_counter_device<public> := class<concrete><final>(creative_device_base) {
    # Triggers an evaluation of the current count vs *Target Player Count*, signaling `CountSucceedsEvent` or `CountFailsEvent` based on the evaluation result.
    CompareToTarget<public>(): void = external {}

    # Signaled when the player count does not match *Target Player Count*. The frequency of evaluation against *Target Player Count* can be controlled through the device settings.
    CountFailsEvent<public>: listenable(tuple()) = external {}

    # Signaled when the player count matches *Target Player Count*. The frequency of evaluation against *Target Player Count* can be controlled through the device settings.
    CountSucceedsEvent<public>: listenable(tuple()) = external {}

    # Signaled when a valid player enters the zone and is counted. The frequency of evaluation against the *Target Player Count* can be controlled through the device settings.
    # Sends the `agent` that is now being counted.
    CountedEvent<public>: listenable(agent) = external {}

    # Decrements *Target Player Count* by `1`. Immediately triggers a new comparison.
    DecrementTargetCount<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Returns the number of players currently counted by this device
    GetCount<public>()<transacts>: int = external {}

    # Returns an array of agents that are currently counted by the device.
    GetCountedAgents<public>()<reads>: []agent = external {}

    # Returns the number of players required for this counter to succeed.
    GetTargetCount<public>()<transacts>: int = external {}

    # Hide this device info panel from the world.
    HideInfoPanel<public>(): void = external {}

    # Increments *Target Player Count* by `1`. Immediately triggers a new comparison.
    IncrementTargetCount<public>(): void = external {}

    # Is true if `Agent` is currently counted by this device.
    IsCounted<public>(Agent: agent)<transacts><decides>: void = external {}

    # Is true if the device is currently succeeding in its comparison.
    IsPassingTest<public>()<transacts><decides>: void = external {}

    # Returns whether this device is represented in the world as an info panel showing Current + Required player counts.
    IsShowingInfoPanel<public>()<transacts><decides>: void = external {}

    # Adds the player to the registered player list.
    # *Track Registered Players* determines how registered players are counted.
    Register<public>(Agent: agent): void = external {}

    # Signaled when a player is no longer counted by this device, such as when they leave the zone, leave the game, or are assigned to a different `team` or class.
    # Sends the `agent` that is no longer being counted.
    RemovedEvent<public>: listenable(agent) = external {}

    # Resets *Target Player Count* to the default value defined in the device settings. If *Target Player Count* was previously incremented or decremented, this reset immediately triggers a new comparison.
    (/Fortnite.com/Devices/player_counter_device:)Reset<public>(): void = external {}

    # Sets the number of players required for this counter to succeed. Immediately triggers a new comparison.
    SetTargetCount<public>(Count: int): void = external {}

    # Show this device in the world as an info panel showing Current + Required player counts.
    ShowInfoPanel<public>(): void = external {}

    # Triggers `CountedEvent` for all `agent`s currently being counted.
    TransmitForAllCounted<public>(): void = external {}

    # Removes the player from the registered player list.
    # *Track Registered Players* determines how registered players are counted.
    Unregister<public>(Agent: agent): void = external {}

    # Clears all players from the list of registered players.
    # *Track Registered Players* determines how registered players are counted.
    UnregisterAll<public>(): void = external {}
  }

  # Used to mark an `agent`'s position on the minimap and configure the information shown for marked `agent`s.
  #
  # Example configuration options:
  #  * Health and shield bars for marked players.
  #  * Distance to a marked player.
  #
  # Example marker appearance options:
  #  * Customized text label displayed on marked players.
  #  * Alternative minimap icon and icon color.
  player_marker_device<public> := class<concrete><final>(creative_device_base) {
    # Attaches a marker to `Agent`.
    Attach<public>(Agent: agent): void = external {}

    # Detaches a marker from `Agent`.
    Detach<public>(Agent: agent): void = external {}

    # Detaches markers from all marked `agent`s.
    DetachFromAll<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when the first item type monitored on marked agents has changed.
    # Sends the marked `agent`.
    FirstItemValueChangedEvent<public>: listenable(agent) = external {}

    # Signaled when a marked `agent` meets the quantity condition for the first monitored item type (e.g. Fewer Than, Equal To, More Than X).
    # Sends the marked `agent`.
    FirstItemValueReachedEvent<public>: listenable(agent) = external {}

    # Signaled when the second item type monitored on marked agents has changed.
    # Sends the marked `agent`.
    SecondItemValueChangedEvent<public>: listenable(agent) = external {}

    # Signaled when a marked `agent` meets the quantity condition for the second monitored item type (e.g. Fewer Than, Equal To, More Than X).
    # Sends the marked `agent`.
    SecondItemValueReachedEvent<public>: listenable(agent) = external {}
  }

  # Used to update the player character's movement settings on different movement mode.
  player_movement_settings_device<public> := class<concrete><final>(creative_device_base, enableable) {
    # Adds the movement settings to the provided agent, activating if it is in the highest priority.
    #  * The highest priority device is applied to players and test players. Ties are broken by which is applied most recently.
    #  * Fails if the provided agent is unsupported including NPC agents like Guard, Wildlife or Custom NPCs.
    AddTo<public>(Agent: agent): void = external {}

    # Adds the movement settings to all the agents in the scene, activating if it is in the highest priority.
    #  * The highest priority device is applied to players and test players. Ties are broken by which is applied most recently.
    AddToAll<public>(): void = external {}

    # Disables this device, revoking its change to the registered player characters.
    # Disabling this does not clear the list of registered players.
    Disable<override>(): void = external {}

    # Enables this device, allowing its properties to affect the registered player characters' movement.
    Enable<override>(): void = external {}

    # Returns the priority of the device, the active device in the highest priority will be applied to the provided agents.
    GetPriority<public>()<reads>: float = external {}

    # Returns the player agents registered to this device.
    GetRegisteredAgents<public>()<reads>: []agent = external {}

    # Succeeds if the object is enabled, fails if it's disabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Removes the movement settings from the provided agent.
    # Fails if the provided agent doesn't have the movement settings applied.
    RemoveFrom<public>(Agent: agent): void = external {}

    # Removes the movement settings from all the active agents.
    RemoveFromAll<public>(): void = external {}
  }

  # Used to relay `agent` statistics to other devices and `agent`s. Can transmit statistics such as elimination count, eliminated count, or scores when certain conditions are met. Can also project a hologram of the `agent` and display text that can be altered in various positions and curvatures.
  player_reference_device<public> := class<concrete><final>(creative_device_base) {
    # Ends the round/game.
    Activate<public>(): void = external {}

    # Signaled when this device is activated.
    # Sends the `agent` stored in the device.
    ActivatedEvent<public>: listenable(agent) = external {}

    # Signaled when the `agent` tracked by this device is replaced.
    # Sends the new `agent` stored in the device.
    AgentReplacedEvent<public>: listenable(agent) = external {}

    # Signaled when the `agent` tracked by this fails to be updated.
    # Sends the `agent` that attempted to be stored in this device.
    AgentUpdateFailsEvent<public>: listenable(agent) = external {}

    # Signaled when the `agent` tracked by this device is updated.
    # Sends the new `agent` stored in the device.
    AgentUpdatedEvent<public>: listenable(agent) = external {}

    # Clears the state of this device.
    Clear<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Returns the `agent` currently referenced by the device.
    GetAgent<public>(): ?agent = external {}

    # Returns the stat value that this device is currently tracking
    GetStatValue<public>(): int = external {}

    # Is true when `Agent` is the player being referenced by the device.
    IsReferenced<public>(Agent: agent)<transacts><decides>: void = external {}

    # Registers `Agent` as the `agent` being tracked by this device.
    Register<public>(Agent: agent): void = external {}

    # Signaled when a stat tracked by this device is updated.
    # Sends the `agent` stored in the device.
    TrackedStatChangedEvent<public>: listenable(agent) = external {}
  }

  # Used to spawn an `agent` on an island. Use multiple `player_spawner_device`s to spawn multiple `agent`s.
  player_spawner_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Spawn `Player` from this device.
    # Uses the device's `ShouldRespawnAlivePlayers` setting to control behavior when called on an alive player.
    # If the device is not a valid spawn for that player, they will respawn from a valid spawn device, or from skydive if none are found.
    SpawnPlayer<public>(Player: player): void = external {}

    # Signaled when an `agent` is spawned from this device.
    # Sends the `agent` that spawned.
    SpawnedEvent<public>: listenable(agent) = external {}
  }

  # Used to create HUD text boxes that give players information, and allows responses to be customized to player choices.
  popup_dialog_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Signaled when this device is dismissed by an `agent`.
    # Sends the `agent` who dismissed the popup.
    DismissedEvent<public>: listenable(agent) = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Returns the *Button Text* for this popup at a specified index.
    GetButtonText<public>(Index: int)<transacts>: string = external {}

    # Returns the *Description* text for this popup.
    GetDescriptionText<public>()<transacts>: string = external {}

    # Returns the *Title* text for this popup.
    GetTitleText<public>()<transacts>: string = external {}

    # Hides the popup from all `agent`s in the experience.
    Hide<public>(): void = external {}

    # Hides the popup from `Agent`.
    Hide<public>(Agent: agent): void = external {}

    # Signaled when *Button <Index>* on this device is pushed by an `agent`.
    # Sends the `agent` that pushed the button.
    # Sends the `int` index of the button that was clicked.
    RespondingButtonEvent<public>: listenable(tuple(agent, int)) = external {}

    # Sets the number of buttons this popup has.
    # Button Count is not updated on active Popups.
    SetButtonCount<public>(Count: int): void = external {}

    # Sets the *Button Text* for a button at a specific index on this popup.
    #  * `Text` should be no more than `24` characters.
    #  * If `Text` is empty the button will show *OK* instead.
    #  * Button 1 uses `Index` 0.
    SetButtonText<public>(Text: message, Index: int): void = external {}

    # Sets the *Description* text for this popup. `Text` should be no more than `350` characters.
    SetDescriptionText<public>(Text: message): void = external {}

    # Sets the *Title* text for this popup. `Text` should be no more than `32` characters.
    SetTitleText<public>(Text: message): void = external {}

    # Shows the popup to all `agent`s in the experience.
    Show<public>(): void = external {}

    # Shows the popup to `Agent`.
    Show<public>(Agent: agent): void = external {}

    # Signaled when this device is shown to an `agent`.
    # Sends the `agent` looking at the popup.
    ShownEvent<public>: listenable(agent) = external {}

    # Signaled when this device times out while an `agent` is looking at it.
    # Sends the `agent` who was looking at the popup.
    TimeOutEvent<public>: listenable(agent) = external {}
  }

  # Used to apply Post Process Effects to players through the creative device rather than a Post Process Volume.
  post_process_device<public> := class<concrete><final>(creative_device_base) {
    # Starts blending in the post process effect to the set strength only for the instigating `Agent`.
    BlendIn<public>(Agent: agent): void = external {}

    # Starts blending in the post process effect to the set strength for all players.
    BlendInForAll<public>(): void = external {}

    # Starts blending out the post process effect to 0 strength only for the instigating `Agent`.
    BlendOut<public>(Agent: agent): void = external {}

    # Starts blending out the post process effect to 0 strength for all players.
    BlendOutForAll<public>(): void = external {}

    # Signaled when a blend in event has finished. Sends the `agent` that used this device.
    BlendingInCompleteEvent<public>: listenable(?agent) = external {}

    # Signaled when a blend out event has finished. Sends the `agent` that used this device.
    BlendingOutCompleteEvent<public>: listenable(?agent) = external {}

    # Disables this device for all players.
    Disable<public>(): void = external {}

    # Disables this device only for the instigating `Agent`.
    Disable<public>(Agent: agent): void = external {}

    # Enables this device for all players.
    Enable<public>(): void = external {}

    # Enables this device only for the instigating `Agent`.
    Enable<public>(Agent: agent): void = external {}

    # Resets to the starting strength, ending any ongoing blending only for the instigating `Agent`.
    (/Fortnite.com/Devices/post_process_device:)Reset<public>(Agent: agent): void = external {}

    # Resets to the starting strength, ending any ongoing blending for all players.
    ResetForAll<public>(): void = external {}
  }

  # Base class for various powerup devices offering common events like `ItemPickedUpEvent`.
  powerup_device<public> := class<abstract><epic_internal>(creative_device_base) {
    # Despawns this powerup from the experience.
    Despawn<public>(): void = external {}

    # Returns the *Duration* that this powerup will be active for on any player it is applied to.
    GetDuration<public>()<transacts>: float = external {}

    # If the `Agent` has the effect applied to them, this will return the remaining time the effect has.
    # Returns -1.0 if the effect has an infinite duration.
    # Returns 0.0 if the `Agent` does not have the effect applied.
    GetRemainingTime<public>(Agent: agent)<transacts>: float = external {}

    # Returns the `Agent` has the powerup's effect (or another of the same type) applied to them.
    HasEffect<public>(Agent: agent)<transacts><decides>: void = external {}

    # Succeeds if the powerup is currently spawned.
    IsSpawned<public>()<transacts><decides>: void = external {}

    # Signaled when the powerup is picked up by an `agent`.
    # Sends the `agent` that picked up the powerup.
    ItemPickedUpEvent<public>: listenable(agent) = external {}

    # Grants this powerup without an agent reference.
    # Requires *Apply To* set to *All Players*.
    Pickup<public>(): void = external {}

    # Grants this powerup to `Agent`.
    Pickup<public>(Agent: agent): void = external {}

    # Updates the *Duration* for this powerup, clamped to the Min and Max defined in the device.
    # Will not apply to any currently applied effects.
    SetDuration<public>(Time: float): void = external {}

    # Spawns the powerup into the experience so users can interact with it.
    Spawn<public>(): void = external {}
  }

  # This device is used to associate changes in progression with a mesh transition. As the device's progression changes, it will transition between a set of defined meshes.
  #  The ThresholdMesh field can be found under the 'Visuals' category on an instance of a progress_based_mesh_device in Unreal Editor Fortnite.
  progress_based_mesh_device<public> := class<concrete><final>(creative_device_base) {
    # This event is fired whenever 'CurrentProgress' reaches 0.
    EmptyEvent<public>: listenable(tuple()) = external {}

    # This event is fired whenever 'CurrentProgress' reaches the 'ProgressTarget'.
    FillEvent<public>: listenable(tuple()) = external {}

    # This event is fired whenever 'CurrentProgress' value gets changed, whether through direct modification, or as a result of the Progress or Regress state.
    ProgressChangeEvent<public>: listenable(float) = external {}

    # # This event fires whenever this device changes meshes as a result of 'CurrentProgress' value causing a new Threshold to be met.
    #  The ThresholdMeshe field can be found under the 'Visuals' category on an instance of a progress_based_mesh_device in Unreal Editor Fortnite.
    ProgressThresholdCrossEvent<public>: listenable(float) = external {}

    # The current progress this device has made towards its ProgressTarget.
    #  This value will be clamped between 0 and Progress Target.
    #  Modifying this value will cause changes Mesh Changes corresponding to your defined ThresholdMeshes.
    var CurrentProgress<public>: float = external {}

    # This value maps to the 'ProgressRate' user option.
    #  When this device is in the Progress state, 'CurrentProgress' will be increased by this value per second until it reaches the 'ProgressTarget'.
    #  Utilizing this value is not required, as 'CurrentProgress' can also be modified directly.
    var ProgressRate<public>: float = external {}

    # The current state of this device.
    var ProgressState<public>: progress_device_state = external {}

    # This value maps to the 'ProgressTarget' user option.
    #  The target Progress goal of this value.
    #  Setting this value will clamp it between 0 and 100.
    #  If 'ProgressTarget' is set to a value lower than 'CurrentProgress', 'CurrentProgress' will be clamped to 'ProgressTarget', and fire any threshold related events.
    var ProgressTarget<public>: float = external {}

    # This value maps to the 'RegressRate' user option.
    #  When this device is in the Regress state, 'CurrentProgress' will be decreased by this value per second until it reaches the 0.
    #  Utilizing this value is not required, as 'CurrentProgress' can also be modified directly.
    var RegressRate<public>: float = external {}
  }

  # The state of a progress_based_mesh_device.
  progress_device_state<public> := enum<open> {
    # This device is currently paused. It will not progress or regress automatically.
    Pause

    # This device is currently progressing, and will increase its 'CurrentProgress' by its 'ProgressRate'.
    Progress

    # This device is currently regressing, and will decrease its 'CurrentProgress' by its 'RegressRate'.
    Regress
  }

  # Used to manipulate the properties of one or more props in a specified area (e.g. Visibility/Destructibility).
  prop_manipulator_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when props affected by this device are damaged.
    # Sends the `agent` that damaged the prop.
    DamagedEvent<public>: listenable(agent) = external {}

    # Signaled when props affected by this device are destroyed.
    # Sends the `agent` that destroyed the prop.
    DestroyedEvent<public>: listenable(agent) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Sets the *Override Resource* option to *No*.
    DisableResourceNodeOverrides<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Empties the resources of all props affected by this device.
    ExhaustResources<public>(): void = external {}

    # Signaled when prop resource nodes affected by this device are harvested.
    # Sends the `agent` that harvested resources from the prop.
    HarvestingEvent<public>: listenable(agent) = external {}

    # Hides all props affected by this device.
    HideProps<public>(): void = external {}

    # Signaled when prop resource nodes affected by this device are completely depleted of energy.
    # Sends the `agent` that depleted the prop's energy.
    ResourceDepletionEvent<public>: listenable(agent) = external {}

    # Restocks the resources of all props affected by this device.
    RestockResources<public>(): void = external {}

    # Restores health of all props affected by this device.
    RestoreHealth<public>(): void = external {}

    # Sets the *Override Resource* option to *Yes*.
    SetResourceOverridesActive<public>(): void = external {}

    # Shows all props affected by this device.
    ShowProps<public>(): void = external {}
  }

  # Used to move around a building or prop, and customize responses to various collision event types.
  prop_mover_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when the prop hits a creature, animal, or NPC.
    AIHitEvent<public>: listenable(tuple()) = external {}

    # Moves the prop forward based on this device's default configuration, ignoring the prop's previous movement.
    Advance<public>(): void = external {}

    # Signaled when the prop hits an `agent`.
    # Sends the `agent` hit by the prop.
    AgentHitEvent<public>: listenable(agent) = external {}

    # Signaled when the prop movement begins.
    BeganEvent<public>: listenable(tuple()) = external {}

    # Begins the prop moving.
    Begin<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Signaled when this device is disabled.
    DisabledEvent<public>: listenable(tuple()) = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when this device is enabled.
    EnabledEvent<public>: listenable(tuple()) = external {}

    # Ends the prop moving.
    End<public>(): void = external {}

    # Signaled when the prop movement ends.
    EndedEvent<public>: listenable(tuple()) = external {}

    # Signaled when the prop reaches its destination.
    FinishedEvent<public>: listenable(tuple()) = external {}

    # Returns the total distance (in meters) that the prop will move.
    GetTargetDistance<public>()<transacts>: float = external {}

    # Returns the speed (in meters per second) at which the prop mover will move the prop to its destination.
    GetTargetSpeed<public>()<transacts>: float = external {}

    # Signaled when the prop changes its direction.
    MovementModeChangedEvent<public>: listenable(tuple()) = external {}

    # Signaled when the prop hits another prop.
    PropHitEvent<public>: listenable(tuple()) = external {}

    # Moves the prop to its original position.
    (/Fortnite.com/Devices/prop_mover_device:)Reset<public>(): void = external {}

    # Reverses the prop's moving direction.
    Reverse<public>(): void = external {}

    # Sets the total distance (in meters) that the prop will move.
    SetTargetDistance<public>(InDistance: float): void = external {}

    # Sets the speed (in meters per second) at which the prop will move to its destination.
    SetTargetSpeed<public>(Speed: float): void = external {}
  }

  # Allows customization of the Prop-o-Matic weapon functions and how the game reacts to players using it.
  prop_o_matic_manager_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when an `agent` begins entering a disguise.
    # Sends the `agent` that began entering the disguise.
    BeginEnteringDisguiseEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` exits a disguise.
    # Sends the `agent` that exited the disguise.
    ExitingDisguiseEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` finishes entering a disguise.
    # Sends the `agent` that finished entering the disguise.
    FinishEnteringDisguiseEvent<public>: listenable(agent) = external {}

    # Returns whether a player is currently hiding or not.
    IsPlayerProp<public>(Agent: agent)<transacts><decides>: void = external {}

    # Signaled when all player props have been pinged.
    PingAllPlayerPropsEvent<public>: listenable(tuple()) = external {}

    # Manually ping a specific player if they are currently a prop.
    PingPlayerProp<public>(Agent: agent): void = external {}

    # Signaled when a player prop has been pinged.
    # Sends the `agent` that was pinged.
    PingPlayerPropEvent<public>: listenable(agent) = external {}

    # Manually ping all players that are currently hiding as props.
    PingPlayerProps<public>(): void = external {}

    # Adjust the ping time.
    SetPingFrequency<public>(Time: float): void = external {}

    # Toggle Pinging props on/off.
    SetPingProps<public>(On: logic): void = external {}

    # Toggle showing the prop ping cooldown.
    SetShowPropPingCooldown<public>(On: logic): void = external {}

    # Toggle showing the props remaining on the UI.
    SetShowPropsRemaining<public>(On: logic): void = external {}
  }

  # Base class for devices that spawn a prop object.
  prop_spawner_base_device<public> := class<abstract><epic_internal>(creative_device_base) {
    # Destroys all props spawned from this device.
    DestroyAllSpawnedObjects<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Spawns the prop associated with this device.
    SpawnObject<public>(): void = external {}
  }

  # A device used to damage players who collide with it. Can also be used as a trigger to activate other devices.
  pulse_trigger_device<public> := class<concrete><final>(creative_device_base) {
    # Starts the damage pulse.
    Begin<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Stops the damage pulse.
    End<public>(): void = external {}

    # Returns the damage to be applied to those hit by an active pulse. Clamped between `0 <= GetDamage <= 100000`.
    GetDamage<public>()<transacts>: float = external {}

    # Returns the total number of times this pulse will complete before ending.
    # `0` indicates the pulse will continue indefinitely.
    GetLoopCount<public>()<transacts>: int = external {}

    # Returns the speed (in meters per second) at which the pulses generated by this pulse trigger will travel.
    GetWaveSpeed<public>()<transacts>: float = external {}

    # Resumes the damage pulse from the last position where it was stopped.
    ResumePulse<public>(): void = external {}

    @deprecated
    # This function is deprecated. Use `ResumePulse` instead of this.
    # Resumes the damage sequence from the last position where it was stopped.
    ResumeSequence<public>(): void = external {}

    # Sets the damage to be applied to those hit by an active pulse. Clamped between `0 <= GetDamage <= 100000`.
    # Pulse visuals will change to reflect whether the pulse causes damage or not.
    SetDamage<public>(Damage: float): void = external {}

    # Sets the total number of times this pulse will complete before ending. `LoopCount = 0` indicates the pulse should continue indefinitely.
    SetLoopCount<public>(LoopCount: int): void = external {}

    # Sets the speed (in meters per second) at which the pulses generated by this pulse trigger will travel.
    SetWaveSpeed<public>(Speed: float): void = external {}
  }

  # Used in tandem with `race_manager_device` to define the route players must traverse.
  race_checkpoint_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when this checkpoint becomes the current checkpoint for `agent`.
    # Sends the `agent` who is now targeting this checkpoint.
    CheckpointBecomesCurrentEvent<public>: listenable(agent) = external {}

    # Signaled when this checkpoint becomes the next checkpoint that `agent`s need to pass for the first time.
    # Sends the first `agent` who is now targeting this checkpoint.
    CheckpointBecomesCurrentForTheFirstTimeEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` passes this checkpoint.
    # Sends the `agent` that passed this checkpoint.
    CheckpointCompletedEvent<public>: listenable(agent) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Sets this checkpoint as the current checkpoint for `Agent`. This only functions if `Agent` has not already passed this checkpoint.
    SetAsCurrentCheckpoint<public>(Agent: agent): void = external {}
  }

  # Used with the `race_checkpoint_device` to create more advanced racing modes.
  race_manager_device<public> := class<concrete><final>(creative_device_base) {
    # Begins the race.
    Begin<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Ends the race.
    End<public>(): void = external {}

    # Signaled when an `agent` completes their first lap.
    # Sends the `agent` that finished the lap.
    FirstLapCompletedEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` completes a lap.
    # Sends the `agent` that finished the lap.
    LapCompletedEvent<public>: listenable(agent) = external {}

    # Signaled when the race begins.
    # Sends the `agent` that started the race.
    RaceBeganEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` finishes the race.
    # Sends the `agent` that finished the race.
    RaceCompletedEvent<public>: listenable(agent) = external {}
  }

  # Used to play curated music from the device or one or more registered `agent`s.
  radio_device<public> := class<concrete><final>(creative_device_base) {
    # Hides this device from the world.
    Hide<public>()<transacts>: void = external {}

    # Starts playing audio from this device.
    Play<public>(): void = external {}

    # Adds the specified agent as a target for the Radio to play audio from
    Register<public>(Agent: agent): void = external {}

    # Shows this device in the world.
    Show<public>()<transacts>: void = external {}

    # Stops playing audio from this device.
    Stop<public>(): void = external {}

    # Removes the specified agent as a target for the Radio to play audio from if previously Registered
    Unregister<public>(Agent: agent): void = external {}

    # Removes all previously registered agents as targets for the Radio to play audio from
    UnregisterAll<public>(): void = external {}
  }

  # Used to trigger in game events based on real world time.
  real_time_clock_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Signaled when the optional second *Duration* time has been reached.
    DurationElapsedEvent<public>: listenable(tuple()) = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when this device is enabled after the target time has been reached.
    EnablingAfterTimeReachedEvent<public>: listenable(tuple()) = external {}

    # Signaled when this device is enabled before the target time has been reached.
    EnablingBeforeTimeReachedEvent<public>: listenable(tuple()) = external {}

    # Signaled when the target time is reached.
    TimeReachedEvent<public>: listenable(tuple()) = external {}
  }

  reboot_card_purchase_options<public> := class<concrete><final> {
    # Determines if players can purchase a reboot card when the timer has expired.
    var CanPurchaseExpiredRebootCard<public>: logic = external {}

    # Determines how much of the set currency it costs to purchase an eliminated player's reboot card. Clamped between `0` and `99999`.
    var CostToPurchaseRebootCard<public>: int = external {}

    # Determines if the item's rarity is displayed to the player if they are missing resources.
    var ShowItemRarityOnInteractPrompt<public>: logic = external {}
  }

  reboot_progress_decay_behavior<public> := enum<open> {
    # Use Battle Royale's decay rate.
    (/Fortnite.com/Devices/reboot_progress_decay_behavior:)BattleRoyale

    # Set a custom multiplier on the decay rate.
    CustomDecay

    # Instantly reset progress to zero.
    InstantReset
  }

  # Allow players to bring eliminated teammates back into the game.
  reboot_van_device<public> := class<concrete><final>(creative_device_base, reboot_van_interface) {
    # Disable the device.
    DisableReboot<override>(): void = external {}

    # Enable the device.
    EnableReboot<override>(): void = external {}

    # Succeeds if the device is enabled, fails if it's disabled.
    IsEnabledReboot<override>()<transacts><decides>: void = external {}

    # Triggers when a player purchases a Reboot Card.
    #  * `agent` is the player that purchased the Reboot Card.
    RebootCardPurchaseEvent<override>: listenable(agent) = external {}

    # Triggers when Reboot Van has finished rebooting a set of players.
    #  * `agent`is the player that started the reboot.
    RebootEvent<override>: listenable(agent) = external {}

    # Triggers when Reboot Van has finished recharging.
    #  * `agent` is the last interacting player.
    RechargeCompleteEvent<override>: listenable(?agent) = external {}

    # Determines if players can purchase an eliminated player's reboot card.
    var CanPurchaseRebootCard<override>: logic = external {}

    # Multiplier on the decay rate of reboot progress. Clamped between `0.1` and `2.0`.
    #  * Only used if `RebootProgressDecay` is set to `Custom Decay`.
    var DecayRateMultiplier<override>: ?float = external {}

    # Purchase reboot card options.
    #  * Only used if `CanPurchaseRebootCard` is `true`.
    var PurchaseRebootCardOptions<override>: ?reboot_card_purchase_options = external {}

    # How quickly reboot progress decays when nobody is interacting with the Reboot Van. Custom Decay - Set a custom multiplier on the decay rate. Instant Reset - Instantly reset progress to zero. Battle Royale - Use Battle Royale's decay rate.
    var RebootProgressDecay<override>: reboot_progress_decay_behavior = external {}

    # The remaining time (in seconds) on the recharge timer. Clamped between `0.0` and `3600.0`.
    #  * If there is no active timer, getting returns `0.0`.
    #  * If there is no active timer, setting does nothing.
    var RechargeTimer<override>: float = external {}

    # The length of the recharge timer in seconds, regardless of the timer's current state. Clamped between `0.0` and `3600.0`.
    var RechargeTimerLength<override>: float = external {}
  }

  reboot_van_interface<public> := interface<epic_internal> {
    # Disable the device.
    DisableReboot<public>(): void

    # Enable the device.
    EnableReboot<public>(): void

    # Succeeds if the device is enabled, fails if it's disabled.
    IsEnabledReboot<public>()<transacts><decides>: void

    # Triggers when a player purchases a Reboot Card.
    #  * `agent` is the player that purchased the Reboot Card.
    RebootCardPurchaseEvent<public>: listenable(agent)

    # Triggers when Reboot Van has finished rebooting a set of players.
    #  * `agent`is the player that started the reboot.
    RebootEvent<public>: listenable(agent)

    # Triggers when Reboot Van has finished recharging.
    #  * `agent` is the last interacting player.
    RechargeCompleteEvent<public>: listenable(?agent)

    # Determines if players can purchase an eliminated player's reboot card.
    var CanPurchaseRebootCard<public>: logic

    # Multiplier on the decay rate of reboot progress. Clamped between `0.1` and `2.0`.
    #  * Only used if `RebootProgressDecay` is set to `Custom Decay`.
    var DecayRateMultiplier<public>: ?float

    # Purchase reboot card options.
    #  * Only used if `CanPurchaseRebootCard` is `true`.
    var PurchaseRebootCardOptions<public>: ?reboot_card_purchase_options

    # How quickly reboot progress decays when nobody is interacting with the Reboot Van. Custom Decay - Set a custom multiplier on the decay rate. Instant Reset - Instantly reset progress to zero. Battle Royale - Use Battle Royale's decay rate.
    var RebootProgressDecay<public>: reboot_progress_decay_behavior

    # The remaining time (in seconds) on the recharge timer. Clamped between `0.0` and `3600.0`.
    #  * If there is no active timer, getting returns `0.0`.
    #  * If there is no active timer, setting does nothing.
    var RechargeTimer<public>: float

    # The length of the recharge timer in seconds, regardless of the timer's current state. Clamped between `0.0` and `3600.0`.
    var RechargeTimerLength<public>: float
  }

  # The Rift Point volume is used to interface with and manage the Rift Point item,
  # and provides an area that enables players to plant the item to create search and destroy style gameplay.
  rift_point_volume_device<public> := class<concrete><final>(creative_device_base, enableable) {
    # Sends an event when defusing the Rift Point is canceled, passing in the defusing `agent`.
    DefuseCancelEvent<public>: listenable(agent) = external {}

    # Sends an event when the Rift Point is defused, passing in the defusing `agent`.
    DefuseEvent<public>: listenable(agent) = external {}

    # Sends an event when defusing the Rift Point is started, passing in the defusing `agent`.
    DefuseStartEvent<public>: listenable(agent) = external {}

    # Sends an event when the Rift Point detonates, passing in the planting `agent`.
    DetonateEvent<public>: listenable(agent) = external {}

    # Disables the device, preventing the Rift Point from being planted.
    Disable<override>(): void = external {}

    # Enables the device, allowing the Rift Point to be planted.
    Enable<override>(): void = external {}

    # Returns an array of agents that are currently occupying the volume.
    GetAgentsInVolume<public>()<reads>: []agent = external {}

    # Succeeds if the component is enabled, fails if it’s disabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Is true when `Agent` is in the volume.
    IsInVolume<public>(Agent: agent)<transacts><decides>: void = external {}

    # Sends an event when an `agent` enters the volume.
    OnAgentEntered<public>: listenable(agent) = external {}

    # Sends an event when an `agent` exits the volume.
    OnAgentExited<public>: listenable(agent) = external {}

    # Sends an event when planting the Rift Point is canceled, passing in the planting `agent`.
    PlantCancelEvent<public>: listenable(agent) = external {}

    # Sends an event when the Rift Point is planted, passing in the planting `agent`.
    PlantEvent<public>: listenable(agent) = external {}

    # Sends an event when planting the Rift Point is started, passing in the planting `agent`.
    PlantStartEvent<public>: listenable(agent) = external {}
  }

  # Used to generate random numbers between a minimum and maximum value. Events are signaled when numbers are generated.
  #  * *Value Limit 1* is the minimum value for generation.
  #  * *Value Limit 2* is the maximum value for generation.
  rng_device<public> := class<concrete><final>(creative_device_base) {
    # Randomly roll a number within the configured min + max value range.
    #  * If the number is >= *Winning Value* then `WinEvent` is fired.
    #  * If the number is < *Winning Value* then `LoseEvent` is fired.
    #  * If the number = minimum then `RolledMinEvent` is fired.
    #  * If the number = maximum then `RolledMaxEvent` is fired.
    Activate<public>(): void = external {}

    # Randomly generate a number between *Value Limit 1* and *Value Limit 2*.
    #  * If the number is >= *Winning Value* then `WinEvent` is fired.
    #  * If the number is < *Winning Value* then `LoseEvent` is fired.
    #  * If the number = minimum then `RolledMinEvent` is fired.
    #  * If the number = maximum then `RolledMaxEvent` is fired.
    #  * `Agent` is used as the Instigator of the roll event.
    Activate<public>(Agent: agent): void = external {}

    # Cancels the active number generation.
    Cancel<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when the generated number < *Winning Value*.
    LoseEvent<public>: listenable(tuple()) = external {}

    # Signaled when the generated number = maximum.
    RolledMaxEvent<public>: listenable(tuple()) = external {}

    # Signaled when the generated number = minimum.
    RolledMinEvent<public>: listenable(tuple()) = external {}

    # Signaled when the generated number >= *Winning Value*.
    WinEvent<public>: listenable(tuple()) = external {}
  }

  # Roly Poly spawned from the 'roly_poly_spawner_device'
  roly_poly<public> := class<concrete><final>(positional, healthful, healable, damageable) {
    # Damage the Roly Poly anonymously by 'Amount'. Setting 'Amount' to less than 0 will cause no damage.
    # Use 'Damage(:damage_args):void' when damage is being applied from a known instigator and source.
    # Damage caused by events will not cause players to be bucked from the Roly Poly.
    Damage<override>(Amount: float): void = external {}

    # Damage the Roly Poly by 'Args.Amount'. Setting 'Amount' to less than 0 will cause no damage.
    # Damage caused by events will not cause players to be bucked from the Roly Poly.
    Damage<override>(Args: damage_args): void = external {}

    # Signaled when damage is applied to the Roly Poly.
    DamagedEvent<override>(): listenable(damage_result) = external {}

    # Returns the health state of the Roly Poly. This value will be between 0.0 and 'GetMaxHealth'
    GetHealth<override>()<transacts>: float = external {}

    # Returns the maximum health of the Roly Poly. This value will be between 1.0 and 9999.0.
    GetMaxHealth<override>()<transacts>: float = external {}

    # Returns the transform of the Roly Poly
    GetTransform<override>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)transform = external {}

    # Heal the Roly Poly anonymously by 'Amount'. Setting 'Amount' to less than 0 will cause no healing.
    # Use 'Heal(:healing_args):void' when healing is being applied from a known instigator and source.
    Heal<override>(Amount: float): void = external {}

    # Heal the Roly Poly by 'Args.Amount'. Setting 'Amount' to less than 0 will cause no healing.
    Heal<override>(Args: healing_args): void = external {}

    # Signaled when healing is applied to the Roly Poly.
    HealedEvent<override>(): listenable(healing_result) = external {}

    # Set the Frightened status of the Roly Poly.
    #  * Setting to true will frighten the Roly Poly.
    #  * Setting to false will soothe the Roly Poly.
    #  * An 'agent' can be provided and will be passed back as the signaled events 'agent'.
    #  * Depending on the state the Roly Poly is in, it may take a few seconds for the FrightenedEvent to be signaled. Ex. When a player is in the Roly Poly, it will buck the player and enter the frightened state when it lands on solid ground.
    SetFrightened<public>(Frightened: logic, Agent: ?agent): void = external {}

    # Sets the health state of the Roly Poly to 'Health'.
    #  * Health state will be clamped between 1.0 and 'GetMaxHealth'.
    #  * Health state cannot be directly set to 0.0. To eliminate the Roly Poly, use the 'Dismiss' function on the spawner instead.
    SetHealth<override>(Health: float)<transacts>: void = external {}

    # Sets the maximum health state of the Roly Poly.
    #  * MaxHealth will be clamped between 1.0 and 9999.0.
    #  * Current health state will be scaled up or down based on the scale difference between the old and new MaxHealth state.
    SetMaxHealth<override>(MaxHealth: float)<transacts>: void = external {}

    # Set/Get the Energy level of the spawned Roly Poly.
    # Energy will be clamped to 0 - 100.
    var Energy<public>: float = external {}
  }

  # Device for spawning a Roly Poly
  roly_poly_spawner_device<public> := class<concrete><final>(creative_device_base, enableable) {
    # Disable the spawner: dismiss the active Roly Poly (if 'DismissOnDisabled' is true) and prevent any further spawns.
    # Any pending respawn timers are cancelled.
    Disable<override>(): void = external {}

    # Dismiss the active Roly Poly if present.
    # If 'AutomaticRespawn' is true, a respawn timer for 'RespawnDelay' seconds will be created.
    Dismiss<public>(): void = external {}

    # Signaled when an 'agent' exits a spawned Roly Poly.
    # Sends the 'agent' that exited the Roly Poly.
    DismountEvent<public>: listenable(agent) = external {}

    # Enable the spawner. While enabled, the spawner maintains at most one active Roly Poly.
    Enable<override>(): void = external {}

    # Signaled when a spawned Roly Poly flees.
    FleeEvent<public>: listenable(tuple()) = external {}

    # Signaled when an 'agent' causes the spawned Roly Poly to curl up and hide.
    FrightenEvent<public>: listenable(?agent) = external {}

    GetActiveRolyPoly<public>()<transacts><decides>: ?roly_poly = external {}

    # Succeeds if the Spawner is enabled, fails if it's disabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Attempt to set 'agent' as the spawned Roly Poly's rider.
    Ride<public>(Agent: agent): void = external {}

    # Signaled when an 'agent' enters a spawned Roly Poly.
    # Sends the 'agent' that entered the Roly Poly.
    RideEvent<public>: listenable(agent) = external {}

    # Signaled when an 'agent' causes the spawned Roly Poly to open up after being scared.
    SootheEvent<public>: listenable(?agent) = external {}

    # Spawn a Roly Poly now. If one is active, dismiss it first, then spawn.
    # If the spawner is disabled, this call does nothing.
    Spawn<public>(): void = external {}

    # Signaled when a Roly Poly is spawned or respawned by this device.
    SpawnEvent<public>: listenable(tuple()) = external {}

    # If true, when a Roly Poly flees while the spawner is enabled, a new one will spawn after RespawnDelay.
    var AutomaticRespawn<public>: logic = external {}

    # Determines if the Roly Poly will remove the player when it takes damage.
    var BuckPlayerWhenDamaged<public>: logic = external {}

    # Determines if the Roly Poly will curl up and hide when attacked.
    var CanBeFrightened<public>: logic = external {}

    # If true, disabling the spawner immediately dismisses the active roly poly.
    var DismissOnDisabled<public>: logic = external {}

    # Determines if Roly Poly will take damage when hit.
    var Invulnerable<public>: logic = external {}

    # Determines how much damage the Roly Poly will take before fleeing.
    var MaxHealth<public>: float = external {}

    # Seconds to wait before respawning after a flee when AutomaticRespawn is true.
    var RespawnDelay<public>: float = external {}

    # Determines if frightened Roly Poly will open up on its own.
    var SelfSootheEnabled<public>: logic = external {}

    # Determines the time in seconds that the Roly Poly will stay curled up and hide before opening up on its own.
    var SelfSootheTime<public>: float = external {}

    # Determines the time in seconds that the player needs to soothe the Roly Poly before it opens up.
    var SootheTime<public>: float = external {}

    # If not Never, enabling the spawner immediately spawns a Roly Poly, IfNone will only spawn there is no active Roly Poly.
    var SpawnOnEnabled<public>: spawn_on_enable_behavior = external {}

    # Determines if the Roly Poly will spawn in curled up.
    var StartFrightened<public>: logic = external {}

    # Determines the amount of energy the Roly Poly will spawn with.
    var StartingEnergy<public>: float = external {}

    # Determines if the Roly Poly will get tired and leave after rolling around.
    var UnlimitedEnergy<public>: logic = external {}
  }

  # Used to customize gameplay for any round-based game. It generally defines what happens to the`agent`'s inventory and rewards in each round.
  round_settings_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Disables all end-round conditions. The round must be ended through calling `EndRound` or a creative event after this is called.
    DisableEndRoundConditions<public>(): void = external {}

    # Disables the ability for players to Matchmake into the Island. Only applies to published games that have matchmaking turned on in the Island settings
    DisableMatchmaking<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Enables the ability for players to Matchmake into the Island. Only applies to published games that have matchmaking turned on in the Island settings
    EnableMatchmaking<public>(): void = external {}

    # Ends the round immediately with `Agent`'s team set as the winner of the round.
    EndRound<public>(Agent: agent): void = external {}

    # Signaled when a game round starts.
    RoundBeginEvent<public>: listenable(tuple()) = external {}

    # Toggles between `EnableMatchmaking` and `DisableMatchmaking`.
    ToggleMatchmaking<public>(): void = external {}
  }

  # Used to manipulate scores using in-experience triggers. If *Activating Team* is set to a specific team, then you should use the `agent` overloads of each function. The `agent`'s team will be used to determine if that `agent` is allowed to affect the state of the device.
  score_manager_device<public> := class<concrete><final>(creative_device_base) {
    # Grants points.
    Activate<public>(): void = external {}

    # Grant points to `Agent`.
    Activate<public>(Agent: agent): void = external {}

    # Decrements the score quantity to be awarded by the next activation by `1`.
    Decrement<public>(): void = external {}

    # Decrements the score quantity to be awarded by the next activation by `1`.
    Decrement<public>(Agent: agent): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Disables this device.
    Disable<public>(Agent: agent): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Enables this device.
    Enable<public>(Agent: agent): void = external {}

    # Returns the current score for `Agent`.
    GetCurrentScore<public>(Agent: agent)<transacts>: int = external {}

    # Returns the score to be awarded by the next activation.
    GetScoreAward<public>()<transacts>: int = external {}

    # Increments the score quantity to be awarded by the next activation by `1`.
    Increment<public>(): void = external {}

    # Increments the score quantity to be awarded by the next activation by `1`.
    Increment<public>(Agent: agent): void = external {}

    # Signaled when the this device reaches its maximum number of triggers as defined by *Times Can Trigger*.
    # Sends the `agent` who last triggered the device.
    MaxTriggersEvent<public>: listenable(agent) = external {}

    # Resets this device to its original state.
    (/Fortnite.com/Devices/score_manager_device:)Reset<public>(): void = external {}

    # Resets this device to its original state.
    (/Fortnite.com/Devices/score_manager_device:)Reset<public>(Agent: agent): void = external {}

    # Signaled when the this device awards points to an `agent`.
    # Sends the `agent` who received the points.
    ScoreOutputEvent<public>: listenable(agent) = external {}

    # Sets the score to be awarded by the next activation to `Value`.
    SetScoreAward<public>(Value: int): void = external {}

    # Sets the score to be awarded by the next activation to `Agent`'s current score.
    SetToAgentScore<public>(Agent: agent): void = external {}
  }

  # A boss-like environmental encounter that will attack players with different abilities
  scout_spire_device<public> := class<concrete><final>(creative_device_base, has_spire_functionality) {
    # Triggers when the Spire becomes activated from players entering the `Activation Distance`
    ActivateEvent<override>: listenable(?agent) = external {}

    # Triggers when the Spire begins its laser attack
    BeginChargeLaserEvent<public>: listenable(tuple()) = external {}

    # Triggers when the Spire becomes deactivated, either from players leaving the `Activation Distance`
    DeactivateEvent<override>: listenable(tuple()) = external {}

    # Hides the spire immediately without playing any vfx
    #  * Does nothing if the Spire is already destroyed or despawned.
    Despawn<public>(): void = external {}

    # Sets the Spire's health to zero, destroying it.
    #  *  Does nothing if the Spire has not spawned or is already destroyed.
    Destroy<override>(): void = external {}

    # Triggers when the Spire is destroyed from damage or events
    #  * Includes the `agent` that destroyed it, if any.
    DestroyEvent<override>: listenable(?agent) = external {}

    # Disable the device which causes the Spire to become deactivated, stopping the behaviors and attacks, as well as preventing activation when players are within the `Activation Distance`.
    #  * Does nothing if the Spire is destroyed or already disabled.
    Disable<override>(): void = external {}

    # Enable the device, causing the Spire to become activated when players are within the `Activation Distance`.
    #  * Does nothing if the Spire is destroyed or already enabled.
    Enable<override>(): void = external {}

    # Triggers when the Spire shoots its laser attack. Triggers once, even if it shoots at multiple targets
    EndChargeAndFireLaserEvent<public>: listenable(tuple()) = external {}

    # If this Spire is currently activated.
    #  * Succeeds if activated. Fails if deactivated
    #  * An activated Spire will react to enemies and take damage * Becomes activated from being enabled and players entering the `Activation Distance`
    IsActivated<override>()<transacts><decides>: void = external {}

    # Succeeds if this Spire's health has reached 0. Fails otherwise.
    IsDestroyed<override>()<transacts><decides>: void = external {}

    # Succeeds if the Spire is enabled and fails if it is disabled.
    #  * While disabled, the Spire is inactive: it will not react to players or take damage.
    #  * If the Spire is currently despawned, this function instead reports the enabled state the Spire will have the next time it is spawned.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Succeeds if this Spire is in a spawned state. Fails if the Spire is destroyed or has not spawned.
    IsSpawned<override>()<transacts><decides>: void = external {}

    # Resets the Spire to its initial state.
    (/Fortnite.com/Devices/has_spire_functionality:)Reset<override>(): void = external {}

    # Spawns the Spire, causing it to become visible and enabling collision
    #  *  Does nothing if the Spire is already spawned or destroyed.
    Spawn<override>(): void = external {}

    # Determines the distance where approaching players activate the Spire.
    #  * Values are clamped between `500.0` and `10000.0` cm
    var ActivationDistance<override>: float = external {}

    # The Spire's current health. Clamped between 0 and `MaxHealth`.
    #  * Setting this value does nothing if the Spire is destroyed.
    var Health<override>: float = external {}

    # If the invulnerable shield for this Spire is active. While active, the Spire cannot take damage.
    #  * Setting this value does nothing if the Spire is destroyed.
    var IsShieldActive<public>: logic = external {}

    # Determines the additive vertical force of the impulse applied to targets of the laser attack.
    #  * Values are clamped between `0.0` and `10000.0`
    var LaserAdditionalVerticalImpulseForce<public>: float = external {}

    # Determines how much total damage the laser attack does to buildings.
    #  * Values are clamped between `0.0` and `10000.0`
    var LaserAttackDamageToBuildings<public>: float = external {}

    # Determines how much total damage the laser attack does to creatures.
    #  * Values are clamped between `0.0` and `10000.0`
    var LaserAttackDamageToCreatures<public>: float = external {}

    # Determines how much total damage the laser attack does to guards.
    #  * Values are clamped between `0.0` and `10000.0`
    var LaserAttackDamageToGuards<public>: float = external {}

    # Determines how much total damage the laser attack does to players.
    #  * Values are clamped between `0.0` and `10000.0`
    var LaserAttackDamageToPlayers<public>: float = external {}

    # Determines how much total damage the laser attack does to vehicles.
    #  * Values are clamped between `0.0` and `10000.0`
    var LaserAttackDamageToVehicles<public>: float = external {}

    # Determines how much total damage the laser attack does to wildlife.
    #  * Values are clamped between `0.0` and `10000.0`
    var LaserAttackDamageToWildlife<public>: float = external {}

    # Determines the time it takes for the Spire to charge up its laser attack.
    #  * Values are clamped between `0.5` and `60.0`
    var LaserChargeTime<public>: float = external {}

    # Determines the amount of time that the Spire must wait to use the laser attack after previously using it.
    #  * Values are clamped between `0.5` and `60.0`
    var LaserCooldownTime<public>: float = external {}

    # Determines the radius of the blast from where the laser hits.
    #  * Values are clamped between `100.0` and `1000.0`
    var LaserEffectRadius<public>: float = external {}

    # Determines the multiplicative horizontal force of the impulse applied to targets of the laser attack based on distance.
    #  * Values are clamped between `0.0` and `10000.0`
    var LaserHorizontalImpulseForce<public>: float = external {}

    # Determines the multiplicative vertical force of the impulse applied to targets of the laser attack based on distance.
    #  * Values are clamped between `0.0` and `10000.0`
    var LaserVerticalImpulseForce<public>: float = external {}

    # Determines the number of targets the Spire can shoot lasers at per charged attack.
    #  * Values are clamped between `1` and `50`
    var LasersPerCharge<public>: int = external {}

    # The maximum health of this Spire.
    var MaxHealth<override>: float = external {}

    # Determines if a Spire-specific icon should be displayed on the map while the Spire is spawned.
    var ShowMapIcon<override>: logic = external {}
  }

  # Generates an AI bot that spawns in a location and usually attacks players when they come in range.
  sentry_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when the sentry is alerted to an `agent`.
    # Sends the `agent` who alerted the sentry.
    AlertedEvent<public>: listenable(agent) = external {}

    # Signaled when a sentry attacks an `agent`.
    # Sends the `agent` who is being attacked.
    AttackingEvent<public>: listenable(agent) = external {}

    # Destroys the current sentry.
    DestroySentry<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Signaled when a sentry is eliminated.
    # Sends the `agent` that eliminated the sentry. If the sentry was eliminated by a non-agent then `false` is returned.
    EliminatedEvent<public>: listenable(?agent) = external {}

    # Signaled when the sentry eliminates a creature.
    EliminatingACreatureEvent<public>: listenable(tuple()) = external {}

    # Signaled when a sentry eliminates an `agent`.
    # Sends the `agent` who was eliminated by the sentry.
    EliminatingAgentEvent<public>: listenable(agent) = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Puts the sentry into the alert state.
    EnableAlert<public>(): void = external {}

    # Signaled when the sentry enters the alert state.
    EntersAlertCooldownEvent<public>: listenable(tuple()) = external {}

    # Signaled when the sentry exists the alert state.
    ExitsAlertEvent<public>: listenable(tuple()) = external {}

    # Sets the sentry to the same team `Agent` is on.
    JoinTeam<public>(Agent: agent): void = external {}

    # Puts the sentry into the pacify state, preventing from entering the alert (attacking) state.
    Pacify<public>(): void = external {}

    # Resets the alert state.
    ResetAlertCooldown<public>(): void = external {}

    # Resets the sentry to the original team designated in the device options.
    ResetTeam<public>(): void = external {}

    # Spawns the sentry.
    Spawn<public>(): void = external {}

    # Sets the sentry to target `Agent`. The sentry will not target agents on the same team as the sentry.
    Target<public>(Agent: agent): void = external {}
  }

  using { /Fortnite.com/Vehicles }
  # A one stop automated refueling and repairing station for your vehicles.
  service_station_device<public> := class<concrete><final>(creative_device_base, healthful, damageable, enableable) {
    # Damage the `damageable` object anonymously by `Amount`. Setting `Amount` to less than 0 will cause no damage.
    # Use `Damage(:damage_args):void` when damage is being applied from a known instigator and source.
    Damage<override>(Amount: float): void = external {}

    # Damage the `damageable` object by `Args.Amount`. Setting `Amount` to less than 0 will cause no damage.
    Damage<override>(Args: damage_args): void = external {}

    # Signaled when damage is applied to the `damageable` object.
    DamagedEvent<override>(): listenable(damage_result) = external {}

    # Disable this object.
    Disable<override>(): void = external {}

    # Enable this object.
    Enable<override>(): void = external {}

    # Returns the health state of the object. This value will between 0.0 and `GetMaxHealth`
    GetHealth<override>()<transacts>: float = external {}

    # Returns the maximum health of the object. This value will be between 1.0 and Inf.
    GetMaxHealth<override>()<transacts>: float = external {}

    # Check if any vehicle is inside the service station.
    IsAnyVehicleInside<public>()<transacts><decides>: void = external {}

    # Succeeds if the object is enabled, fails if it's disabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Sets the health state of the object to `Health`.
    #  * Health state will be clamped between 1.0 and `GetMaxHealth`.
    #  * Health state cannot be directly set to 0.0. To eliminate `healthful` objects use the `damageable.Damage` functions instead.
    SetHealth<override>(Health: float)<transacts>: void = external {}

    # Sets the maximum health state of the object.
    #  * MaxHealth will be clamped between 1.0 and Inf.
    #  * Current health state will be scaled up or down based on the scale difference between the old and new MaxHealth state.
    SetMaxHealth<override>(MaxHealth: float)<transacts>: void = external {}

    # Fires when a vehicle enters the service station, returns the vehicle that entered.
    VehicleEnteredEvent<public>: listenable(fort_vehicle) = external {}

    # Fires when a vehicle leaves the service station, returns the vehicle that exited.
    VehicleExitedEvent<public>: listenable(fort_vehicle) = external {}

    # Fires on the first tick of a vehicle refueling, returns the refueled vehicle.
    VehicleFuelingBeginEvent<public>: listenable(fort_vehicle) = external {}

    # Fires when a vehicle is at full fuel, returns the refueled vehicle.
    VehicleFuelingEndEvent<public>: listenable(fort_vehicle) = external {}

    # Fires when a vehicle starts repairing, returns the repaired vehicle.
    VehicleRepairBeginEvent<public>: listenable(fort_vehicle) = external {}

    # Fires when a vehicle is at full health, returns the repaired vehicle.
    VehicleRepairEndEvent<public>: listenable(fort_vehicle) = external {}
  }

  # A single customizable pop up target that can be hit by `agent`s to trigger various events.
  shooting_range_target_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when the target is hit in the bullseye area.
    BullseyeHitEvent<public>: listenable(tuple()) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when the target is hit by an `agent`.
    HitEvent<public>: listenable(tuple()) = external {}

    # Moves an active (standing upright) target down slightly, in an effort to make it harder to hit.
    HopDown<public>(): void = external {}

    # Signaled when the target moves down slightly, making it harder to hit.
    HopDownEvent<public>: listenable(tuple()) = external {}

    # Moves an active (standing upright) target up slightly, in an effort to make it harder to hit.
    HopUp<public>(): void = external {}

    # Signaled when the target moves up slightly, making it harder to hit.
    HopUpEvent<public>: listenable(tuple()) = external {}

    # Signaled when the target takes enough damage to get knocked down.
    KnockdownEvent<public>: listenable(tuple()) = external {}

    # Causes a target to transition from standing upright (active) to lying flat (inactive).
    PopDown<public>(): void = external {}

    # Signaled when the target moves from standing upright to laying flat.
    PopDownEvent<public>: listenable(tuple()) = external {}

    # Causes a target to transition from lying flat (inactive) to standing upright (active).
    PopUp<public>(): void = external {}

    # Signaled when the target moves from laying flat to standing upright.
    PopUpEvent<public>: listenable(tuple()) = external {}

    # Resets the target to its initial settings.
    (/Fortnite.com/Devices/shooting_range_target_device:)Reset<public>(): void = external {}
  }

  # A set of customizable pop up targets that can be hit by players to trigger various events.
  shooting_range_target_track_device<public> := class<concrete><final>(creative_device_base) {
    # Activates the movement track.
    ActivateTrack<public>(): void = external {}

    # Signaled when target is hit in the bullseye area.
    BullseyeHitEvent<public>: listenable(tuple()) = external {}

    # Deactivates the movement track.
    DeactivateTrack<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Disables movement on the track. This prevents any movement from occurring, until track movement is enabled again.
    DisableTrackMovement<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Enables movement on the track. This does not start the target moving, it only enables movement.
    EnableTrackMovement<public>(): void = external {}

    # Signaled when the target is hit by a player.
    HitEvent<public>: listenable(tuple()) = external {}

    # Moves an active (standing upright) target attached to the track down slightly, in an effort to make it harder to hit
    HopDown<public>(): void = external {}

    # Signaled when the target moves down slightly, making it harder to hit.
    HopDownEvent<public>: listenable(tuple()) = external {}

    # Moves an active (standing upright) target attached to the track up slightly, in an effort to make it harder to hit
    HopUp<public>(): void = external {}

    # Signaled when the target moves up slightly, making it harder to hit.
    HopUpEvent<public>: listenable(tuple()) = external {}

    # Signaled when the target is hit by a player.
    KnockdownEvent<public>: listenable(tuple()) = external {}

    # Starts the target moving toward the end of the track.
    MoveToEnd<public>(): void = external {}

    # Starts the target moving toward the start of the track.
    MoveToStart<public>(): void = external {}

    # Causes the target attached to the track to transition from standing upright (active) to lying flat (inactive)
    PopDown<public>(): void = external {}

    # Signaled when the target moves from standing upright to laying flat.
    PopDownEvent<public>: listenable(tuple()) = external {}

    # Causes the target attached to the track to transition from lying flat (inactive) to standing upright (active)
    PopUp<public>(): void = external {}

    # Signaled when the target moves from laying flat to standing upright.
    PopUpEvent<public>: listenable(tuple()) = external {}

    # Resets the target to its initial settings.
    (/Fortnite.com/Devices/shooting_range_target_track_device:)Reset<public>(): void = external {}
  }

  # Used to trigger a custom response to a *Primary* or *Secondary* signal, sent by a *Signal Remote* item.
  signal_remote_manager_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when a player has triggered the *Primary* signal using a *Signal Remote* item.
    # Sends the `agent` that triggered the signal.
    PrimarySignalEvent<public>: listenable(agent) = external {}

    # Signaled when a player has triggered the *Secondary* signal using a *Signal Remote* item.
    # Sends the `agent` that triggered the signal.
    SecondarySignalEvent<public>: listenable(agent) = external {}
  }

  # Used to create a minigame which expects specific input timing from the player.
  # Visuals may vary, but always feature a scrubber that moves from 0.0 to 1.0.
  # Good and perfect zones are defined on the device, describing at what point the player must provide input to succeed.
  skilled_interaction_device<public> := class<concrete><final>(creative_device_base, enableable) {
    # Signaled when the `agent` moves from the queue into interacting.
    #  An agent enters the queue if BeginInteract is called for them but there is no room for them to begin an interaction given the current configuration.
    #  This event will fire when an agent who is waiting in that queue advances from it and begins an interaction, removing it from the queue
    AdvanceAgentFromQueueEvent<public>: listenable(agent) = external {}

    # Signaled when the `agent` provides a bad input.
    # Bad input occurs when input is provided while the scrubber is outside the *Good Zone*.
    # Sends the `agent` that provided the input.
    # Sends the `float` position of the meter scrubber from `0.0` to `1.0`.
    BadInputTriggeredEvent<public>: listenable(tuple(agent, float)) = external {}

    # Begins the interaction for the provided `agent`.
    # Will cancel any other interactions already in progress for the `agent` if a queue is not being utilized.
    # If a queue is being utilized and duplicate player entries are not allowed then any duplicate player entries in the queue will not be added.
    # If the number of agents requesting interact fits into the current interaction configuration, then those agents will begin
    # interact immediately and skip the queue entirely.
    BeginInteraction<public>(Agent: agent)<transacts><decides>: void = external {}

    # Begins the interaction for the provided `agent`(s).
    # Will cancel any other interactions already in progress for the `agent` if a queue is not being utilized.
    # If a queue is being utilized and duplicate player entries are not allowed then any duplicate player entries in the queue will not be added.
    # If the number of agents requesting interact fits into the current interaction configuration, then those agents will begin
    # interact immediately and skip the queue entirely.
    BeginInteraction<public>(Agents: []agent)<transacts><decides>: void = external {}

    # Clears the queue of all `agent`(s).
    #  Returns an array of all the players that were still in the queue.
    ClearQueue<public>(): []agent = external {}

    # Disable this device.
    Disable<override>(): void = external {}

    # Fired when the queue empties of all queued agents.
    #  The queue has to have at least one agent in it for this to fire.
    #  If BeginInteraction is called and a queue is not created, then this event will not be triggered.
    EmptyQueueEvent<public>: listenable(tuple()) = external {}

    # Enable this device.
    Enable<override>(): void = external {}

    # Cancels the interaction, if in progress, for the provided `agent`.
    # Does not clear the queue of any agent awaiting interaction
    EndInteraction<public>(Agent: agent)<transacts><decides>: void = external {}

    # Cancels the interaction, if in progress, for the provided `agent`(s).
    # Does not clear the queue of any agent awaiting interaction
    EndInteraction<public>(Agents: []agent)<transacts><decides>: void = external {}

    # Gets the `agent`(s) who are currently interacting
    GetInteractingAgents<public>(): []agent = external {}

    # Gets the queue of `agent`(s) who are awaiting interaction.
    GetQueue<public>(): []agent = external {}

    # Signaled when the `agent` provides a good input.
    # Good input occurs when input is provided while the scrubber is within the *Good Zone* (excluding the *Perfect Zone*).
    # Sends the `agent` that provided the input.
    # Sends the `float` position of the meter scrubber from `0.0` to `1.0`.
    GoodInputTriggeredEvent<public>: listenable(tuple(agent, float)) = external {}

    # Signaled when the interaction is interrupted.
    # The interaction can be interrupted in several ways.
    # * If the participating `agent` is eliminated or enters a downed state.
    # * If *Deactivate* is called while the interaction is in progress.* If *Disable* is called while the interaction is in progress.
    InteractionCanceledEvent<public>: listenable(agent) = external {}

    # Signaled when the `agent` fails the interaction.
    # The interaction can be failed in several ways
    # * If the number of bad inputs reaches the *Failure Limit*.
    # * If the interaction has an *Interaction Time Limit* that expires.
    InteractionFailedEvent<public>: listenable(agent) = external {}

    # Signaled when the `agent` starts an interaction.
    # Input is the `agent` which started interacting with the device.
    InteractionStartedEvent<public>: listenable(agent) = external {}

    # Signaled when the `agent` succeeds at the interaction.
    # The interaction is completed depending on the device's configuration.
    # * Once the device's *Success Target* is reached.
    # * Upon a perfect input if using *Instant Success Perfect Behavior*.
    InteractionSucceededEvent<public>: listenable(agent) = external {}

    # Succeeds if the object is enabled, fails if it's disabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Signaled when the `agent` provides a perfect input.
    # Perfect input occurs when input is provided while the scrubber is within the device's *Perfect Zone*.
    # Sends the `agent` that provided the input.
    # Sends the `float` position of the meter scrubber from `0.0` to `1.0`.
    PerfectInputTriggeredEvent<public>: listenable(tuple(agent, float)) = external {}

    # Signaled when the `agent` is put into the queue but has not started an interaction.
    # If an agent skips the queue and is put directly into interacting, this event is skipped.
    QueueAgentEvent<public>: listenable(agent) = external {}

    # Signaled when the `agent` has been removed from the queue.
    # This can happen in a few ways
    # * An agent is removed without advancing into an interaction.
    # * If `Disable` is called while an agent is in the queue.
    # * The queue size is shrunk, causing agents to be removed.
    RemoveAgentFromQueueEvent<public>: listenable(agent) = external {}

    # Remove `agent`(s) from the queue, has the option to remove all entries that exist for that agent or not
    #  This does not end the interaction for any agents.
    #  Returns the number of agents that were removed.
    RemoveFromQueue<public>(Agents: []agent, AllEntries: logic): int = external {}

    # Maps to the user option 'Allow duplicate Player Entries'
    # If this is toggled while a queue exists then the queue will not be affected,
    # but any new additions to the queue will use the new behavior.
    # ie; if duplicate entries exist and this is set to true, the duplicate entries will not be removed
    # but any new duplicates will be rejected.
    var AllowDuplicatePlayerEntries<public>: logic = external {}

    # Maps to the 'Failure Limit' user option.
    # Determines how many times a bad input can be provided before failing the minigame.
    # Value is clamped between 0 and 5.
    # Any modifications to this event will take effect the next time an interaction is started.
    var FailureLimit<public>: int = external {}

    # Maps to the 'Good Zone Size' user option.
    # Sets the good zone's size as a ratio of the total meter.
    # Value is clamped between 0 and 1.
    # Any modifications to this event will take effect the next time an interaction is started.
    var GoodZoneSize<public>: float = external {}

    # Maps to the 'Interact Time Limit' user option.
    # Sets how long the player has to complete the interaction. Taking too long will result in failure.
    # Value is clamped between 0 and 120 seconds.
    # Any modifications to this event will take effect the next time an interaction is started.
    var InteractTimeLimit<public>: float = external {}

    # Maps to the 'Lock Out on Fail Time' user option.
    # If a bad input is provided, the interact will lock for the amount of time set. Set to 0 to disable this function.
    # Value must be greater than or equal to 0
    # Any modifications to this event will take effect the next time an interaction is started.
    var LockOutOnFailTime<public>: float = external {}

    # Maps to the user option 'Maximum Queued players'.
    # If queue size is changed while players are already queued, then entries will be removed from the list.
    # ie; if you have a queue of 10 agents and then adjust the size to 6, then 4 agents will be removed from the queue.
    # each of those agents will receive a AgentRemoveFromQueueEvent
    # Can only be set to values greater than or equal to 0
    var MaximumQueuedPlayers<public>: int = external {}

    # Maps to the 'Movement Speed' user option.
    # Determines how fast the meter moves across the interaction in percent per second.
    # Value is clamped between 1 and 400.
    # Any modifications to this event will take effect the next time an interaction is started.
    var MeterSpeed<public>: float = external {}

    # Maps to the user option for 'Next In Queue execution Delay'
    # Determines how much time to wait (0 being instant), before triggering the next interaction in the queue.
    # When modified will take effect after the current interaction is completed.
    # Can only be set to values greater than or equal to 0
    var NextInQueueExecutionDelay<public>: float = external {}

    # Maps to the 'Perfect Zone Size' user option.
    # Determines the perfect zone's size as a ratio of the good zone.
    # Value is clamped between 0 and 1.
    # Any modifications to this event will take effect the next time an interaction is started.
    var PerfectZoneSize<public>: float = external {}

    # Maps to the 'Success Target' user option.
    # Sets how many successful inputs are required for the minigame to complete.
    # Value is clamped between 0 and 5.
    # Any modifications to this event will take effect the next time an interaction is started.
    var SuccessTarget<public>: int = external {}

    # Maps to the user option for 'Synchronous Player Limit'.
    # If the queue is configured to be synchronous, this is the number of players that will interact at the same time
    # before moving onto the next batch of agents in the queue.
    # When modified, it will take effect on the next Interaction, and does not affect any active interaction.
    # Can only be set to values greater than or equal to 0
    var SynchronousPlayerLimit<public>: int = external {}
  }

  # Used to create a zone where players are put into a skydive state. Can customize the amount of force used to push the player, and how fast players are launched into the air. The direction of the push is in relation to the device, so you can rotate and overlap several devices, then use variable speeds to create pneumatic tubes that propel players in different directions. You can even create unique traversal (traveling) options, where players can use these zones to reach places on your island they couldn't reach any other way.
  skydive_volume_device<public> := class<concrete><final>(effect_volume_device) {
    # Signaled when an `agent` enters the volume.
    # Sends the `agent` that entered the volume.
    AgentEntersEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` exits the volume.
    # Sends the `agent` that exited the volume.
    AgentExitsEvent<public>: listenable(agent) = external {}

    # Disables volume locking which prevents users from leaving the volume once they've entered.
    DisableVolumeLocking<public>(): void = external {}

    # Enables volume locking which prevents users from leaving the volume once they've entered.
    EnableVolumeLocking<public>(): void = external {}

    # Returns an array of agents that are currently occupying the volume.
    GetAgentsInVolume<public>()<reads>: []agent = external {}

    # Is true when `Agent` is in the volume.
    IsInVolume<public>(Agent: agent)<transacts><decides>: void = external {}

    # Signaled when the zone changes from occupied to empty.
    # Sends the `agent` that last left the volume.
    ZoneEmptiedEvent<public>: listenable(agent) = external {}

    # Signaled when the zone changes from empty to occupied.
    # Sends the `agent` that entered the volume.
    ZoneOccupiedEvent<public>: listenable(agent) = external {}
  }

  @deprecated
  # Controls how the sky looks, as well as giving you options for changing the sun, clouds, stars or other objects in the sky above your island. You can control the sun and moon, and add other atmospheric elements like stars, fog and clouds. You can change the color of your light source, and blend different colors for your island's sky to create the perfect atmosphere for your game.
  skydome_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}
  }

  # Enum for determining if a spawner should spawn when it becomes enabled
  spawn_on_enable_behavior<public> := enum<open> {
    Always

    IfNone

    Never
  }

  # Results for `SpawnProp`.
  spawn_prop_result<native><public> := enum {
    # The asset is not a valid `creative_prop`.
    InvalidAsset

    # The spawn point contains NaN or Inf.
    InvalidSpawnPoint

    # Success.
    Ok

    # The spawn point is outside the island's boundaries.
    SpawnPointOutOfBounds

    # More props have been spawned than are permitted by the island's rules (currently 100 per script device and 200 total per island).
    TooManyProps

    # An unknown error occurred. If this happens frequently, contact Epic support.
    UnknownError
  }

  # A Destroyable environment prop that when destroyed, drops loot. When players approach the Spire Spike, they start a countdown to a knockback ability. When players are knocked back, they do not receive damage from the knockback ability or take fall damage. They can destroy structures near the knockback location. Damaging the spike can also start the countdown to the knockback or restart the countdown if it is already started.
  spire_spike_device<public> := class<concrete><final>(creative_device_base) {
    # Force begins the knockback charge timer. Will restart the charge timer if already active.
    ChargeKnockback<public>(): void = external {}

    # Despawns the Spire Spike. It will not drop loot.
    Despawn<public>(): void = external {}

    # Destroy the Spire Spike. Will cause the Spire Spike to drop its loot.
    Destroy<public>(Instigator: ?agent): void = external {}

    # Triggers when the Spire Spike is destroyed.
    # Includes the `agent` that destroyed it, if any.
    DestroyEvent<public>: listenable(?agent) = external {}

    # Returns if Spire Spike is currently spawned.
    IsSpawned<public>()<transacts><decides>: void = external {}

    # Force the Spire Spike to trigger its knockback ability immediately.
    Knockback<public>(): void = external {}

    # Triggers when the Spire Spike does its knockback ability.
    KnockbackEvent<public>: listenable(tuple()) = external {}

    # Spawn the Spire Spike. Resets CurrentHealth back to max health. Resets any timers currently active.
    Spawn<public>(): void = external {}

    # Additive vertical force on the knockback ability. Clamped between `0.0` and `100.0`.
    var AdditionalVerticalKnockback<public>: float = external {}

    # Determine if the Spire Spike should drop loot when destroyed or not.
    var CanGrantItems<public>: logic = external {}

    # The current health of the Spire Spike. Setting to `0.0` or negative will destroy the Spire Spike. Clamps to the maximum of MaxHealth.
    var CurrentHealth<public>: float = external {}

    # Horizontal force on the knockback ability. Clamped between `0.0` and `100.0`.
    var HorizontalKnockbackMultiplier<public>: float = external {}

    # Determines if the Spire Spike can take any damage.
    var IsInvulnerable<public>: logic = external {}

    # The remaining time (in seconds) on the knockback charge timer. Clamped between `0.0` and `60.0`.
    #  * When setting, this also sets the length of this Spire Spike's future knockback charge timers.
    #  * If there is no active timer, getting returns `0.0`.
    var KnockbackChargeTimer<public>: float = external {}

    # The length of the knockback charge timer in seconds, regardless of the timer's current state. Clamped between `0.0` and `60.0`.
    var KnockbackChargeTimerLength<public>: float = external {}

    # The range (in meters) a player needs to be within to trigger the proximity countdown. This is also the range of the knockback abilities affected targets. Clamped between `2.0` and `10.0`.
    var KnockbackTriggerRange<public>: float = external {}

    # The max health of the Spire Spike. Must be greater than or equal to `1.0`. Current health will be scaled up or down based on the scale difference between the old and new MaxHealth.
    var MaxHealth<public>: float = external {}

    # Determines if the knockback ability should charge once a player has entered the trigger range.
    var ShouldChargeKnockbackOnPlayerProximity<public>: logic = external {}

    # Determines if taking damage should start the knockback charge timer. If the timer was already active and this is true, taking damage will restart the timer.
    var ShouldKnockbackChargeFromTakingDamage<public>: logic = external {}

    # Determines if structures should be destroyed if a player is knocked back into them.
    var ShouldKnockbackDestroyStructures<public>: logic = external {}

    # Vertical force on the knockback ability. Clamped between `0.0` and `100.0`.
    var VerticalKnockbackMultiplier<public>: float = external {}
  }

  # A device that generates a scoreboard stat that can be used by the game to determine Game End and Round End conditions.
  # The stat can apply to individual players, teams, or everyone in the match. It can also generate a Level that will increment by 1 each time Value reaches *Max Value*, resetting Value to 0 when Level increments.
  stat_creator_device<public> := class<concrete><final>(creative_device_base) {
    # Returns stat Level for `Agent`.
    # Succeeds if *Number of Levels* is set to greater than 0, *Scope* is set to *Player*
    # and `Agent` passes the requirement checks on the device.
    GetLevel<public>(Agent: agent)<transacts><decides>: int = external {}

    # Returns stat Level for `Team`.
    # Succeeds if *Number of Levels* is set to greater than 0, *Scope* is set to *Team*
    # and the `Team` passes the requirement checks on the device.
    GetLevel<public>(Team: team)<transacts><decides>: int = external {}

    # Returns stat Level for the match.
    # Succeeds if *Number of Levels* is set to greater than 0 and *Scope* is set to *Match*.
    GetLevelForMatch<public>()<transacts><decides>: int = external {}

    # Returns the name for the stat that is generated by this Stat Creator.
    GetName<public>(): string = external {}

    # Returns stat Value for `Agent`.
    # Succeeds if *Scope* is set to *Player* and `Agent` passes the requirement checks on the device.
    GetValue<public>(Agent: agent)<transacts><decides>: int = external {}

    # Returns stat Value for `Team`.
    # Succeeds if *Scope* is set to *Team* and `Team` passes the requirement checks on the device.
    GetValue<public>(Team: team)<transacts><decides>: int = external {}

    # Returns stat Value for the match.
    # Succeeds if *Scope* is set to *Match*.
    GetValueForMatch<public>()<transacts><decides>: int = external {}

    # Signaled when the stat changes Level.
    # Sends a tuple of the instigating `agent` (or `false` if none) and the new Level.
    LevelChangedEvent<public>: listenable(tuple(?agent, int)) = external {}

    # Signaled when an `agent` reaches the maximum stat value. This occurs when the stat reaches *Max Value* if the device has no levels, or *Max Level* if that option is set.
    # Sends the `agent` that caused the stat event that changed the level and the new level as an `int` .
    MaximumReachedEvent<public>: listenable(tuple(?agent, int)) = external {}

    # Updates stat Level for `Agent`.
    # Succeeds if *Number of Levels* is set to greater than 0 and *Scope* is set to *Agent*.
    # Altering stat Level will set `Agent`'s stat Value to 0.
    SetLevel<public>(Agent: agent, Level: int)<transacts><decides>: void = external {}

    # Updates stat Level for `Team`.
    # Succeeds if *Number of Levels* is set to greater than 0 and *Scope* is set to *Team*.
    # Altering stat Level will set `Team`'s stat Value to 0.
    SetLevel<public>(Team: team, Level: int)<transacts><decides>: void = external {}

    # Updates stat Level for the match.
    # Succeeds if *Number of Levels* is set to greater than 0 and *Scope* is set to *Match* .
    # Altering stat Level will set the Match's stat Value to 0.
    SetLevelForMatch<public>(Level: int)<transacts><decides>: void = external {}

    # Updates stat Value for `Agent`.
    # Succeeds if *Scope* is set to *Agent* and `Agent` passes the requirement checks on the device.
    # If the stat does not have levels, `Value` is clamped between 0 and *Max Value*.
    # If the stat does have levels, the Value is not clamped and setting a value below 0 or above *Max Value* will
    # decrement or increment the level appropriately. e.g. if *Number of Levels* is 10, *Max Value is 100*
    # and you are currently level 0, a `Value` of 550 will set you to Level 5 and Value 50.
    SetValue<public>(Agent: agent, Value: int)<transacts><decides>: void = external {}

    # Updates stat Value for `Team`.
    # Succeeds if *Scope* is set to *Team* and `Team` passes the requirement checks on the device.
    # If the stat does not have levels, `Value` is clamped between 0 and *Max Value*.
    # If the stat does have levels, the Value is not clamped and setting a value below 0 or above *Max Value* will
    # decrement or increment the level appropriately. e.g. if *Number of Levels* is 10, *Max Value is 100*
    # and you are currently level 0, a `Value` of 550 will set you to Level 5 and Value 50.
    SetValue<public>(Team: team, Value: int)<transacts><decides>: void = external {}

    # Updates stat Value for the match.
    # Succeeds if *Scope* is set to *Match*.
    # If the stat does not have levels, `Value` is clamped between 0 and *Max Value*.
    # If the stat does have levels, the Value is not clamped and setting a value below 0 or above *Max Value* will
    # decrement or increment the level appropriately. e.g. if *Number of Levels* is 10, *Max Value is 100*
    # and you are currently level 0, a `Value` of 550 will set you to Level 5 and Value 50.
    SetValueForMatch<public>(Value: int)<transacts><decides>: void = external {}

    # Signaled when the stat changes Value.
    # Sends a tuple of the instigating `agent` (or `false` if none) and the new Value. Value increases to a maximum of *Max Value*. If the stat has not yet reached *Max Level* then Value will reset to 0 and Level will increment by 1.
    ValueChangedEvent<public>: listenable(tuple(?agent, int)) = external {}
  }

  # Used to increase or decrease a stat for an `agent`.
  stat_powerup_device<public> := class<concrete><final>(powerup_device) {
    # Returns the current *Magnitude* for the powerup.
    # For the Stat Powerup, this is the value of the stat that the powerup will add or remove to a player that picks up the powerup.
    GetMagnitude<public>()<transacts>: float = external {}

    # Sets the *Magnitude* for this powerup, clamped to the Min and Max defined in the device.
    # Will not apply to any currently applied effects.
    # For the Stat Powerup, this is the value of the stat that the powerup will add or remove to a player that picks up the powerup.
    SetMagnitude<public>(Magnitude: float): void = external {}
  }

  # Base class for various specialized storm devices. See also: * `basic_storm_controller_device` * `advanced_storm_controller_device`
  storm_controller_device<public> := class<abstract><epic_internal>(creative_device_base) {
    # Destroys the storm.
    DestroyStorm<public>(): void = external {}

    # Generates the storm. *Generate Storm On Game Start* must be set to *No* if you choose to use `GenerateStorm`.
    GenerateStorm<public>(): void = external {}

    # Moves the `storm_controller_device` to the specified `Position` and `Rotation` over the specified time, in seconds.
    # Existing storms will not target the new location, but newly generated storms will.
    MoveTo<override>(
      Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      OverTime: float
    )<suspends>: move_to_result = external {}

    # Moves the `storm_controller_device` to the specified `Transform` over the specified time, in seconds.
    # Existing storms will not target the new location, but newly generated storms will.
    MoveTo<override>(
      Transform: (/UnrealEngine.com/Temporary/SpatialMath:)transform,
      OverTime: float
    )<suspends>: move_to_result = external {}

    # Signaled when storm resizing ends. Use this with the *On Finish Behavior* option for better controls.
    PhaseEndedEvent<public>: listenable(tuple()) = external {}

    # Teleports the `storm_controller_device` to the specified `Position` and `Rotation`.
    # Existing storms will not target the new location, but newly generated storms will.
    TeleportTo<override>(
      Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<transacts><decides>: void = external {}

    # Teleports the `storm_controller_device` to the specified location defined by `Transform`, also applies rotation and scale accordingly.
    # Existing storms will not target the new location, but newly generated storms will.
    TeleportTo<override>(Transform: (/UnrealEngine.com/Temporary/SpatialMath:)transform)<transacts><decides>: void = external {}
  }

  # Used to spawn and configure an aerial supply drop that can provide players with customized weapons/supplies.
  supply_drop_spawner_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when the balloon on the supply crate is popped.
    # Sends the `?agent` that popped the balloon. If no `agent` popped the balloon returns `false`.
    BalloonPoppedEvent<public>: listenable(?agent) = external {}

    # Destroys the balloon and causes the supply crate to freefall.
    DestroyBalloon<public>(): void = external {}

    # Signaled when the supply crate is destroyed.
    # Sends the destroying `agent`. If no `agent` destroyed the crate then `false` is returned.
    DestroyCrateEvent<public>: listenable(?agent) = external {}

    # Destroys supply drops spawned by this device.
    DestroySpawnedDrops<public>(): void = external {}

    # Signaled when the supply crate lands for the first time.
    LandingEvent<public>: listenable(tuple()) = external {}

    # Locks the supply crate so `agent`s cannot open it.
    Lock<public>(): void = external {}

    # Opens the supply crate, ignoring the locked or unlocked state. `Agent` acts as the instigator of the open action.
    Open<public>(Agent: agent): void = external {}

    # Signaled when the supply crate is opened.
    # Sends the `agent` that opened the crate.
    OpenedEvent<public>: listenable(agent) = external {}

    # Spawns a supply drop provided one hasn't already spawned.
    Spawn<public>(): void = external {}

    # Spawns a supply drop provided one hasn't already spawned. *Owning Team* is set to `Agent`'s team.
    Spawn<public>(Agent: agent): void = external {}

    # Unlocks the supply crate so `agent`s can open it.
    Unlock<public>(): void = external {}
  }

  # DEPRECATED This device is no longer supported.Used to inform players of other content made by a creator using a Support-A-Creator code. When players activate the device, it will bring up the same Support-A-Creator dialog box they would see in the Creative hub. The Support-A-Creator information shows when the dialog box opens for the player.
  support_a_creator_device<public> := class<concrete><final>(creative_device_base) {}

  # Used to allow agents to turn other linked devices on/off or other custom state changes.
  switch_device<public> := class<concrete><final>(creative_device_base) {
    # Checks the device state with `Agent` acting as the instigator of the action.
    CheckState<public>(Agent: agent): void = external {}

    # Clears persistence data for all `agent`s.
    ClearAllPersistenceData<public>(): void = external {}

    # Signaled when the persistent data is cleared by the specified `agent`.
    # Sends the `agent` that cleared persistent data on the device.
    ClearEvent<public>: listenable(agent) = external {}

    # Clears persistence data for `Agent`.
    ClearPersistenceData<public>(Agent: agent): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Returns the time, in seconds, before the switch will reset itself to default.
    #  Returns -1.0 if *Store State Per Player* is *Yes* or if  there is no active reset timer.
    GetCurrentResetTime<public>(): float = external {}

    # Returns the time, in seconds, before the switch will reset itself to default for *Agent*.
    #  Returns -1.0 if there is no active reset timer.
    GetCurrentResetTime<public>(Agent: agent): float = external {}

    # Succeeds if the current state of this switch is on, fails otherwise. Use this overload  of `GetCurrentState` when this device has *Store State Per Player* set to *No*.
    GetCurrentState<public>()<transacts><decides>: void = external {}

    # Succeeds if the current state of this switch is on, fails otherwise. Use this overload  of `GetCurrentState` when this device has *Store State Per Player* set to *Yes*.
    GetCurrentState<public>(Agent: agent)<transacts><decides>: void = external {}

    # Returns the *Interaction Time* required to activate this device (in seconds).
    GetInteractionTime<public>()<transacts>: float = external {}

    # Returns the value of *State Reset Time*, in seconds, for the device. Returns -1.0 if *State Reset Time* is not used.
    GetStateResetTime<public>()<transacts>: float = external {}

    # Returns the value of *State Reset Time*, in seconds, for the device, for a specific player. Returns -1.0 if *State Reset Time* is not used.
    GetStateResetTime<public>(Agent: agent)<transacts>: float = external {}

    # Signaled if the switch is off when the state is checked.
    IfOffWhenCheckedEvent<public>: listenable(tuple()) = external {}

    # Signaled if the switch is on when the state is checked.
    IfOnWhenCheckedEvent<public>: listenable(tuple()) = external {}

    # Query whether this device has a single global on/off state, or has a personalized on/off state for each individual agent.
    IsStatePerAgent<public>()<transacts><decides>: void = external {}

    # Loads the device state with `Agent` acting as the instigator of the action.
    LoadState<public>(Agent: agent): void = external {}

    # Loads the device state for all players.
    LoadStateForAll<public>(): void = external {}

    # Saves the device state with `Agent` acting as the instigator of the action.
    SaveState<public>(Agent: agent): void = external {}

    # Saves the device state for all players
    SaveStateForAll<public>(): void = external {}

    # Sets the *Interaction Time* required to activate this device (in seconds).
    SetInteractionTime<public>(Time: float): void = external {}

    # Sets the state of the switch to a specific value for a specific `Agent`.
    #  Use when the device has *Store State Per Player* set to *Yes*.
    SetState<public>(Agent: agent, State: logic): void = external {}

    # Sets the state of the switch to a specific value.
    #  Use when the device has *Store State Per Player* set to *No*.
    SetState<public>(State: logic): void = external {}

    # Updates the *State Reset Time* for the device, in seconds,for a specific player (if *Store State Per Player* is *Yes*), clamped to the Min and Max defined in the device.
    #  This will not apply to any state reset timers currently in effect.
    #  Set to 0.0 to disable the State Reset Time. Set to less than 0.0 to reset to default.
    SetStateResetTime<public>(Agent: agent, Time: float): void = external {}

    # Updates the *State Reset Time* for the device, in seconds, clamped to the Min and Max defined in the device.
    #  This will not apply to any state reset timers currently in effect.
    #  Set to 0.0 to disable the State Reset Time. Set to less than 0.0 to reset to default.
    SetStateResetTime<public>(Time: float): void = external {}

    # Sets the *Turn Off Text* to be displayed to a user when the switch is currently on, and offers an interaction to switch it off. Clamped to 150 characters.
    SetTurnOffInteractionText<public>(Text: message): void = external {}

    # Sets the *Turn On Text* to be displayed to a user when the switch is currently off, and offers an interaction to switch it on. Clamped to 150 characters.
    SetTurnOnInteractionText<public>(Text: message): void = external {}

    # Signaled when the switch state changes.
    StateChangesEvent<public>: listenable(tuple()) = external {}

    # Signaled when the switch state is loaded by the specified `agent`.
    # Sends the `agent` that loaded the state on the device.
    StateLoadEvent<public>: listenable(agent) = external {}

    # Signaled when the switch state is saved.
    StateSaveEvent<public>: listenable(tuple()) = external {}

    # Toggles between `TurnOn` and `TurnOff` with `Agent` acting as the instigator of the action.
    ToggleState<public>(Agent: agent): void = external {}

    # Turns off the device with `Agent` acting as the instigator of the action.
    TurnOff<public>(Agent: agent): void = external {}

    # Turns on this device with `Agent` acting as the instigator of the action.
    TurnOn<public>(Agent: agent): void = external {}

    # Signaled when the switch is turned off by the specified `agent`.
    # Sends the `agent` that turned off the device.
    TurnedOffEvent<public>: listenable(agent) = external {}

    # Signaled when the switch is turned on by the specified `agent`.
    # Sends the `agent` that turned on the device.
    TurnedOnEvent<public>: listenable(agent) = external {}
  }

  # Used to place the Infinity Blade on your island. When placed, the Infinity Blade becomes available to any player regardless of team affiliation.
  sword_in_the_stone_device<public> := class<concrete><final>(creative_device_base) {}

  # Provides team and inventory configurations that go beyond the choices the My Island settings provide.
  # Can also be used to customize individual devices and create variations in team setup.
  team_settings_and_inventory_device<public> := class<concrete><final>(creative_device_base) {
    # Ends the round and *Team* wins the round.
    EndRound<public>(): void = external {}

    # Signaled when an enemy of *Team* is eliminated by a team member.
    # Sends the `agent` team member who eliminated the enemy.
    EnemyEliminatedEvent<public>: listenable(agent) = external {}

    # Returns an array of agents that are currently of the team defined by this device.
    GetTeamMembers<public>()<reads>: []agent = external {}

    # Is true if `Agent` is on *Team*.
    IsOnTeam<public>(Agent: agent)<transacts><decides>: void = external {}

    # Removes the `agent` from its Temporary Team.
    # Decides based on whether the `agent` was on a Temporary Team.
    # This will return them to the team they were on before they joined a Temporary Team
    RemoveTemporaryMemberFromTeam<public>(Agent: agent): void = external {}

    # Returns all temporary team members for this Device’s Team Setting Value back to their original Teams.
    # If the device is configured to All, then this function will remove all Temporary Team members from any Temporary Team they are on, returning them to their original team.
    RemoveTemporaryMembersFromTeam<public>(): void = external {}

    # Spawn `Player` from the most appropriate `player_spawner_device` available (team match, highest priority, enemy proximity, etc).
    # Uses the device's `Should Respawn Alive Players` setting to control behavior when called on an alive player.
    # If no valid spawner is found, the player will respawn from skydive.
    RespawnAtPlayerSpawner<public>(Player: player): void = external {}

    # Spawn `Player` from the most appropriate `player_spawner_device`, selected from the provided `SpawnerGroup` array.
    # Uses the device's `Should Respawn Alive Players` setting to control behavior when called on an alive player.
    # If no valid spawner is found, the player will respawn from skydive.
    RespawnAtPlayerSpawner<public>(Player: player, SpawnerGroup: []player_spawner_device): void = external {}

    # Signaled when a member of *Team* is eliminated.
    # Sends the `agent` that was eliminated.
    TeamMemberEliminatedEvent<public>: listenable(agent) = external {}

    # Signaled when a member of *Team* is spawned.Sends the `agent` that has spawned.
    TeamMemberSpawnedEvent<public>: listenable(agent) = external {}

    # Signaled when *Team* runs out of respawns.
    TeamOutOfRespawnsEvent<public>: listenable(tuple()) = external {}

    # This variable maps to the 'Dynamic Team Emotes' user option.
    # Modifying this value does not affect the state of any existing Temporary Team member.
    # If a player is currently on a Temporary Team, they will maintain access to the leave team emote regardless of this value.
    # Available values:
    # * If this option is unset, use the global setting configured in Island Settings
    # * If this is set to TRUE, it allows members of this team to Emote and invite other players to their team.
    # * If this is set to FALSE, it prevents members of this team from using an Emote to invite other players to this team.
    var AllowTemporaryTeamMemberInvitations<public>: ?logic = external {}
  }

  # Customizable rift that allows `agent`s to move instantly between locations. You can use this to move players around your island, or create multi-island experiences with teleporters that take players from one island to another.
  teleporter_device<public> := class<concrete><final>(creative_device_base) {
    # Teleport `Agent` to the target group using this device.
    Activate<public>(Agent: agent): void = external {}

    # When a link is activated, the current destination teleporter will be able to bring the `agent` back to this origin teleporter. Both origin and destination teleporters need to have this activated to work as expected.
    ActivateLinkToTarget<public>(): void = external {}

    # Deactivates any currently active Link. The current destination teleporter will no longer be able to return the agent to this origin teleporter.
    DeactivateLinkToTarget<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when an `agent` enters this device.
    # Sends the `agent` that entered this device.
    EnterEvent<public>: listenable(agent) = external {}

    # Resets the currently selected destination teleporter, and selects an eligible destination. If the target is a *Teleporter Group*, this may be another randomly chosen `teleporter_device` from that group.
    ResetLinkToTarget<public>(): void = external {}

    # Teleport `Agent` to this device.
    Teleport<public>(Agent: agent): void = external {}

    # Signaled when an `agent` emerges from this device.
    # Sends the `agent` that emerged from this device.
    TeleportedEvent<public>: listenable(agent) = external {}
  }

  # Configures game modes where players can start or stop timers to advance gameplay objectives, such as Attack/Defend Bomb objectives.
  timed_objective_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when the objective begins.
    # Sends the `agent` that started the timer.
    BeganEvent<public>: listenable(agent) = external {}

    # Starts the objective with `Agent` acting as the user the interacted this device.
    Begin<public>(Agent: agent): void = external {}

    # Completes the objective with `Agent` acting as the user the interacted this device.
    Complete<public>(Agent: agent): void = external {}

    # Signaled when the objective is completed.
    # Sends the `agent` that started the timer or completed the timer by calling `Complete`.
    CompletedEvent<public>: listenable(agent) = external {}

    # Disables the objective for `Agent`.
    Disable<public>(Agent: agent): void = external {}

    # Enables the objective for `Agent`.
    Enable<public>(Agent: agent): void = external {}

    # Ends the objective with `Agent` acting as the user the interacted this device.
    End<public>(Agent: agent): void = external {}

    # Signaled when the objective ends.
    # Sends the `agent` that stopped the timer.
    EndedEvent<public>: listenable(agent) = external {}

    # Makes this device invisible.
    Hide<public>(): void = external {}

    # Pauses the objective with `Agent` acting as the user the interacted this device.
    Pause<public>(Agent: agent): void = external {}

    # Signaled when the objective is paused.
    # Sends the `agent` that paused the timer.
    PausedEvent<public>: listenable(agent) = external {}

    # Restarts the objective with `Agent` acting as the user the interacted this device.
    Restart<public>(Agent: agent): void = external {}

    # Signaled when the objective is restarted.
    # Sends the `agent` that restarted the timer.
    RestartedEvent<public>: listenable(agent) = external {}

    # Resumes the objective with `Agent` acting as the user the interacted this device.
    Resume<public>(Agent: agent): void = external {}

    # Signaled when the objective is resumed.
    # Sends the `agent` that resumed the timer.
    ResumedEvent<public>: listenable(agent) = external {}

    # Makes this device visible.
    Show<public>(): void = external {}
  }

  # Provides a way to keep track of the time something has taken, either for scoreboard purposes, or to trigger actions. It can be configured in several ways, either acting as a countdown to an event that is triggered at the end, or as a stopwatch for an action that needs to be completed before a set time runs out.
  timer_device<public> := class<concrete><final>(creative_device_base) {
    # Clears this device's saved data for `Agent`.
    ClearPersistenceData<public>(Agent: agent): void = external {}

    # Clears this device's saved data for all `agent`s.
    ClearPersistenceDataForAll<public>(): void = external {}

    # Clears this device's saved data for all `agent`s.
    ClearPersistenceDataForAll<public>(Agent: agent): void = external {}

    # Completes the timer.
    Complete<public>(): void = external {}

    # Completes the timer for `Agent`.
    Complete<public>(Agent: agent): void = external {}

    # Completes the timer for all `agent`s.
    CompleteForAll<public>(): void = external {}

    # Completes the timer for all `agent`s.
    CompleteForAll<public>(Agent: agent): void = external {}

    # Disables this device. While disabled this device will not receive signals.
    Disable<public>(): void = external {}

    # Disables this device for `Agent`. While disabled this device will not receive signals.
    Disable<public>(Agent: agent): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Enables this device for `Agent`.
    Enable<public>(Agent: agent): void = external {}

    # Signaled when the timer completes or ends with failure.
    # Sends the `agent` that activated the timer, if any.
    FailureEvent<public>: listenable(?agent) = external {}

    # Returns the remaining time (in seconds) on the timer if it is set to be global.
    GetActiveDuration<public>()<transacts>: float = external {}

    # Returns the remaining time (in seconds) on the timer for `Agent`.
    GetActiveDuration<public>(Agent: agent)<transacts>: float = external {}

    # Returns the maximum duration of the timer (in seconds).
    GetMaxDuration<public>()<transacts>: float = external {}

    # Succeeds if this device is tracking timer state for each individual `agent` independently. Fails if state is being tracked globally for all `agent`'s.
    IsStatePerAgent<public>()<transacts><decides>: void = external {}

    # Loads this device's saved data for `Agent`.
    Load<public>(Agent: agent): void = external {}

    # Pauses the timer.
    Pause<public>(): void = external {}

    # Pauses the timer for `Agent`.
    Pause<public>(Agent: agent): void = external {}

    # Pauses the timer for all `agent`s.
    PauseForAll<public>(): void = external {}

    # Pauses the timer for all `agent`s.
    PauseForAll<public>(Agent: agent): void = external {}

    # Resets the timer back to its base time and stops it.
    (/Fortnite.com/Devices/timer_device:)Reset<public>(): void = external {}

    # Resets the timer back to its base time and stops it for `Agent`.
    (/Fortnite.com/Devices/timer_device:)Reset<public>(Agent: agent): void = external {}

    # Resets the timer back to its base time and stops it for all `agent`s.
    ResetForAll<public>(): void = external {}

    # Resets the timer back to its base time and stops it for all `agent`s.
    ResetForAll<public>(Agent: agent): void = external {}

    # Resumes the timer.
    Resume<public>(): void = external {}

    # Resumes the timer for `Agent`.
    Resume<public>(Agent: agent): void = external {}

    # Resumes the timer for all `agent`s.
    ResumeForAll<public>(): void = external {}

    # Resumes the timer for all `agent`s.
    ResumeForAll<public>(Agent: agent): void = external {}

    # Saves this device's data for `Agent`.
    Save<public>(Agent: agent): void = external {}

    # Sets the remaining time (in seconds) on the timer, if active. Use this function if the timer is set to use the same time for all `agent`'s.
    SetActiveDuration<public>(Time: float): void = external {}

    # Sets the remaining time (in seconds) on the timer, if active, on `Agent`.
    SetActiveDuration<public>(Time: float, Agent: agent): void = external {}

    # Sets the lap time indicator for `Agent`.
    SetLapTime<public>(Agent: agent): void = external {}

    # Sets the lap time indicator for all `agent`s.
    SetLapTimeForAll<public>(): void = external {}

    # Sets the lap time indicator for all `agent`s.
    SetLapTimeForAll<public>(Agent: agent): void = external {}

    # Sets the maximum duration of the timer (in seconds).
    SetMaxDuration<public>(Time: float): void = external {}

    # Starts the timer.
    Start<public>(): void = external {}

    # Starts the timer for `Agent`.
    Start<public>(Agent: agent): void = external {}

    # Starts the timer for all `agent`s.
    StartForAll<public>(): void = external {}

    # Starts the timer for all `agent`s.
    StartForAll<public>(Agent: agent): void = external {}

    # Signaled when the timer enters *Urgency Mode*.
    # Sends the `agent` that activated the timer, if any.
    StartUrgencyModeEvent<public>: listenable(?agent) = external {}

    # Signaled when the timer completes or ends with success.
    # Sends the `agent` that activated the timer, if any.
    SuccessEvent<public>: listenable(?agent) = external {}
  }

  # Allows creation and HUD tracking of custom objectives for `agent`s to complete.
  tracker_device<public> := class<concrete><final>(creative_device_base) {
    # Assigns the device to `Agent` (and any `agent`s sharing progress).
    Assign<public>(Agent: agent): void = external {}

    # Assigns this device to all valid `agent`s.
    AssignToAll<public>(): void = external {}

    # Clears tracked progress for `Agent`. Only valid if *Use Persistence* is set to *Use*.
    ClearPersistence<public>(Agent: agent): void = external {}

    # The objective immediately completes.
    Complete<public>(Agent: agent): void = external {}

    # Signaled when the tracked value reaches `GetTarget` for an `agent`.
    # Sends the `agent` that reached `GetTarget` for their tracked value.
    CompleteEvent<public>: listenable(agent) = external {}

    # Decreases the target value for `Agent` by 1.
    DecreaseTargetValue<public>(Agent: agent): void = external {}

    # Decrease the tracked value by *Amount to Change on Received Signal* for `Agent`.
    Decrement<public>(Agent: agent): void = external {}

    # Returns an array of agents that currently have this tracker active.
    GetActiveAgents<public>()<reads>: []agent = external {}

    # Returns the target value that must be achieved in order for `CompleteEvent` to trigger.
    # Clamped to `0 <= GetTarget <= 10000`.
    GetTarget<public>()<transacts>: int = external {}

    # Returns the current total tracked value for all players.
    GetValue<public>()<transacts>: int = external {}

    # Returns the current tracked value for `Agent`.
    GetValue<public>(Agent: agent)<transacts>: int = external {}

    # Returns the current total tracked value for the team at `TeamIndex`.
    GetValue<public>(TeamIndex: int)<transacts>: int = external {}

    # Is true if `Agent` has reached the *TargetValue* for the tracker.
    HasReachedTarget<public>(Agent: agent)<transacts><decides>: void = external {}

    # Increases the target value for `Agent` by 1.
    IncreaseTargetValue<public>(Agent: agent): void = external {}

    # Increases the tracked value by *Amount to Change on Received Signal* for `Agent`.
    Increment<public>(Agent: agent): void = external {}

    # Is true if `Agent` currently has the tracker active.
    IsActive<public>(Agent: agent)<transacts><decides>: void = external {}

    # Loads tracked progress for `Agent`. Only valid if *Use Persistence* is set to *Use*.
    Load<public>(Agent: agent): void = external {}

    # Loads tracked progress for all valid `agent`s. Only valid if *Use Persistence* is set to *Use*.
    LoadForAll<public>(): void = external {}

    # Removes this device from `Agent` (and any `agent`s sharing progress).
    Remove<public>(Agent: agent): void = external {}

    # Removes this device from all valid `agent`s.
    RemoveFromAll<public>(): void = external {}

    # Resets the progress for `Agent` (and any `agent`s sharing progress).
    (/Fortnite.com/Devices/tracker_device:)Reset<public>(Agent: agent): void = external {}

    # Saves tracked progress for `Agent`. Only valid if *Use Persistence* is set to *Use*.
    Save<public>(Agent: agent): void = external {}

    # Sets a description for the `tracker_device`, which is displayed if *Show on HUD* is enabled.
    # `Text` has a 64 character limit.
    SetDescriptionText<public>(Text: message): void = external {}

    # Sets the target value that must be achieved in order for `CompleteEvent` to trigger.
    # Clamped to `0 <= TargetValue <= 10000`.
    SetTarget<public>(TargetValue: int): void = external {}

    # Sets the title for the `tracker_device`, which is displayed if *Show on HUD* is enabled.
    # `Text` has a 32 character limit.
    SetTitleText<public>(Text: message): void = external {}

    # Sets the current tracked value for the device for a specific 'Agent'.
    # If *Sharing* is set to *Team*, this will set the value for their team.
    # If *Sharing* is set to *All*, this will set the value for everyone.
    SetValue<public>(Agent: agent, Value: int): void = external {}

    # Sets the current tracked value for the device for the Team at the `TeamIndex`.
    # If *Sharing* is set to *Individual*, this will set the value for all team members.
    # If *Sharing* is set to *All*, this will set the value for all players.
    SetValue<public>(TeamIndex: int, Value: int): void = external {}

    # Sets the current tracked value for the device for all active players.
    SetValue<public>(Value: int): void = external {}
  }

  # A trap device that destroys the tile it's placed on when activated.
  trick_tile_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when the tile this device is attached to is removed. This may occur later than `TriggeredEvent` if *Activation Delay* is set on the device.
    # Sends the `agent` that activated this device.
    ActivatedEvent<public>: listenable(agent) = external {}

    # Disables this device. While disabled this device will not react to incoming events.
    Disable<public>(): void = external {}

    # Disables this device from triggering when an `agent` makes contact with the device.
    DisableAgentContactTrigger<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Enables this device to trigger when an `agent` makes contact with the device.
    EnableAgentContactTrigger<public>(): void = external {}

    # Moves the `trick_tile_device` to the specified `Position` and `Rotation` over the specified time, in seconds.
    # Only the trigger will move, the target buildings will not change.
    MoveTo<override>(
      Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      OverTime: float
    )<suspends>: move_to_result = external {}

    # Moves the `trick_tile_device` to the specified `Transform` over the specified time, in seconds.
    # Only the trigger will move, the target buildings will not change.
    MoveTo<override>(
      Transform: (/UnrealEngine.com/Temporary/SpatialMath:)transform,
      OverTime: float
    )<suspends>: move_to_result = external {}

    # Restores the tile removed when this device was triggered.
    (/Fortnite.com/Devices/trick_tile_device:)Reset<public>(): void = external {}

    # Teleports the `trick_tile_device` to the specified `Position` and `Rotation`.
    # Only the trigger will teleport, the target buildings will not change.
    TeleportTo<override>(
      Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<transacts><decides>: void = external {}

    # Teleports the `trick_tile_device` to the specified location defined by `Transform`, also applies rotation and scale accordingly.
    # Only the trigger will teleport, the target buildings will not change.
    TeleportTo<override>(Transform: (/UnrealEngine.com/Temporary/SpatialMath:)transform)<transacts><decides>: void = external {}

    # Flips the device between `EnableAgentContactTrigger` and `DisableAgentContactTrigger.
    ToggleAgentContactTrigger<public>(): void = external {}

    # Flips the device between `Enabled` and `Disable`.
    ToggleEnabled<public>(): void = external {}

    # Triggers the device, removing the associated tile.
    Trigger<public>(): void = external {}

    # Signaled when this device is triggered.
    # Sends the `agent` that triggered this device.
    TriggeredEvent<public>: listenable(agent) = external {}
  }

  # Base class for various specialized trigger devices. See also: * `trigger_device` * `perception_trigger_device` * `attribute_evaluator_device`
  trigger_base_device<public> := class<abstract><epic_internal>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Gets the maximum amount of times this device can trigger.
    #  * `0` indicates no limit on trigger count.
    GetMaxTriggerCount<public>()<transacts>: int = external {}

    # Gets the time (in seconds) before the device can be triggered again (if `MaxTrigger` count allows).
    GetResetDelay<public>()<transacts>: float = external {}

    # Gets the time (in seconds) which must pass after triggering, before this device informs other external devices that it has been triggered.
    GetTransmitDelay<public>()<transacts>: float = external {}

    # Returns the number of times that this device can still be triggered before hitting `GetMaxTriggerCount`.
    # Returns `0` if `GetMaxTriggerCount` is unlimited.
    GetTriggerCountRemaining<public>()<transacts>: int = external {}

    # Resets the number of times this device has been activated. This will set `GetTriggerCountRemaining` back to `0`
    (/Fortnite.com/Devices/trigger_base_device:)Reset<public>(): void = external {}

    # Sets the maximum amount of times this device can trigger.
    #  * `0` can be used to indicate no limit on trigger count.
    #  * `MaxCount` is clamped between [0,20].
    SetMaxTriggerCount<public>(MaxCount: int): void = external {}

    # Sets the time (in seconds) after triggering, before the device can be triggered again (if `MaxTrigger` count allows).
    SetResetDelay<public>(Time: float): void = external {}

    # Sets the time (in seconds) which must pass after triggering, before this device informs other external devices that it has been triggered.
    SetTransmitDelay<public>(Time: float): void = external {}
  }

  # Used to relay events to other linked devices.
  trigger_device<public> := class<concrete><final>(trigger_base_device) {
    # Triggers this device, causing it to activate its `TriggeredEvent` event.
    Trigger<public>(): void = external {}

    # Triggers this device with `Agent` being passed as the `agent` that triggered the action. Use an `agent` reference when this device is setup to require one (for instance, you want to trigger the device only with a particular `agent`.
    Trigger<public>(Agent: agent): void = external {}

    # Signaled when an `agent` triggers this device.
    # Sends the `agent` that used this device. Returns `false` if no `agent` triggered the action (ex: it was triggered through code).
    TriggeredEvent<public>: listenable(?agent) = external {}
  }

  # Settings for vehicle mod boxes, used with vehicle_mod_box_spawner_device.
  vehicle_mod_box_settings<public> := class<final><public> {
    # Reset visual settings and make the associated mod box use its default non-customized visuals.
    #  * Fails if this is a custom list entry set to `Empty Slot`.
    ApplyDefaultVisuals<public>()<transacts><decides>: void = external {}

    # A custom icon on the mod box. Attempting to return this value will fail unless it's your own texture.
    #  * If the associated mod box uses default visuals, it becomes a blank box with that icon.
    #  * Setting this value to `false` removes any custom icon.
    var Icon<public>: ?texture = external {}

    # The custom color of the icon on the mod box. This value has no effect if this entry's icon is not set.
    #  * Setting this value to `false` removes any custom icon color.
    var IconColor<public>: ?color = external {}

    # The scale multiplier of the icon on the mod box, clamped between `0.1` and `2.0`. This value has no effect if this entry's icon is not set.
    #  * This value defaults to `1.0`.
    var IconScale<public>: float = external {}

    # A custom paint color on the mod box.
    #  * If the associated mod box uses default visuals, it becomes a blank box with that paint color.
    #  * Setting this value to `false` removes any custom paint color.
    var PaintColor<public>: ?color = external {}
  }

  using { /Verse.org/Colors }
  # Used to spawn customizable boxes containing vehicle mods. Hit a box with a vehicle to apply the mod.
  vehicle_mod_box_spawner_device<public> := class<concrete><final>(creative_device_base, enableable) {
    # Triggers whenever the mod box is destroyed regardless of whether a mod was applied.
    # Returns tuple:
    #  * 0: The `agent` that triggered this event, if applicable.
    #  * 1: The index `int` of the chosen mod in the device's list, starting with `0` for Custom List Mod 1.
    # If *Possible Mods* is not set to `Custom List`, `int` will be `-1`.
    BoxDestroyedEvent<public>: listenable(tuple(?agent, int)) = external {}

    # Triggers whenever the mod box spawns.
    #  * Returns the index `int` of the chosen mod in the device's list, starting with `0` for Custom List Mod 1.
    # If *Possible Mods* is not set to `Custom List`, `int` will be `-1`.
    BoxSpawnedEvent<public>: listenable(int) = external {}

    # If the mod box is spawned, respawn it as the next valid entry in the list without triggering `BoxDestroyEvent`.
    #  * If the mod box is not spawned, that will be the next mod box.
    #  * The list wraps, which means the first index is considered directly after the last index.
    #  * Does nothing if this device is disabled or *Possible Mods* is not set to `Custom List`.
    CycleToNextValidIndex<public>(): void = external {}

    # If the mod box is spawned, respawn it as the previous valid entry in the list without triggering `BoxDestroyEvent`.
    #  * If the mod box is not spawned, that will be the next mod box.
    #  * The list wraps, which means the last index is considered directly before the first index.
    #  * Does nothing if this device is disabled or *Possible Mods* is not set to `Custom List`.
    CycleToPreviousValidIndex<public>(): void = external {}

    # Despawn the box and clear the spawn timer without triggering `BoxDestroyEvent`. The respawn hologram will be visible, but will not progress without `StartSpawnTimer`. The device must be enabled.
    DespawnBox<public>(): void = external {}

    # Disable the device and clear any active spawn timer. While disabled, it will be hidden and vehicle mod boxes will not spawn.
    Disable<override>(): void = external {}

    # Enable the device and start the spawn timer. While enabled, it can spawn vehicle mod boxes, and those boxes can be interacted with.
    Enable<override>(): void = external {}

    # Returns the remaining time (in seconds) of the device's active spawn timer.
    #  * If there is no active timer, return `0.0`.
    GetActiveTimerRemaining<public>()<transacts>: float = external {}

    # Returns the current index `int` in the device's list of mod boxes. This value is set whenever the device spawns a new mod box.
    #  * The device's list starts with `0` for Custom List Mod 1.
    #  * If *Possible Mods* is not set to `Custom List` or the device has never spawned a mod box, `int` will be `-1`.
    GetCurrentIndex<public>()<transacts>: int = external {}

    # Returns the total length of the initial spawn timer in seconds, regardless of the timer's current state.
    GetInitialSpawnTimerLength<public>()<transacts>: float = external {}

    # Returns the total length of the respawn timer in seconds, regardless of the timer's current state.
    GetRespawnTimerLength<public>()<transacts>: float = external {}

    # Returns the number of times the device has spawned a mod box.
    GetSpawnCount<public>()<transacts>: int = external {}

    # Succeeds if the object is enabled, fails if it's disabled.
    IsEnabled<override>()<transacts><decides>: void = external {}

    # Check if this device currently has a spawned mod box.
    IsSpawned<public>()<transacts><decides>: void = external {}

    # Succeeds if `Index` is a valid entry in the device's list. Fails if `Index` is an invalid entry or *Possible Mods* is not set to `Custom List`.
    IsValidIndex<public>(Index: int)<transacts><decides>: void = external {}

    # Triggers whenever the mod is applied to a vehicle.
    # Returns tuple:
    #  * 0: The `agent` driving the vehicle, if applicable.
    #  * 1: The `fort_vehicle` the mod applied to.
    #  * 2: The index `int` of the chosen mod in the device's list, starting with `0` for Custom List Mod 1.
    # If *Possible Mods* is not set to `Custom List`, `int` will be `-1`.
    ModAppliedEvent<public>: listenable(tuple(?agent, fort_vehicle, int)) = external {}

    # Triggers whenever the mod fails to apply to a vehicle.
    # Returns tuple:
    #  * 0: The `agent` driving the vehicle, if applicable.
    #  * 1: The `fort_vehicle` the mod failed to apply to.
    #  * 2: The index `int` of the chosen mod in the device's list, starting with `0` for Custom List Mod 1.
    # If *Possible Mods* is not set to `Custom List`, `int` will be `-1`.
    ModApplyFailedEvent<public>: listenable(tuple(?agent, fort_vehicle, int)) = external {}

    # If ModAppliedEvent is overridden (see `SetOverrideModApplyEvent`), breaking a mod box triggers this instead of `ModAppliedEvent`, `ModApplyFailEvent`, or `NoModEvent`.
    # Returns tuple:
    #  * 0: The `agent` driving the vehicle, if applicable.
    #  * 1: The `fort_vehicle` the mod would attempt to apply to.
    #  * 2: The index `int` of the chosen mod in the device's list, starting with `0` for Custom List Mod 1.
    # If *Possible Mods* is not set to `Custom List`, `int` will be `-1`.
    ModApplyOverriddenEvent<public>: listenable(tuple(?agent, fort_vehicle, int)) = external {}

    # Triggers whenever a `No Mod` entry from a custom list tries to apply to a vehicle.
    # Returns tuple:
    #  * 0: The `agent` driving the vehicle, if applicable.
    #  * 1: The `fort_vehicle` that broke the box.
    #  * 2: The index `int` of the specific `No Mod` entry in the device's list, starting with `0` for Custom List Mod 1.
    NoModEvent<public>: listenable(tuple(?agent, fort_vehicle, int)) = external {}

    # Reset the names of this device's mod boxes, if the name has been customized.
    ResetModBoxName<public>(): void = external {}

    # Reset the text of the tooltip that appears when a player gets close to the mod box without a vehicle, if it's been customized.
    ResetPlayerTooltip<public>(): void = external {}

    # Set this device's mod boxes to use the name `Name`
    #  * The displayed name will not exceed 50 characters.
    #  * The following characters are disallowed: {, }, <, >, \, /, and |.
    SetCustomModBoxName<public>(Name: message): void = external {}

    # Set the `Text` of the tooltip that appears when a player gets close to the mod box without a vehicle.
    #  * The displayed text will not exceed 50 characters.
    #  * The following characters are disallowed: {, }, <, >, \, /, and |.
    SetCustomPlayerTooltipText<public>(Text: message): void = external {}

    # Set the remaining time (in seconds) on the initial spawn timer (clamped to a minimum of `0.0`). The device must be enabled.
    #  * Even if the initial spawn timer is not currently active, this sets its length.
    SetInitialSpawnTimer<public>(Time: float): void = external {}

    # Set the next mod box to spawn to be the one at `Index` in the device's list.
    #  * The first index in the list is `0` for Custom List Mod 1.
    #  * Does nothing if this device is disabled, *Possible Mods* is not set to `Custom List`, or `Index` is invalid.
    SetNextModIndex<public>(Index: int): void = external {}

    # If `Override` is `true`, destroying the mod box with a vehicle will trigger `ModApplyOverriddenEvent` and a mod will not be applied.
    #  * In this case, destroying the mod box will not trigger `ModAppliedEvent`, `ModApplyFailEvent`, or `NoModEvent`.
    #  * The values returned by `ModApplyOverriddenEvent` can be used for `TryApplyModByAgent` and `TryApplyModByVehicle`, so the event can be handled manually.
    #  * See `ModApplyOverriddenEvent` for more information.
    SetOverrideModApplyEvent<public>(Override: logic): void = external {}

    # Set the remaining time (in seconds) on the respawn timer (clamped to a minimum of `0.0`). The device must be enabled.
    #  * This also sets the length of this device's future respawn timers.
    SetRespawnTimer<public>(Time: float): void = external {}

    # Spawn a mod box if the device is enabled. If one is already spawned, spawn a new one without triggering `BoxDestroyEvent`.
    SpawnBox<public>(): void = external {}

    # Spawn the same mod box this device spawned before the current one. If a mod box is already spawned, despawn that first without triggering `BoxDestroyEvent`.
    #  * Does nothing if this device is disabled or has not spawned more than one mod box.
    SpawnLastChosenMod<public>(): void = external {}

    # Spawn the mod box at `Index` in the device's list. If a mod box is already spawned, despawn that first without triggering `BoxDestroyEvent`.
    #  * The first index in the list is `0` for Custom List Mod 1.
    #  * Does nothing if this device is disabled, *Possible Mods* is not set to `Custom List`, or `Index` is invalid.
    SpawnModBoxByIndex<public>(Index: int): void = external {}

    # Despawn the box if necessary without triggering `BoxDestroyEvent`, then start the spawn timer. The device must be enabled.
    StartSpawnTimer<public>(): void = external {}

    # Apply the mod at `Index` in the device's list to the vehicle that `Agent` is riding.
    #  * The first index in the list is `0` for Custom List Mod 1.
    #  * Triggers `ModAppliedEvent`, `ModApplyFailEvent`, and `NoModEvent` as appropriate, regardless of `SetOverrideModApplyEvent`.
    #  * Fails if this device is disabled, *Possible Mods* is not set to `Custom List`, `Index` or `Agent` is invalid, or `Agent` is not riding a vehicle.
    TryApplyModByAgent<public>(Index: int, Agent: agent)<transacts><decides>: void = external {}

    # Apply the mod at `Index` in the device's list to `Vehicle`.
    #  * The first index in the list is `0` for Custom List Mod 1.
    #  * Triggers `ModAppliedEvent`, `ModApplyFailEvent`, and `NoModEvent` as appropriate, regardless of `SetOverrideModApplyEvent`.
    #  * Fails if this device is disabled, *Possible Mods* is not set to `Custom List`, or `Index` or `Vehicle` is invalid.
    #  * `Vehicle` must be an actual `fort_vehicle`. A vehicle spawner device will not be valid.
    #  * `ModApplyOverriddenEvent`, `ModAppliedEvent`, `ModApplyFailEvent`, and `NoModEvent` are a few ways to get a `fort_vehicle` value.
    TryApplyModByVehicle<public>(Index: int, Vehicle: fort_vehicle)<transacts><decides>: void = external {}

    # An array containing the custom settings for each entry in the device's custom list.
    #  * Index `0` applies to Custom List Mod 1, index `1` applies to Custom List Mod 2, and so on.
    #  * The contents of each entry in the array can be individually set and returned.
    #  * If *Possible Mods* is not set to `Custom List`, this array will be empty.
    var<private> ModBoxCustomListSettings<public>: []vehicle_mod_box_settings = external {}

    # Contains the custom settings for *Overall Visual Style*, which can be individually set and returned.
    var<private> ModBoxOverallSettings<public>: vehicle_mod_box_settings = external {}
  }

  # Specialized `vehicle_spawner_device` that allows an Armored Assault Tank to be configured and spawned.
  vehicle_spawner_armored_assault_tank_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows an armored battle bus to be configured and spawned.
  vehicle_spawner_armored_battle_bus_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows an armored transport to be configured and spawned.
  vehicle_spawner_armored_transport_device<public> := class<concrete><final>(vehicle_spawner_device) {
    var<private> Vault<public>: bank_vault_interface = external {}
  }

  # Specialized `vehicle_spawner_device` that allows an ATK (all terrain kart) to be configured and spawned.
  vehicle_spawner_atk_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a Baller vehicle to be configured and spawned.
  vehicle_spawner_baller_device<public> := class<concrete><final>(vehicle_spawner_device) {
    # Signaled when the vehicle runs out of energy.
    OutOfEnergyEvent<public>: listenable(tuple()) = external {}

    # Refills the vehicle's energy.
    RefillEnergy<public>(): void = external {}
  }

  # Specialized `vehicle_spawner_device` that allows a Mudflap semi truck to be configured and spawned.
  vehicle_spawner_big_rig_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a Stormwing biplane to be configured and spawned.
  vehicle_spawner_biplane_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a boat to be configured and spawned.
  vehicle_spawner_boat_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a cannon to be configured and spawned.
  vehicle_spawner_cannon_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Base class for various specialized vehicle spawners which allow specific vehicle types to be spawned and configured with specialized options.
  vehicle_spawner_device<public> := class<abstract><epic_internal>(creative_device_base) {
    # Signaled when an `agent` enters the vehicle.
    # Sends the `agent` that entered the vehicle.
    AgentEntersVehicleEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` exits the vehicle.
    # Sends the `agent` that exited the vehicle.
    AgentExitsVehicleEvent<public>: listenable(agent) = external {}

    # Sets `agent` as the vehicle's driver.
    AssignDriver<public>(Agent: agent): void = external {}

    # Destroys the vehicle if it exists.
    DestroyVehicle<public>(): void = external {}

    # Signaled when a vehicle is destroyed.
    DestroyedEvent<public>: listenable(tuple()) = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Spawns a new vehicle. The previous vehicle will be destroyed before a new vehicle spawns.
    RespawnVehicle<public>(): void = external {}

    # Signaled when a vehicle is spawned or respawned by this device.
    # Sends the fort_vehicle who was spawned.
    SpawnedEvent<public>: listenable(fort_vehicle) = external {}

    # Signaled when a vehicle is destroyed.
    # Deprecated, use DestroyedEvent instead.
    VehicleDestroyedEvent<public>: listenable(tuple()) = external {}

    # Signaled when a vehicle is spawned or respawned by this device.
    # Deprecated, use SpawnedEvent instead.
    VehicleSpawnedEvent<public>: listenable(tuple()) = external {}
  }

  # Specialized `vehicle_spawner_device` that allows a DF.9 turret to be configured and spawned.
  vehicle_spawner_df9_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a dirtbike to be configured and spawned.
  vehicle_spawner_dirtbike_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a Driftboard to be configured and spawned.
  vehicle_spawner_driftboard_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  vehicle_spawner_drivable_reboot_van_device<public> := class<concrete><final>(
    vehicle_spawner_device,
    reboot_van_interface
  ) {
    # Disable the device.
    DisableReboot<override>(): void = external {}

    # Disable the revival seat.
    DisableRevive<public>(): void = external {}

    # Enable the device.
    EnableReboot<override>(): void = external {}

    # Enable the revival seat.
    EnableRevive<public>(): void = external {}

    # Succeeds if the device is enabled, fails if it's disabled.
    IsEnabledReboot<override>()<transacts><decides>: void = external {}

    # Succeeds if the revival seat is enabled, fails if it's disabled.
    IsEnabledRevive<public>()<transacts><decides>: void = external {}

    # Triggers when a player purchases a Reboot Card.
    #  * `agent` is the player that purchased the Reboot Card.
    RebootCardPurchaseEvent<override>: listenable(agent) = external {}

    # Triggers when Reboot Van has finished rebooting a set of players.
    #  * `agent`is the player that started the reboot.
    RebootEvent<override>: listenable(agent) = external {}

    # Triggers when Reboot Van has finished recharging.
    #  * `agent` is the last interacting player.
    RechargeCompleteEvent<override>: listenable(?agent) = external {}

    # Triggers when Reboot Van has finished reviving a player from DBNO.
    #  * `agent` is the player that was just revived.
    ReviveCompleteEvent<public>: listenable(agent) = external {}

    # Determines if players can purchase an eliminated player's reboot card.
    var CanPurchaseRebootCard<override>: logic = external {}

    # Multiplier on the decay rate of reboot progress. Clamped between `0.1` and `2.0`.
    #  * Only used if `RebootProgressDecay` is set to `Custom Decay`.
    var DecayRateMultiplier<override>: ?float = external {}

    # Purchase reboot card options.
    #  * Only used if `CanPurchaseRebootCard` is `true`.
    var PurchaseRebootCardOptions<override>: ?reboot_card_purchase_options = external {}

    # How quickly reboot progress decays when nobody is interacting with the Reboot Van. Custom Decay - Set a custom multiplier on the decay rate. Instant Reset - Instantly reset progress to zero. Battle Royale - Use Battle Royale's decay rate.
    var RebootProgressDecay<override>: reboot_progress_decay_behavior = external {}

    # The remaining time (in seconds) on the recharge timer. Clamped between `0.0` and `3600.0`.
    #  * If there is no active timer, getting returns `0.0`.
    #  * If there is no active timer, setting does nothing.
    var RechargeTimer<override>: float = external {}

    # The length of the recharge timer in seconds, regardless of the timer's current state. Clamped between `0.0` and `3600.0`.
    var RechargeTimerLength<override>: float = external {}
  }

  # Specialized `vehicle_spawner_device` that allows a GetAway Car to be configured and spawned.
  vehicle_spawner_getaway_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a Hammerhead Choppa to be configured and spawned.
  vehicle_spawner_hammerhead_choppa_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows an anti-vehicle turret to be configured and spawned.
  vehicle_spawner_heavy_turret_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a helicopter to be configured and spawned.
  vehicle_spawner_helicopter_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows an N-1 Starfighter to be configured and spawned.
  vehicle_spawner_n1_starfighter_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a Nitro Drifter sedan to be configured and spawned.
  vehicle_spawner_nitro_drifter_sedan_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Spawns a lightweight vehicle made for defying gravity with its rocket boosting, jumping, and aerial maneuverability capabilities.
  vehicle_spawner_octane_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a pickup truck to be configured and spawned.
  vehicle_spawner_pickup_truck_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a Quadcrasher to be configured and spawned.
  vehicle_spawner_quadcrasher_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a Rocket Racing Vehicle to be configured and spawned.
  vehicle_spawner_rocketracing_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a Prevalent sedan to be configured and spawned.
  vehicle_spawner_sedan_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a shopping cart to be configured and spawned.
  vehicle_spawner_shopping_cart_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a siege cannon to be configured and spawned.
  vehicle_spawner_siege_cannon_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a sportbike to be configured and spawned.
  vehicle_spawner_sportbike_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a Whiplash sports car to be configured and spawned.
  vehicle_spawner_sports_car_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a surfboard to be configured and spawned.
  vehicle_spawner_surfboard_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a tank to be configured and spawned.
  vehicle_spawner_tank_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a taxi to be configured and spawned.
  vehicle_spawner_taxi_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a TIE Fighter to be configured and spawned.
  vehicle_spawner_tie_fighter_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a Turbolaser turret to be configured and spawned.
  vehicle_spawner_turbolaser_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a UFO to be configured and spawned.
  vehicle_spawner_ufo_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a valet SUV to be configured and spawned.
  vehicle_spawner_valet_suv_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows a war bus to be configured and spawned.
  vehicle_spawner_war_bus_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Specialized `vehicle_spawner_device` that allows an X-wing to be configured and spawned.
  vehicle_spawner_xwing_device<public> := class<concrete><final>(vehicle_spawner_device) {}

  # Holds and spawns items, with an optional cost for each item. Can hold up to three items, and `agent`s can cycle between these by hitting the machine with their pickaxe.
  vending_machine_device<public> := class<concrete><final>(creative_device_base) {
    # Cycles the screen to show the next item.
    CycleToNextItem<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when an item is spawned from this device.
    # Sends the `agent` that used this device.
    ItemSpawnedEvent<public>: listenable(agent) = external {}

    # Spawns an item.
    SpawnItem<public>(): void = external {}
  }

  # Used to create and customize your own visual effects. This is more flexible than the `vfx_spawner_device`, which gives you a selection of pre-made visual effects to choose from but limits how much you can customize or change those effects.
  vfx_creator_device<public> := class<concrete><final>(creative_device_base) {
    # Starts playing the effect.
    Begin<public>(): void = external {}

    # Starts the effect at `Agent`'s location. This option is only valid if *Stick to Player* is enabled.
    Begin<public>(Agent: agent): void = external {}

    # Starts the effect at every `agent`'s location. This option is only valid if *Stick to Player* is enabled.
    BeginForAll<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Ends playing the effect.
    End<public>(): void = external {}

    # Ends the effect at `Agent`'s location. This option is only valid if *Stick to Player* is enabled.
    End<public>(Agent: agent): void = external {}

    # Ends the effect at every `agent`'s locations. This option is only valid if *Stick to Player* is enabled.
    EndForAll<public>(): void = external {}

    # Removes the effect from `Agent` and continues playing at the device location. This option is only valid if *Stick to Player* is enabled.
    Remove<public>(Agent: agent): void = external {}

    # Removes the effect for every `agent` and continues playing at the device location. This option is only valid if *Stick to Player* is enabled.
    RemoveFromAll<public>(): void = external {}

    # Spawns the effect at `Agent`'s location. This option is only valid if *Stick to Player* is enabled.
    SpawnAt<public>(Agent: agent): void = external {}

    # Toggles between `Begin` and `End`.
    Toggle<public>(): void = external {}

    # Toggles between `Begin` and `End`.
    Toggle<public>(Agent: agent): void = external {}

    # Toggles between `Enable` and `Disable`.
    ToggleEnabled<public>(): void = external {}

    # Toggles between `BeginForAll` and `EndForAll`.
    ToggleForAll<public>(): void = external {}

    # Pauses the effect if the effect is running. If the effect is paused, unpauses the effect. Pausing an effect causes the effect to freeze in place.
    TogglePause<public>(): void = external {}

    # Pauses the effect at `Agent`'s locations if it is playing, or resumes the effect if it is paused.
    # When paused the effect freezes in place.
    TogglePause<public>(Agent: agent): void = external {}

    # Pauses the effect at every `agent`'s locations if it is playing, or resumes the effect if it is paused.
    # When paused the effect freezes in place.
    TogglePauseForAll<public>(): void = external {}
  }

  # Used to place visual effects around your island. You can use these effects to enhance the overall theme and experience of your game.
  vfx_spawner_device<native><public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Signaled when the effect is disabled.
    EffectDisabledEvent<public>: listenable(tuple()) = external {}

    # Signaled when the effect is enabled.
    EffectEnabledEvent<public>: listenable(tuple()) = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Restarts the VFX. Triggers the VFX if it's Burst VFX.
    Restart<native><public>(): void
  }

  # Used to display curated videos onto in-game screens or player HUDs.
  video_player_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device.
    Disable<public>(): void = external {}

    # Disables collision checks on this device.
    DisableCollision<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Enables collision checks on this device.
    EnableCollision<public>(): void = external {}

    # Turns off all streaming devices of this type on the island.
    EndForAll<public>(): void = external {}

    # Transitions to fullscreen for `Agent`.
    EnterFullScreen<public>(Agent: agent): void = external {}

    # Transitions to fullscreen for `Agent`.
    ExitFullScreen<public>(Agent: agent): void = external {}

    # Hides the picture-in-picture video from `Agent`.
    HidePIP<public>(Agent: agent): void = external {}

    # Transitions the picture-in-picture video to the default size for `Agent`.
    MakePIPDefaultSize<public>(Agent: agent): void = external {}

    # Transitions the picture-in-picture video to full screen for `Agent`.
    MakePIPFullScreen<public>(Agent: agent): void = external {}

    # If any streaming device has forced control of the stream, this will release it and play the highest priority stream in line.
    ReleaseControl<public>(): void = external {}

    # Restart the stream from the beginning.
    Restart<public>(): void = external {}

    # Seeks to the *Triggered Seek Time*. Caution: The stream will pause while the video buffers when seeking.
    Seek<public>(): void = external {}

    # Signaled when this device becomes the controlling streaming device for the `agent`.
    StreamStartedEvent<public>: listenable(agent) = external {}

    # Stops the currently playing stream and starts the custom stream with the audio only playing from this device. *Stream Priority* will not work until control is released.
    TakeControl<public>(): void = external {}
  }

  # Used to create a customizable vine version of the Grind Rails.
  vine_rail_device<public> := class<concrete><final>(creative_device_base) {
    # Disables this device, preventing players from grinding on the vines.
    Disable<public>(): void = external {}

    # Enables this device, letting players grind on the vines.
    Enable<public>(): void = external {}

    # Signaled when an `agent` starts grinding on this `vine_rail_device`.
    EndedGrindingEvent<public>: listenable(agent) = external {}

    # Hides the track. Players can still grind on the track if it is enabled.
    Hide<public>(): void = external {}

    # Make this track visible.
    Show<public>(): void = external {}

    # Signaled when an `agent` starts grinding on this `vine_rail_device`.
    StartedGrindingEvent<public>: listenable(agent) = external {}
  }

  # Used to trigger a visual effect (a glow or an outline) when `agent`s pick it up.
  visual_effect_powerup_device<public> := class<concrete><final>(powerup_device) {}

  # Used to track when agents enter and exit a volume.
  volume_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when an `agent` enters the device volume.
    AgentEntersEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` exits the device volume.
    AgentExitsEvent<public>: listenable(agent) = external {}

    # Returns an array of agents that are currently occupying the volume.
    GetAgentsInVolume<public>()<reads>: []agent = external {}

    # Succeeds when `Agent` is in the volume.
    IsInVolume<public>(Agent: agent)<transacts><decides>: void = external {}

    # Signaled when an `creative_prop` entered the device volume.
    PropEnterEvent<public>: listenable(creative_prop) = external {}

    # Signaled when an `creative_prop` exited the device volume.
    PropExitEvent<public>: listenable(creative_prop) = external {}
  }

  using { /Verse.org/Simulation }
  #  Represents a poll.
  # For example, in a poll “What to have for lunch?” the group represents the question and contains the possible answers.
  # Owns the overall state of the poll and keeps track of available options.
  # A group can have multiple options, connected via an internal ID.
  vote_group_device<public> := class<concrete><final>(creative_device_base) {
    # Allows votes to be cast for this group’s options, and starts a timer if applicable.
    BeginVote<final><public>(): void = external {}

    # Triggered when voting begins.
    BeginVoteEvent<final><public>: listenable(tuple()) = external {}

    # Prevents any more votes from being cast and picks a winner based on vote count.
    EndVote<final><public>(): void = external {}

    # Triggered when voting has completed.
    EndVoteEvent<final><public>: listenable(tuple()) = external {}

    # The total number of times each player can vote in this poll.
    #  If zero or less, players cannot vote.
    GetMaxVotesPerPlayer<final><public>(): int = external {}

    # The display text for this poll.
    #  For example the string “What to have for lunch?”
    GetPollQuestion<final><public>(): message = external {}

    # The amount of time this poll is available before ending, in seconds.
    #  If set to zero, the poll will not be ended by a time limit.
    GetTimeLimit<final><public>(): float = external {}

    # Get the list of options currently in this voting group.
    GetVotingOptions<final><public>(): []vote_option_interface = external {}

    # Triggered when voting ends and at least two options are tied for first place.
    VoteTiedEvent<final><public>: listenable(tuple()) = external {}
  }

  vote_option_device<public> := class(vote_option_interface, creative_device_base) {
    CastVote<override>(Agent: agent)<transacts><decides>: void = external {}

    CastVoteEvent<override>: listenable(agent) = external {}

    GetOptionDescription<override>(): message = external {}

    GetVoteCount<override>(): int = external {}

    GetVoteGroup<override>(): ?vote_group_device = external {}

    HasAgentVoted<override>(Agent: agent)<transacts><decides>: void = external {}

    WinVoteEvent<override>: listenable(?agent) = external {}
  }

  # Represents an individual choice in a poll.
  #  For example, in a poll “What to have for lunch?” an option might be “Tacos”
  #  Tracks how many times each agent has voted for this option.
  #  An option is associated with only one group device (or “poll”) via an internal ID.
  vote_option_interface<public> := interface {
    # Attempts to cast a vote for ‘Agent’
    #  If the voting agent has votes remaining and the voting group has started a vote, the vote will be cast successfully.
    #  Fails if Agent does not have votes remaining or voting group has not started.
    CastVote<public>(Agent: agent)<transacts><decides>: void

    # Triggered when a vote is cast by ‘agent’
    CastVoteEvent<public>: listenable(agent)

    # The string to display to the user when choosing which option to select.
    GetOptionDescription<public>(): message

    # Returns the total votes cast for this option.
    GetVoteCount<public>(): int

    # Returns the group device this option corresponds to, if any.
    #  Fails if the option is not in a group, or there is no corresponding group device with the same ID.
    GetVoteGroup<public>(): ?vote_group_device

    # Succeeds if `Agent` has voted for this option, fails if not.
    HasAgentVoted<public>(Agent: agent)<transacts><decides>: void

    # Triggered if this option wins the vote.
    WinVoteEvent<public>: listenable(?agent)
  }

  # Used to create and manipulate volumes of water where players can swim, fish, or drive boats.
  water_device<public> := class<concrete><final>(creative_device_base) {
    # Signaled when an `agent` enters the water.
    # Sends `agent` that entered the water.
    AgentEntersWaterEvent<public>: listenable(agent) = external {}

    # Signaled when an `agent` exits the water.
    # Sends `agent` that exited the water.
    AgentExitsWaterEvent<public>: listenable(agent) = external {}

    # Starts vertically emptying the water in the volume.
    BeginVerticalEmptying<public>(): void = external {}

    # Starts vertically filling the water in the volume.
    BeginVerticalFilling<public>(): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Resets the water level in the volume to the value set in the *Default Vertical Water Percentage* option.
    (/Fortnite.com/Devices/water_device:)Reset<public>(): void = external {}

    # Resumes either filling or emptying the volume.
    ResumeVerticalMovement<public>(): void = external {}

    # Stops filling or emptying the volume.
    StopVerticalMovement<public>(): void = external {}

    # Signals when the water volume is completely empty.
    VerticalEmptyingCompletedEvent<public>: listenable(tuple()) = external {}

    # Signals when the volume is filled to the water level set in the *Default Vertical Water Percentage* option.
    VerticalFillingCompletedEvent<public>: listenable(tuple()) = external {}
  }

  # Used to customize the properties of NPCs spawned by this device.
  # Changing properties will only affect newly spawned wildlife creatures.
  wildlife_spawner_device<public> := class<concrete><final>(creative_device_base) {
    # Consumes energy from wildlife belonging to `Agent` by *Energy Consume Amount*.
    ConsumeEnergy<public>(Agent: agent): void = external {}

    # Consumes energy from wildlife by *Energy Consume Amount*.
    ConsumeEnergyForAll<public>(): void = external {}

    # Signaled when wildlife is damaged.
    # `Source` is the `agent` that damaged the wildlife. If the wildlife was damaged by a non-agent then `false` is returned.
    # `Target` is the wildlife that was damaged.
    DamagedEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Despawns wildlife. `Agent` is marked as the one who eliminated the wildlife.
    Despawn<public>(Agent: agent): void = external {}

    # Destroys this device, marking `Agent` as the destroyer of the device.
    DestroySpawner<public>(Agent: agent): void = external {}

    # Disables this device.
    Disable<public>(): void = external {}

    # Dismounts `Agent` from wildlife.
    Dismount<public>(Agent: agent): void = external {}

    # Dismounts all `agent`s from wildlife.
    DismountAll<public>(): void = external {}

    # Signaled when an `agent` dismounts wildlife.
    # `Source` is the `agent` that dismounted the wildlife.
    # `Target` is the wildlife that was dismounted.
    DismountedEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Signaled when wildlife is eliminated.
    # `Source` is the `agent` that eliminated the wildlife. If the wildlife was eliminated by a non-agent, or because the oldest wildlife was eliminated as Spawn function was called after spawn count was exceeded, then `Source` is 'false'.
    # `Target` is the wildlife that was eliminated.
    EliminatedEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Signaled when a wildlife eliminates an agent.
    # `Source` is the wildlife that eliminated the agent.
    # `Target` is the agent that was eliminated.
    EliminatingEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Enables this device.
    Enable<public>(): void = external {}

    # Signaled when wildlife is force-spawned and causes the oldest wildlife to be eliminated.
    # Sends the `agent` wildlife that was spawned.
    ForceSpawnedEvent<public>: listenable(agent) = external {}

    # Get all agents created by this device.
    GetAgents<public>()<transacts>: []agent = external {}

    # Returns the spawn limit of the device.
    GetSpawnLimit<public>()<transacts>: int = external {}

    # Resets the count on the *Total Spawn Count* option.
    (/Fortnite.com/Devices/wildlife_spawner_device:)Reset<public>(): void = external {}

    # Restores energy to wildlife belonging to `Agent` by *Energy Restore Amount*.
    RestoreEnergy<public>(Agent: agent): void = external {}

    # Restores energy to wildlife by *Energy Restore Amount*.
    RestoreEnergyForAll<public>(): void = external {}

    # Signaled when an `agent` rides wildlife.
    # `Source` is the `agent` that started riding the wildlife.
    # `Target` is the wildlife that was ridden.
    RiddenEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Teleports `Agent` to the nearest wildlife, then `Agent` mounts that wildlife.
    Ride<public>(Agent: agent): void = external {}

    # Signaled when wildlife eats a pickup such as a Shroom or Meat.
    #  Sends the wildlife that ate something.
    SomethingIsEatenEvent<public>: listenable(agent) = external {}

    # Spawns wildlife from this device. If spawn count is exceeded the oldest wildlife will be eliminated.
    Spawn<public>(): void = external {}

    # Spawn a creature at the given position. When Rotation is not provided, it will default to the Device`s rotation.
    # Returns the agent spawned or false if the device has reached its maximum spawn count.
    # This function is `<suspends>` because it takes time to load the NPC before it can be returned.
    SpawnAt<public>(
      Position: (/Verse.org/SpatialMath:)vector3,
      ?Rotation: ?(/Verse.org/SpatialMath:)rotation = external {}
    )<suspends>: ?agent = external {}

    # Signaled when this device spawns wildlife.
    # Sends the `agent` wildlife that was spawned.
    SpawnedEvent<public>: listenable(agent) = external {}

    # Tames wildlife, making them AI partners of `Agent`.
    Tame<public>(Agent: agent): void = external {}

    # Signaled when wildlife is tamed.
    # `Source` is the `agent` that tamed the wildlife.
    # `Target` is the wildlife that was tamed.
    TamedEvent<public>: listenable(device_ai_interaction_result) = external {}

    # Untames any tamed wildlife that belong to `Agent`.
    Untame<public>(Agent: agent): void = external {}

    # Untames all wildlife.
    UntameAll<public>(): void = external {}

    # Signaled when wildlife is untamed.
    # `Source` is the `agent` that tamed the wildlife.
    # `Target` is the wildlife that was untamed.
    UntamedEvent<public>: listenable(device_ai_interaction_result) = external {}

    # If true, agents can ride the wildlife creature.
    var CanRide<public>: logic = external {}

    # If true and the wildlife creature supports being tamed, agents can tame the NPC.
    var CanTame<public>: logic = external {}

    # If a value is given, the `Damage` value of the wildlife creature is overridden.
    # If an override is not specified, the default `Damage` of the wildlife creature is used.
    # This value is clamped between 1.0 and 500.0.
    var Damage<public>: ?float = external {}

    # If a value is given, the `Damage` value of the wildlife creature is overridden when damaging the environment.
    # If an override is not specified, the default `Damage` of the wildlife creature is used.
    # This value is clamped between 1.0 and 500.0.
    var DamageToEnvironment<public>: ?float = external {}

    # If a value is given, the `Damage` value of the wildlife creature is overridden when damaging players.
    # If an override is not specified, the default `Damage` of the wildlife creature is used.
    # This value is clamped between 1.0 and 500.0.
    var DamageToPlayer<public>: ?float = external {}

    # The amount of riding energy that is consumed when the `ConsumeEnergy` function is called.
    # This value is clamped between 0 and 100.
    var EnergyConsumptionAmount<public>: int = external {}

    # The amount of riding energy that is restored when the `RestoreEnergy` function is called.
    # This value is clamped between 0 and 100.
    var EnergyRestorationAmount<public>: int = external {}

    # The amount of riding energy the wildlife creature spawns with.
    # This value is clamped between 0 and 100.
    var InitialEnergy<public>: int = external {}

    # Whether the NPC can receive damage.
    var Invincible<public>: logic = external {}

    # The maximum riding energy the wildlife creature spawns with.
    # This value is clamped between 0 and 100.
    var MaxEnergy<public>: int = external {}

    # If a value is given, the `MaxHealth` value of the wildlife creature is overridden.
    # If an override is not specified, the default Health of the wildlife creature is used.
    # This value is clamped between 1.0 and 10000.0.
    var MaxHealth<public>: ?float = external {}

    # If true, agents cannot manually use the interact action to dismount from the wildlife creature.
    var PreventDismount<public>: logic = external {}

    # If a value is given, the `SpeedMultiplier` value is applied to the default speed of the wildlife creature.
    # If an override is not specified, the wildlife creature moves at its default speed.
    # This value is clamped between 0.1 and 2.0.
    var SpeedMultiplier<public>: float = external {}

    # Distance in meters from the player who tamed it that the wildlife creature will try to stay within.
    # If a value is given, the `TamedFollowDistance` value of the wildlife creature is overridden.
    # If an override is not specified, the default `TamedFollowDistance` of the wildlife creature is used.
    # This value is clamped between 2.0 and 30.0.
    var TamedFollowDistance<public>: ?float = external {}

    # Distance in meters from its spawn position from which the wildlife creature will peacefully roam.
    # If a value is given, the `WanderRange` value of the wildlife creature is overridden.
    # If an override is not specified, the default `WanderRange` of the wildlife creature is used.
    # This value is clamped between 10.0 and 100.0.
    var WanderRange<public>: ?float = external {}
  }

  # Used to create plants with explosive pods that players can detonate and launch.
  wilds_plant_device<public> := class<concrete><final>(creative_device_base) {
    # Disables the device to prevent interaction and growth.
    Disable<public>(): void = external {}

    # Enables the device to allow interaction and let it grow.
    Enable<public>(): void = external {}

    # Detonates the plant if the device is enabled.
    Explode<public>(): void = external {}

    # Triggers whenever the plant or launched projectile explodes.
    #  * Sends the `agent` that initially launched the projectile or triggered an immediate explosion.
    #  * Sends `false` if no `agent` is found.
    ExplodeEvent<public>: listenable(?agent) = external {}

    # Grows the plant if the device is enabled. If *Infinite Regrowths* is `false`, this is limited by *Maximum Regrowths*.
    Grow<public>(): void = external {}

    # Triggers whenever the plant grows.
    GrowEvent<public>: listenable(tuple()) = external {}

    # Triggers whenever the plant launches a projectile.
    #  * Sends the `agent` that triggered this event.
    #  * Sends `false` if no `agent` is found.
    LaunchEvent<public>: listenable(?agent) = external {}

    # Sets whether the plant can always regrow after launching a projectile or being destroyed.
    SetInfiniteRegrowths<public>(InfiniteRegrowths: logic): void = external {}

    # Sets how many times the plant can regrow after launching a projectile or being destroyed.
    #  * This applies across the device’s entire lifetime and is unaffected by *Enable* and *Disable*.
    #  * This value is clamped.
    SetMaximumRegrowths<public>(MaximumRegrowths: int): void = external {}
  }
}

# Module import path: /Fortnite.com/FortPlayerUtilities
FortPlayerUtilities<public> := module {
  # Returns the agent a spectator is currently spectating, fails if the spectator isn't spectating or isn't spectating an agent.
  (InAgent: agent).GetSpectatedAgent<native><public>()<reads><decides>: agent

  # Returns an `[]agent`s currently spectating `InAgent`.
  (InAgent: agent).GetSpectators<native><public>()<transacts>: []agent

  # Succeeds if `InAgent` is spectating the experience. Fails otherwise.
  (InAgent: agent).IsSpectator<native><public>()<transacts><decides>: void

  # Respawns the character for `InAgent` at the provided `RespawnPosition` and applies the yaw of `RespawnRotation`.
  (InAgent: agent).Respawn<native><public>(
    RespawnPosition: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
    RespawnRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
  )<transacts>: void

  # Returns an `[]player`s currently spectating `InPlayer`.
  (InPlayer: player).GetPlayersSpectating<native><public>()<transacts>: []player

  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /Verse.org/Simulation }
  # Sends `InPlayer` back to the main game lobby.
  (InPlayer: player).SendToLobby<native><public>()<transacts>: void
}

# Module import path: /Fortnite.com/Game
Game<public> := module {
  # Returns the round manager from the simulation entity.
  (InEntity: entity).GetFortRoundManager<public>()<transacts><decides>: fort_round_manager = external {}

  # Parameters for common damage functions on Fortnite objects.
  damage_args<native><public> := struct {
    # Amount of damage to apply to the object.
    Amount<native><public>: float

    # Player, agent, etc. that instigated the damage to the object.
    Instigator<native><public>: ?game_action_instigator = external {}

    # Player, weapon, vehicle, etc. that damaged the object.
    Source<native><public>: ?game_action_causer = external {}
  }

  # Results for damage events on Fortnite objects.
  damage_result<native><public> := struct<epic_internal> {
    # Amount of damage applied to `Target`.
    Amount<native><public>: float

    # Player, agent, etc. that instigated the damage to `Target`. Can be false when damage is instigated by code, the environment, etc.
    Instigator<native><public>: ?game_action_instigator = external {}

    # Player, weapon, vehicle, etc. that damaged `Target`. Can be false when damage is caused by code, the environment, etc.
    Source<native><public>: ?game_action_causer = external {}

    # Object that was damaged.
    Target<native><public>: damageable
  }

  # Implemented by Fortnite objects that can be damaged.
  damageable<native><public> := interface<epic_internal> {
    # Damage the `damageable` object anonymously by `Amount`. Setting `Amount` to less than 0 will cause no damage.
    # Use `Damage(:damage_args):void` when damage is being applied from a known instigator and source.
    Damage<public>(Amount: float): void

    # Damage the `damageable` object by `Args.Amount`. Setting `Amount` to less than 0 will cause no damage.
    Damage<public>(Args: damage_args): void

    # Signaled when damage is applied to the `damageable` object.
    DamagedEvent<public>(): listenable(damage_result)
  }

  using { /Fortnite.com/Characters }
  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /Verse.org/SceneGraph }
  # Result data for `fort_character` elimination events.
  elimination_result<native><public> := struct<epic_internal> {
    # The `fort_character` eliminated from the match by `EliminatingCharacter`.
    EliminatedCharacter<native><public>: fort_character

    # `fort_character` that eliminated `EliminatedCharacter` from the match. `EliminatingCharacter` will be false when `EliminatedCharacter` was eliminated through non-character actions, such as environmental damage.
    EliminatingCharacter<native><public>: ?fort_character
  }

  # This interface is implemented by the round manager living on the simulation entity.
  fort_round_manager<native><public> := interface<epic_internal> {
    # Subscribed callbacks will be invoked when a Fortnite round ends
    SubscribeRoundEnded<public>(Callback: type { _(): void }): cancelable

    # Subscribed callbacks will be invoked in two scenarios:
    #  - When a new Fortnite round starts
    #  - If a round is ongoing, your callback will be invoked immediately
    # Upon the round ending, all callbacks will be canceled
    SubscribeRoundStarted<public>(Callback: type { _()<suspends>: void }): cancelable
  }

  # Implemented by Fortnite objects that can be passed through game action events, such as damage and heal.
  # For example: player, vehicle, or weapon.
  #
  # Event Listeners often use `game_action_causer` to pass along additional information about what weapon caused the damage.
  # Systems will then use that information for completing quests or processing game specific event logic.
  game_action_causer<native><public> := interface {}

  # Implemented by Fortnite objects that initiate game actions, such as damage and heal. For example, player or agents.
  # Event listeners often use `game_action_instigators` to calculate player damage scores.
  game_action_instigator<native><public> := interface<epic_internal> {}

  # Implemented by Fortnite objects that can be healed.
  healable<native><public> := interface<epic_internal> {
    # Heal the `healable` object anonymously by `Amount`. Setting `Amount` to less than 0 will cause no healing.
    # Use `Heal(:healing_args):void` when healing is being applied from a known instigator and source.
    Heal<public>(Amount: float): void

    # Cause `Args.Amount` damage to the `damageable` object. Setting `Amount` to less than 0 will cause no damage.
    Heal<public>(Args: healing_args): void

    # Signaled when healing is applied to the `healable` object.
    HealedEvent<public>(): listenable(healing_result)
  }

  # Parameters for common healing functions on Fortnite objects.
  healing_args<native><public> := struct {
    # Amount of healing to apply to the object.
    Amount<native><public>: float

    # Player, agents, etc. that instigated the healing of the object.
    Instigator<native><public>: ?game_action_instigator = external {}

    # Player, weapon, vehicle, etc. that healed the object.
    Source<native><public>: ?game_action_causer = external {}
  }

  # Results for healing events on Fortnite objects.
  healing_result<native><public> := struct<epic_internal> {
    # Amount of healing applied to `Target`.
    Amount<native><public>: float

    # Player, agent, etc. that instigated healing of the `Target`. Can be false when damage is instigated by code, the environment, etc.
    Instigator<native><public>: ?game_action_instigator = external {}

    # Player, weapon, vehicle, etc. that healed `Target`. Can be false when damage is caused by code, the environment, etc.
    Source<native><public>: ?game_action_causer = external {}

    # Object that was healed.
    Target<native><public>: healable
  }

  # Implemented by Fortnite objects that have health state and can be eliminated.
  healthful<native><public> := interface<epic_internal> {
    # Returns the health state of the object. This value will be between 0.0 and `GetMaxHealth`
    GetHealth<public>()<transacts>: float

    # Returns the maximum health of the object. This value will be between 1.0 and Inf.
    GetMaxHealth<public>()<transacts>: float

    # Sets the health state of the object to `Health`.
    #  * Health state will be clamped between 1.0 and `GetMaxHealth`.
    #  * Health state cannot be directly set to 0.0. To eliminate `healthful` objects use the `damageable.Damage` functions instead.
    SetHealth<public>(Health: float)<transacts>: void

    # Sets the maximum health state of the object.
    #  * MaxHealth will be clamped between 1.0 and Inf.
    #  * Current health state will be scaled up or down based on the scale difference between the old and new MaxHealth state.
    SetMaxHealth<public>(MaxHealth: float)<transacts>: void
  }

  # Implemented by objects to allow reading position information.
  positional<native><public> := interface<epic_internal> {
    # Returns the transform of the object.
    GetTransform<public>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)transform
  }

  # Implemented by Fortnite objects that have shields. A shield is a method of protection that can take incoming damage while leaving the health state unchanged.
  shieldable<native><public> := interface<epic_internal> {
    # Signaled when the shield is damaged.
    DamagedShieldEvent<public>(): listenable(damage_result)

    # Returns the maximum shield state of the object. This value will be between 0.0 and Inf.
    GetMaxShield<public>()<transacts>: float

    # Returns the shield state of the object. This value will be between 0.0 and `MaxShield`
    GetShield<public>()<transacts>: float

    # Signaled when the shield is healed.
    HealedShieldEvent<public>(): listenable(healing_result)

    # Sets the maximum shield state of the object.
    #  * MaxShield will be clamped between 0.0 and Inf.
    #  * Current shield state will be scaled up or down based on the scale difference between the old and new MaxShield state.
    SetMaxShield<public>(MaxShield: float)<transacts>: void

    # Sets the shield state of the object.
    #  * Shield state will be clamped between 0.0 and `MaxShield`.
    SetShield<public>(Shield: float)<transacts>: void
  }
}

using { /Verse.org/Native }
@available { MinUploadedAtFNVersion := 3720 }
# Module import path: /Fortnite.com/Input
(/Fortnite.com:)Input<public> := module {
  using { /Verse.org/Native }
  @available { MinUploadedAtFNVersion := 3720 }
  # Module import path: /Fortnite.com/Input/Character
  Character<public> := module {
    @available { MinUploadedAtFNVersion := 3720 }
    @experimental
    Crouch<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 3720 }
    @experimental
    Jump<public>: input_action(logic) = external {}

    using { /Verse.org/Assets }
    using { /Verse.org/Native }
    @available { MinUploadedAtFNVersion := 3720 }
    @experimental
    RangedWeaponMapping<public>: input_mapping = external {}

    @available { MinUploadedAtFNVersion := 3720 }
    @experimental
    Reload<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 3720 }
    @experimental
    Sprint<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 3720 }
    @experimental
    TraversalMapping<public>: input_mapping = external {}

    @available { MinUploadedAtFNVersion := 3720 }
    @experimental
    WeaponPrimary<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 3720 }
    @experimental
    WeaponSecondary<public>: input_action(logic) = external {}
  }
}

Itemization<public> := module {
  # Module import path: /Fortnite.com/Itemization/FortniteItemCategories
  FortniteItemCategories<public> := module {
    @experimental
    Ammo<public>: item_category = external {}

    @experimental
    Collectible<public>: item_category = external {}

    @experimental
    Currency<public>: item_category = external {}

    @experimental
    Resource<public>: item_category = external {}

    @experimental
    Trap<public>: item_category = external {}

    using { /UnrealEngine.com/Itemization }
    @experimental
    WorldItem<public>: item_category = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Module import path: /Fortnite.com/Itemization/FortniteRarities
  FortniteRarities<public> := module {
    using { /Verse.org/SceneGraph }
    @experimental
    Common<public>: rarity = external {}

    @experimental
    Epic<public>: rarity = external {}

    @experimental
    Legendary<public>: rarity = external {}

    @experimental
    Rare<public>: rarity = external {}

    @experimental
    Uncommon<public>: rarity = external {}
  }

  @experimental
  # `fort_inventory_ammo_component` is the inventory for Fortnite ammo.
  fort_inventory_ammo_component<native><public> := class<final>(fort_inventory_component) {}

  @experimental
  # `fort_inventory_build_hotbar_component` is the UEFN inventory for Fortnite build tools.
  fort_inventory_build_hotbar_component<native><public> := class<final>(fort_inventory_component) {}

  @experimental
  # `fort_inventory_collectible_component` is the inventory for Fortnite collectibles.
  fort_inventory_collectibles_component<native><public> := class<final>(fort_inventory_component) {}

  using { /UnrealEngine.com/Itemization }
  using { /Verse.org/Native }
  @experimental
  # `fort_inventory_component` is a shared class for all Fortnite inventories, with appropriate default UI and behavior.
  fort_inventory_component<native><public> := class<epic_internal>(inventory_component) {
    # Returns the item in the specified slot, if there is one.
    GetItemInSlot<native><public>(Slot: int)<reads><decides>: item_component

    # Returns the total number of slots in this inventory.
    GetMaxSlots<native><public>()<reads><decides>: int
  }

  @experimental
  # `fort_inventory_currencies_component` is the inventory for Fortnite currencies.
  fort_inventory_currencies_component<native><public> := class<final>(fort_inventory_component) {}

  @experimental
  # `fort_inventory_harvest_tool_component` is the UEFN inventory for the Fortnite harvest tool.
  fort_inventory_harvest_tool_component<native><public> := class<final>(fort_inventory_component) {}

  @experimental
  # `fort_inventory_resources_component` is the inventory for Fortnite resources.
  fort_inventory_resources_component<native><public> := class<final>(fort_inventory_component) {}

  @experimental
  # `fort_inventory_trap_component` is the UEFN inventory for the Fortnite trap slot.
  fort_inventory_trap_component<native><public> := class<final>(fort_inventory_component) {}

  @experimental
  # `fort_inventory_weapon_hotbar_component` is the UEFN inventory for Fortnite weapons and gadgets.
  fort_inventory_weapon_hotbar_component<native><public> := class<final>(fort_inventory_component) {
    # Sets the total number of slots.
    SetMaxSlots<native><public>(InNumSlots: int): void
  }
}

Items<public> := module {
  # Module import path: /Fortnite.com/Items/Acorn
  Acorn<public> := module {
    # Module import path: /Fortnite.com/Items/Acorn/Creative
    (/Fortnite.com/Items/Acorn:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Acorn_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/ActivePowercell
  ActivePowercell<public> := module {
    # Module import path: /Fortnite.com/Items/ActivePowercell/Creative
    (/Fortnite.com/Items/ActivePowercell:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      ActivePowercell_Epic<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/AdhesiveResin
  AdhesiveResin<public> := module {
    # Module import path: /Fortnite.com/Items/AdhesiveResin/Creative
    (/Fortnite.com/Items/AdhesiveResin:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      AdhesiveResin_Uncommon<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/AirStrike
  AirStrike<public> := module {
    # Module import path: /Fortnite.com/Items/AirStrike/BattleRoyale
    (/Fortnite.com/Items/AirStrike:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AirStrike/BattleRoyale/CH1S9
      (/Fortnite.com/Items/AirStrike/BattleRoyale:)CH1S9<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AirStrike_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AlienNanites
  AlienNanites<public> := module {
    # Module import path: /Fortnite.com/Items/AlienNanites/BattleRoyale
    (/Fortnite.com/Items/AlienNanites:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AlienNanites/BattleRoyale/CH2S7
      (/Fortnite.com/Items/AlienNanites/BattleRoyale:)CH2S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AlienNanites_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AmmoArrows
  AmmoArrows<public> := module {
    # Module import path: /Fortnite.com/Items/AmmoArrows/BattleRoyale
    (/Fortnite.com/Items/AmmoArrows:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AmmoArrows/BattleRoyale/CH2S6
      (/Fortnite.com/Items/AmmoArrows/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AmmoArrows_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AmmoHeavyBullets
  AmmoHeavyBullets<public> := module {
    # Module import path: /Fortnite.com/Items/AmmoHeavyBullets/BattleRoyale
    (/Fortnite.com/Items/AmmoHeavyBullets:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AmmoHeavyBullets/BattleRoyale/PreSeason
      (/Fortnite.com/Items/AmmoHeavyBullets/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AmmoHeavyBullets_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AmmoLightBullets
  AmmoLightBullets<public> := module {
    # Module import path: /Fortnite.com/Items/AmmoLightBullets/BattleRoyale
    (/Fortnite.com/Items/AmmoLightBullets:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AmmoLightBullets/BattleRoyale/PreSeason
      (/Fortnite.com/Items/AmmoLightBullets/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AmmoLightBullets_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AmmoMediumBullets
  AmmoMediumBullets<public> := module {
    # Module import path: /Fortnite.com/Items/AmmoMediumBullets/BattleRoyale
    (/Fortnite.com/Items/AmmoMediumBullets:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AmmoMediumBullets/BattleRoyale/PreSeason
      (/Fortnite.com/Items/AmmoMediumBullets/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AmmoMediumBullets_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AmmoRockets
  AmmoRockets<public> := module {
    # Module import path: /Fortnite.com/Items/AmmoRockets/BattleRoyale
    (/Fortnite.com/Items/AmmoRockets:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AmmoRockets/BattleRoyale/PreSeason
      (/Fortnite.com/Items/AmmoRockets/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AmmoRockets_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AmmoShells
  AmmoShells<public> := module {
    # Module import path: /Fortnite.com/Items/AmmoShells/BattleRoyale
    (/Fortnite.com/Items/AmmoShells:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AmmoShells/BattleRoyale/PreSeason
      (/Fortnite.com/Items/AmmoShells/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AmmoShells_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AnimalBones
  AnimalBones<public> := module {
    # Module import path: /Fortnite.com/Items/AnimalBones/BattleRoyale
    (/Fortnite.com/Items/AnimalBones:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AnimalBones/BattleRoyale/CH2S6
      (/Fortnite.com/Items/AnimalBones/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AnimalBones_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AnvilRocketLauncher
  AnvilRocketLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/AnvilRocketLauncher/BattleRoyale
    (/Fortnite.com/Items/AnvilRocketLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AnvilRocketLauncher/BattleRoyale/CH3S2
      (/Fortnite.com/Items/AnvilRocketLauncher/BattleRoyale:)CH3S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AnvilRocketLauncher_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        AnvilRocketLauncher_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        AnvilRocketLauncher_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Apple
  Apple<public> := module {
    # Module import path: /Fortnite.com/Items/Apple/BattleRoyale
    (/Fortnite.com/Items/Apple:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Apple/BattleRoyale/CH1S4
      (/Fortnite.com/Items/Apple/BattleRoyale:)CH1S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Apple_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ArcLightningGun
  ArcLightningGun<public> := module {
    # Module import path: /Fortnite.com/Items/ArcLightningGun/BattleRoyale
    (/Fortnite.com/Items/ArcLightningGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ArcLightningGun/BattleRoyale/CH7S1
      (/Fortnite.com/Items/ArcLightningGun/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ArcLightningGun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ArcLightningGun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        HumanBillsArcLightningGun_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ArmoredWall
  ArmoredWall<public> := module {
    # Module import path: /Fortnite.com/Items/ArmoredWall/BattleRoyale
    (/Fortnite.com/Items/ArmoredWall:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ArmoredWall/BattleRoyale/CH2S8
      (/Fortnite.com/Items/ArmoredWall/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ArmoredWall_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AscendedMyst
  AscendedMyst<public> := module {
    # Module import path: /Fortnite.com/Items/AscendedMyst/BattleRoyale
    (/Fortnite.com/Items/AscendedMyst:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AscendedMyst/BattleRoyale/CH6S3
      (/Fortnite.com/Items/AscendedMyst/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AscendedMyst_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AssaultRifle
  AssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/AssaultRifle/BattleRoyale
    (/Fortnite.com/Items/AssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AssaultRifle/BattleRoyale/CH2S2
      (/Fortnite.com/Items/AssaultRifle/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SkyesAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/AssaultRifle/BattleRoyale/CH4S1
      (/Fortnite.com/Items/AssaultRifle/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/AssaultRifle/BattleRoyale/CH4S1:)AssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/AssaultRifle/BattleRoyale/CH4S1:)AssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/AssaultRifle/BattleRoyale/CH4S1:)AssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/AssaultRifle/BattleRoyale/CH4S1:)AssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/AssaultRifle/BattleRoyale/CH4S1:)AssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/AssaultRifle/BattleRoyale/CH6S4
      (/Fortnite.com/Items/AssaultRifle/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/AssaultRifle/BattleRoyale/PreSeason
      (/Fortnite.com/Items/AssaultRifle/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/AssaultRifle/BattleRoyale/PreSeason:)AssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/AssaultRifle/BattleRoyale/PreSeason:)AssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/AssaultRifle/BattleRoyale/PreSeason:)AssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/AssaultRifle/BattleRoyale/PreSeason:)AssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/AssaultRifle/BattleRoyale/PreSeason:)AssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AuthorityKeycard
  AuthorityKeycard<public> := module {
    # Module import path: /Fortnite.com/Items/AuthorityKeycard/BattleRoyale
    (/Fortnite.com/Items/AuthorityKeycard:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AuthorityKeycard/BattleRoyale/CH2S3
      (/Fortnite.com/Items/AuthorityKeycard/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AuthorityKeycard_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AutoShotgun
  AutoShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/AutoShotgun/BattleRoyale
    (/Fortnite.com/Items/AutoShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AutoShotgun/BattleRoyale/CH3S1
      (/Fortnite.com/Items/AutoShotgun/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AutoShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        AutoShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        AutoShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        AutoShotgun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        AutoShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        AutoShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/AutomaticSniperRifle
  AutomaticSniperRifle<public> := module {
    # Module import path: /Fortnite.com/Items/AutomaticSniperRifle/BattleRoyale
    (/Fortnite.com/Items/AutomaticSniperRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/AutomaticSniperRifle/BattleRoyale/CH1SX
      (/Fortnite.com/Items/AutomaticSniperRifle/BattleRoyale:)CH1SX<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AutomaticSniperRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        AutomaticSniperRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        AutomaticSniperRifle_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/AutomaticSniperRifle/BattleRoyale/CH2S5
      (/Fortnite.com/Items/AutomaticSniperRifle/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        AutomaticSniperRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Bacon
  Bacon<public> := module {
    # Module import path: /Fortnite.com/Items/Bacon/Creative
    (/Fortnite.com/Items/Bacon:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Bacon_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/BallisticShield
  BallisticShield<public> := module {
    # Module import path: /Fortnite.com/Items/BallisticShield/BattleRoyale
    (/Fortnite.com/Items/BallisticShield:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BallisticShield/BattleRoyale/CH5S1
      (/Fortnite.com/Items/BallisticShield/BattleRoyale:)CH5S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BallisticShield_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Balloons
  Balloons<public> := module {
    # Module import path: /Fortnite.com/Items/Balloons/BattleRoyale
    (/Fortnite.com/Items/Balloons:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Balloons/BattleRoyale/CH1S6
      (/Fortnite.com/Items/Balloons/BattleRoyale:)CH1S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Balloons_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Banana
  Banana<public> := module {
    # Module import path: /Fortnite.com/Items/Banana/BattleRoyale
    (/Fortnite.com/Items/Banana:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Banana/BattleRoyale/CH1S8
      (/Fortnite.com/Items/Banana/BattleRoyale:)CH1S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Banana_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BananaOfTheGods
  BananaOfTheGods<public> := module {
    # Module import path: /Fortnite.com/Items/BananaOfTheGods/BattleRoyale
    (/Fortnite.com/Items/BananaOfTheGods:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BananaOfTheGods/BattleRoyale/CH5S2
      (/Fortnite.com/Items/BananaOfTheGods/BattleRoyale:)CH5S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BananaOfTheGods_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Bandage
  Bandage<public> := module {
    # Module import path: /Fortnite.com/Items/Bandage/BattleRoyale
    (/Fortnite.com/Items/Bandage:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Bandage/BattleRoyale/CH5S1
      (/Fortnite.com/Items/Bandage/BattleRoyale:)CH5S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/Bandage/BattleRoyale/CH5S1:)Bandage_Common<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/Bandage/BattleRoyale/PreSeason
      (/Fortnite.com/Items/Bandage/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/Bandage/BattleRoyale/PreSeason:)Bandage_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BandageBazooka
  BandageBazooka<public> := module {
    # Module import path: /Fortnite.com/Items/BandageBazooka/BattleRoyale
    (/Fortnite.com/Items/BandageBazooka:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BandageBazooka/BattleRoyale/CH2S1
      (/Fortnite.com/Items/BandageBazooka/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BandageBazooka_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BasicHammer
  BasicHammer<public> := module {
    # Module import path: /Fortnite.com/Items/BasicHammer/Creative
    (/Fortnite.com/Items/BasicHammer:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      BasicHammer_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/BasicSword
  BasicSword<public> := module {
    # Module import path: /Fortnite.com/Items/BasicSword/Creative
    (/Fortnite.com/Items/BasicSword:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      BasicSword_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/BassBoost
  BassBoost<public> := module {
    # Module import path: /Fortnite.com/Items/BassBoost/BattleRoyale
    (/Fortnite.com/Items/BassBoost:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BassBoost/BattleRoyale/CH6S3
      (/Fortnite.com/Items/BassBoost/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BassBoost_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        BassBoost_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        BassBoost_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Batteries
  Batteries<public> := module {
    # Module import path: /Fortnite.com/Items/Batteries/Creative
    (/Fortnite.com/Items/Batteries:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Batteries_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/BigBushBomb
  BigBushBomb<public> := module {
    # Module import path: /Fortnite.com/Items/BigBushBomb/BattleRoyale
    (/Fortnite.com/Items/BigBushBomb:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BigBushBomb/BattleRoyale/CH4S1
      (/Fortnite.com/Items/BigBushBomb/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BigBushBomb_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BirthdayPresents
  BirthdayPresents<public> := module {
    # Module import path: /Fortnite.com/Items/BirthdayPresents/BattleRoyale
    (/Fortnite.com/Items/BirthdayPresents:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BirthdayPresents/BattleRoyale/CH1S9
      (/Fortnite.com/Items/BirthdayPresents/BattleRoyale:)CH1S9<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BirthdayPresents_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BlastPowder
  BlastPowder<public> := module {
    # Module import path: /Fortnite.com/Items/BlastPowder/Creative
    (/Fortnite.com/Items/BlastPowder:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      BlastPowder_Uncommon<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/BlizzardGrenade
  BlizzardGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/BlizzardGrenade/BattleRoyale
    (/Fortnite.com/Items/BlizzardGrenade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BlizzardGrenade/BattleRoyale/CH6S1
      (/Fortnite.com/Items/BlizzardGrenade/BattleRoyale:)CH6S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BlizzardGrenade_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BoarHair
  BoarHair<public> := module {
    # Module import path: /Fortnite.com/Items/BoarHair/Creative
    (/Fortnite.com/Items/BoarHair:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      BoarHair_Uncommon<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/BoltActionSniperRifle
  BoltActionSniperRifle<public> := module {
    # Module import path: /Fortnite.com/Items/BoltActionSniperRifle/BattleRoyale
    (/Fortnite.com/Items/BoltActionSniperRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BoltActionSniperRifle/BattleRoyale/CH2S1
      (/Fortnite.com/Items/BoltActionSniperRifle/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BoltActionSniperRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        BoltActionSniperRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/BoltActionSniperRifle/BattleRoyale/PreSeason
      (/Fortnite.com/Items/BoltActionSniperRifle/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BoltActionSniperRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        BoltActionSniperRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        BoltActionSniperRifle_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BoogieBomb
  BoogieBomb<public> := module {
    # Module import path: /Fortnite.com/Items/BoogieBomb/BattleRoyale
    (/Fortnite.com/Items/BoogieBomb:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BoogieBomb/BattleRoyale/CH1S2
      (/Fortnite.com/Items/BoogieBomb/BattleRoyale:)CH1S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BoogieBomb_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BoomBolt
  BoomBolt<public> := module {
    # Module import path: /Fortnite.com/Items/BoomBolt/BattleRoyale
    (/Fortnite.com/Items/BoomBolt:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BoomBolt/BattleRoyale/CH5S3
      (/Fortnite.com/Items/BoomBolt/BattleRoyale:)CH5S3<public> := module {
        # Module import path: /Fortnite.com/Items/BoomBolt/BattleRoyale/CH5S3/Modular
        (/Fortnite.com/Items/BoomBolt/BattleRoyale/CH5S3:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          BoomBolt_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          BoomBolt_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          BoomBolt_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          RingmastersBoomBolt_Mythic<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BoomBow
  BoomBow<public> := module {
    # Module import path: /Fortnite.com/Items/BoomBow/BattleRoyale
    (/Fortnite.com/Items/BoomBow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BoomBow/BattleRoyale/CH1S8
      (/Fortnite.com/Items/BoomBow/BattleRoyale:)CH1S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BoomBow_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BoomBox
  BoomBox<public> := module {
    # Module import path: /Fortnite.com/Items/BoomBox/BattleRoyale
    (/Fortnite.com/Items/BoomBox:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BoomBox/BattleRoyale/CH1S7
      (/Fortnite.com/Items/BoomBox/BattleRoyale:)CH1S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BoomBox_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BoomSniperRifle
  BoomSniperRifle<public> := module {
    # Module import path: /Fortnite.com/Items/BoomSniperRifle/BattleRoyale
    (/Fortnite.com/Items/BoomSniperRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BoomSniperRifle/BattleRoyale/CH2S5
      (/Fortnite.com/Items/BoomSniperRifle/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BoomSniperRifle_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BottleRockets
  BottleRockets<public> := module {
    # Module import path: /Fortnite.com/Items/BottleRockets/BattleRoyale
    (/Fortnite.com/Items/BottleRockets:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BottleRockets/BattleRoyale/CH1S7
      (/Fortnite.com/Items/BottleRockets/BattleRoyale:)CH1S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BottleRockets_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Bouncer
  Bouncer<public> := module {
    # Module import path: /Fortnite.com/Items/Bouncer/BattleRoyale
    (/Fortnite.com/Items/Bouncer:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Bouncer/BattleRoyale/CH1S4
      (/Fortnite.com/Items/Bouncer/BattleRoyale:)CH1S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Bouncer_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BubbleShield
  BubbleShield<public> := module {
    # Module import path: /Fortnite.com/Items/BubbleShield/Ballistic
    (/Fortnite.com/Items/BubbleShield:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      BubbleShield_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/BugBlaster
  BugBlaster<public> := module {
    # Module import path: /Fortnite.com/Items/BugBlaster/BattleRoyale
    (/Fortnite.com/Items/BugBlaster:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BugBlaster/BattleRoyale/CH6S4
      (/Fortnite.com/Items/BugBlaster/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BugBlaster_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        BugBlaster_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        BugBlaster_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BurstAR
  BurstAR<public> := module {
    # Module import path: /Fortnite.com/Items/BurstAR/Ballistic
    (/Fortnite.com/Items/BurstAR:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      BurstAR_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/BurstAssaultRifle
  BurstAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/BurstAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/BurstAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/CH1S4
      (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale:)CH1S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/CH1S4:)BurstAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/CH1S4:)BurstAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/CH2S3
      (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        OceansBurstAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/CH2S8
      (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SlonesBurstAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/CH4MS1
      (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale:)CH4MS1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/CH4MS1:)BurstAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/CH4MS1:)BurstAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/CH4MS1:)BurstAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/CH4MS1:)BurstAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/CH4MS1:)BurstAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/PreSeason
      (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/PreSeason:)BurstAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/PreSeason:)BurstAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/BurstAssaultRifle/BattleRoyale/PreSeason:)BurstAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BurstQuadLauncher
  BurstQuadLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/BurstQuadLauncher/BattleRoyale
    (/Fortnite.com/Items/BurstQuadLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BurstQuadLauncher/BattleRoyale/CH2S5
      (/Fortnite.com/Items/BurstQuadLauncher/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BurstQuadLauncher_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BurstSMG
  BurstSMG<public> := module {
    # Module import path: /Fortnite.com/Items/BurstSMG/BattleRoyale
    (/Fortnite.com/Items/BurstSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BurstSMG/BattleRoyale/CH1S9
      (/Fortnite.com/Items/BurstSMG/BattleRoyale:)CH1S9<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BurstSMG_Common<public> := class<final><concrete>(entity) {}

        @experimental
        BurstSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        BurstSMG_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Bush
  Bush<public> := module {
    # Module import path: /Fortnite.com/Items/Bush/BattleRoyale
    (/Fortnite.com/Items/Bush:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Bush/BattleRoyale/CH1S1
      (/Fortnite.com/Items/Bush/BattleRoyale:)CH1S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Bush_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/BusinessTurret
  BusinessTurret<public> := module {
    # Module import path: /Fortnite.com/Items/BusinessTurret/BattleRoyale
    (/Fortnite.com/Items/BusinessTurret:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/BusinessTurret/BattleRoyale/CH4S4
      (/Fortnite.com/Items/BusinessTurret/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BusinessTurret_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Butter
  Butter<public> := module {
    # Module import path: /Fortnite.com/Items/Butter/Creative
    (/Fortnite.com/Items/Butter:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Butter_Uncommon<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/Cabbage
  Cabbage<public> := module {
    # Module import path: /Fortnite.com/Items/Cabbage/BattleRoyale
    (/Fortnite.com/Items/Cabbage:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Cabbage/BattleRoyale/CH2S3
      (/Fortnite.com/Items/Cabbage/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Cabbage_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CandyCorn
  CandyCorn<public> := module {
    # Module import path: /Fortnite.com/Items/CandyCorn/BattleRoyale
    (/Fortnite.com/Items/CandyCorn:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CandyCorn/BattleRoyale/CH2S4
      (/Fortnite.com/Items/CandyCorn/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CandyCorn_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CattyCornerKeycard
  CattyCornerKeycard<public> := module {
    # Module import path: /Fortnite.com/Items/CattyCornerKeycard/BattleRoyale
    (/Fortnite.com/Items/CattyCornerKeycard:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CattyCornerKeycard/BattleRoyale/CH2S3
      (/Fortnite.com/Items/CattyCornerKeycard/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CattyCornerKeycard_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CeilingZapper
  CeilingZapper<public> := module {
    # Module import path: /Fortnite.com/Items/CeilingZapper/BattleRoyale
    (/Fortnite.com/Items/CeilingZapper:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CeilingZapper/BattleRoyale/CH4MS1
      (/Fortnite.com/Items/CeilingZapper/BattleRoyale:)CH4MS1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CeilingZapper_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ChainsOfHades
  ChainsOfHades<public> := module {
    # Module import path: /Fortnite.com/Items/ChainsOfHades/BattleRoyale
    (/Fortnite.com/Items/ChainsOfHades:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ChainsOfHades/BattleRoyale/CH5S2
      (/Fortnite.com/Items/ChainsOfHades/BattleRoyale:)CH5S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ChainsOfHades_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Chainsaw
  Chainsaw<public> := module {
    # Module import path: /Fortnite.com/Items/Chainsaw/BattleRoyale
    (/Fortnite.com/Items/Chainsaw:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Chainsaw/BattleRoyale/CH5S4
      (/Fortnite.com/Items/Chainsaw/BattleRoyale:)CH5S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Chainsaw_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ChaosReloaderShotgun
  ChaosReloaderShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/ChaosReloaderShotgun/BattleRoyale
    (/Fortnite.com/Items/ChaosReloaderShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ChaosReloaderShotgun/BattleRoyale/CH7S2
      (/Fortnite.com/Items/ChaosReloaderShotgun/BattleRoyale:)CH7S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ChaosReloaderShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        ChaosReloaderShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ChaosReloaderShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        ChaosReloaderShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        ChaosReloaderShotgun_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        DarkVoyagersObliterator_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ChargeSMG
  ChargeSMG<public> := module {
    # Module import path: /Fortnite.com/Items/ChargeSMG/BattleRoyale
    (/Fortnite.com/Items/ChargeSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ChargeSMG/BattleRoyale/CH3S3
      (/Fortnite.com/Items/ChargeSMG/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ChargeSMG_Common<public> := class<final><concrete>(entity) {}

        @experimental
        ChargeSMG_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ChargeSMG_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        ChargeSMG_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        ChargeSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        ChargeSMG_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ChargeShotgun
  ChargeShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/ChargeShotgun/BattleRoyale
    (/Fortnite.com/Items/ChargeShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ChargeShotgun/BattleRoyale/CH2S3
      (/Fortnite.com/Items/ChargeShotgun/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ChargeShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        ChargeShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ChargeShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        ChargeShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        ChargeShotgun_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        KitsChargeShotgun_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ChiliChugSplash
  ChiliChugSplash<public> := module {
    # Module import path: /Fortnite.com/Items/ChiliChugSplash/BattleRoyale
    (/Fortnite.com/Items/ChiliChugSplash:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ChiliChugSplash/BattleRoyale/CH2S8
      (/Fortnite.com/Items/ChiliChugSplash/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ChiliChugSplash_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Chiller
  Chiller<public> := module {
    # Module import path: /Fortnite.com/Items/Chiller/BattleRoyale
    (/Fortnite.com/Items/Chiller:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Chiller/BattleRoyale/CH1S6
      (/Fortnite.com/Items/Chiller/BattleRoyale:)CH1S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Chiller_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ChillerGrenade
  ChillerGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/ChillerGrenade/BattleRoyale
    (/Fortnite.com/Items/ChillerGrenade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ChillerGrenade/BattleRoyale/CH1S7
      (/Fortnite.com/Items/ChillerGrenade/BattleRoyale:)CH1S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ChillerGrenade_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ChugCannon
  ChugCannon<public> := module {
    # Module import path: /Fortnite.com/Items/ChugCannon/BattleRoyale
    (/Fortnite.com/Items/ChugCannon:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ChugCannon/BattleRoyale/CH2S5
      (/Fortnite.com/Items/ChugCannon/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ChugCannon_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ChugJug
  ChugJug<public> := module {
    # Module import path: /Fortnite.com/Items/ChugJug/BattleRoyale
    (/Fortnite.com/Items/ChugJug:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ChugJug/BattleRoyale/CH1S2
      (/Fortnite.com/Items/ChugJug/BattleRoyale:)CH1S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/ChugJug/BattleRoyale/CH1S2:)ChugJug_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/ChugJug/BattleRoyale/CH2S3
      (/Fortnite.com/Items/ChugJug/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        OceansBottomlessChugJug_Mythic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/ChugJug/BattleRoyale/CH6S2
      (/Fortnite.com/Items/ChugJug/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/ChugJug/BattleRoyale/CH6S2:)ChugJug_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ChugSplash
  ChugSplash<public> := module {
    # Module import path: /Fortnite.com/Items/ChugSplash/BattleRoyale
    (/Fortnite.com/Items/ChugSplash:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ChugSplash/BattleRoyale/CH1S9
      (/Fortnite.com/Items/ChugSplash/BattleRoyale:)CH1S9<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ChugSplash_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Clinger
  Clinger<public> := module {
    # Module import path: /Fortnite.com/Items/Clinger/BattleRoyale
    (/Fortnite.com/Items/Clinger:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Clinger/BattleRoyale/CH1S3
      (/Fortnite.com/Items/Clinger/BattleRoyale:)CH1S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Clinger_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CloakGauntlets
  CloakGauntlets<public> := module {
    # Module import path: /Fortnite.com/Items/CloakGauntlets/BattleRoyale
    (/Fortnite.com/Items/CloakGauntlets:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CloakGauntlets/BattleRoyale/CH4S3
      (/Fortnite.com/Items/CloakGauntlets/BattleRoyale:)CH4S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CloakGauntlets_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        WildguardReliksCloakGauntlets_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ClusterClinger
  ClusterClinger<public> := module {
    # Module import path: /Fortnite.com/Items/ClusterClinger/BattleRoyale
    (/Fortnite.com/Items/ClusterClinger:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ClusterClinger/BattleRoyale/CH5S1
      (/Fortnite.com/Items/ClusterClinger/BattleRoyale:)CH5S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ClusterClinger_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CobraDMR
  CobraDMR<public> := module {
    # Module import path: /Fortnite.com/Items/CobraDMR/BattleRoyale
    (/Fortnite.com/Items/CobraDMR:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CobraDMR/BattleRoyale/CH3S4
      (/Fortnite.com/Items/CobraDMR/BattleRoyale:)CH3S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CobraDMR_Common<public> := class<final><concrete>(entity) {}

        @experimental
        CobraDMR_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        CobraDMR_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        CobraDMR_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        CobraDMR_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        CobraDMR_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Coconut
  Coconut<public> := module {
    # Module import path: /Fortnite.com/Items/Coconut/BattleRoyale
    (/Fortnite.com/Items/Coconut:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Coconut/BattleRoyale/CH1S8
      (/Fortnite.com/Items/Coconut/BattleRoyale:)CH1S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Coconut_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CollateralDamageAssaultRifle
  CollateralDamageAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/CollateralDamageAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/CollateralDamageAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CollateralDamageAssaultRifle/BattleRoyale/CH6S2
      (/Fortnite.com/Items/CollateralDamageAssaultRifle/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CollateralDamageAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        CollateralDamageAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        CollateralDamageAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        CollateralDamageAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        CollateralDamageAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        EnhancedCollateralDamageAR_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        LawlessTrinityAssaultRifle_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CombatAssaultRifle
  CombatAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/CombatAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/CombatAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH2S8
      (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH2S8:)CombatAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH2S8:)CombatAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH2S8:)CombatAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH2S8:)CombatAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH2S8:)CombatAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH5S3
      (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale:)CH5S3<public> := module {
        # Module import path: /Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH5S3/Modular
        (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH5S3:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH5S3/Modular:)CombatAssaultRifle_Common<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH5S3/Modular:)CombatAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH5S3/Modular:)CombatAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH5S3/Modular:)CombatAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH5S3/Modular:)CombatAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}

          @experimental
          TheMachinistsCombatAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}
        }
      }

      # Module import path: /Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH7S2
      (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale:)CH7S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH7S2:)CombatAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH7S2:)CombatAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH7S2:)CombatAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH7S2:)CombatAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/CombatAssaultRifle/BattleRoyale/CH7S2:)CombatAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CombatPistol
  CombatPistol<public> := module {
    # Module import path: /Fortnite.com/Items/CombatPistol/BattleRoyale
    (/Fortnite.com/Items/CombatPistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CombatPistol/BattleRoyale/CH2S8
      (/Fortnite.com/Items/CombatPistol/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CombatPistol_Common<public> := class<final><concrete>(entity) {}

        @experimental
        CombatPistol_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        CombatPistol_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        CombatPistol_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        CombatPistol_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CombatSMG
  CombatSMG<public> := module {
    # Module import path: /Fortnite.com/Items/CombatSMG/BattleRoyale
    (/Fortnite.com/Items/CombatSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CombatSMG/BattleRoyale/CH3S2
      (/Fortnite.com/Items/CombatSMG/BattleRoyale:)CH3S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CombatSMG_Common<public> := class<final><concrete>(entity) {}

        @experimental
        CombatSMG_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        CombatSMG_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        CombatSMG_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        CombatSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        CombatSMG_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CombatShotgun
  CombatShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/CombatShotgun/BattleRoyale
    (/Fortnite.com/Items/CombatShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CombatShotgun/BattleRoyale/CH1S9
      (/Fortnite.com/Items/CombatShotgun/BattleRoyale:)CH1S9<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/CombatShotgun/BattleRoyale/CH1S9:)CombatShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/CombatShotgun/BattleRoyale/CH1S9:)CombatShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/CombatShotgun/BattleRoyale/CH1S9:)CombatShotgun_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/CombatShotgun/BattleRoyale/CH2S8
      (/Fortnite.com/Items/CombatShotgun/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/CombatShotgun/BattleRoyale/CH2S8:)CombatShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/CombatShotgun/BattleRoyale/CH4S2
      (/Fortnite.com/Items/CombatShotgun/BattleRoyale:)CH4S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/CombatShotgun/BattleRoyale/CH4S2:)CombatShotgun_Common<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/CombatShotgun/BattleRoyale/CH5S3
      (/Fortnite.com/Items/CombatShotgun/BattleRoyale:)CH5S3<public> := module {
        # Module import path: /Fortnite.com/Items/CombatShotgun/BattleRoyale/CH5S3/Modular
        (/Fortnite.com/Items/CombatShotgun/BattleRoyale/CH5S3:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          (/Fortnite.com/Items/CombatShotgun/BattleRoyale/CH5S3/Modular:)CombatShotgun_Common<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/CombatShotgun/BattleRoyale/CH5S3/Modular:)CombatShotgun_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/CombatShotgun/BattleRoyale/CH5S3/Modular:)CombatShotgun_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/CombatShotgun/BattleRoyale/CH5S3/Modular:)CombatShotgun_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/CombatShotgun/BattleRoyale/CH5S3/Modular:)CombatShotgun_Uncommon<public> := class<final><concrete>(entity) {}

          @experimental
          MegaloDonsCombatShotgun_Mythic<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CommandCavernKeycard
  CommandCavernKeycard<public> := module {
    # Module import path: /Fortnite.com/Items/CommandCavernKeycard/BattleRoyale
    (/Fortnite.com/Items/CommandCavernKeycard:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CommandCavernKeycard/BattleRoyale/CH3S2
      (/Fortnite.com/Items/CommandCavernKeycard/BattleRoyale:)CH3S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CommandCavernKeycard_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CompactSMG
  CompactSMG<public> := module {
    # Module import path: /Fortnite.com/Items/CompactSMG/BattleRoyale
    (/Fortnite.com/Items/CompactSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CompactSMG/BattleRoyale/CH1S5
      (/Fortnite.com/Items/CompactSMG/BattleRoyale:)CH1S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CompactSMG_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        CompactSMG_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/CompactSMG/BattleRoyale/CH6MS2
      (/Fortnite.com/Items/CompactSMG/BattleRoyale:)CH6MS2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CompactSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        CompactSMG_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        EnhancedCompactSMG_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Corn
  Corn<public> := module {
    # Module import path: /Fortnite.com/Items/Corn/BattleRoyale
    (/Fortnite.com/Items/Corn:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Corn/BattleRoyale/CH2S3
      (/Fortnite.com/Items/Corn/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Corn_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CozyCampfire
  CozyCampfire<public> := module {
    # Module import path: /Fortnite.com/Items/CozyCampfire/BattleRoyale
    (/Fortnite.com/Items/CozyCampfire:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CozyCampfire/BattleRoyale/CH1S2
      (/Fortnite.com/Items/CozyCampfire/BattleRoyale:)CH1S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CozyCampfire_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CrashPad
  CrashPad<public> := module {
    # Module import path: /Fortnite.com/Items/CrashPad/BattleRoyale
    (/Fortnite.com/Items/CrashPad:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CrashPad/BattleRoyale/CH2S2
      (/Fortnite.com/Items/CrashPad/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CrashPad_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CrashPadJr
  CrashPadJr<public> := module {
    # Module import path: /Fortnite.com/Items/CrashPadJr/BattleRoyale
    (/Fortnite.com/Items/CrashPadJr:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CrashPadJr/BattleRoyale/CH4S4
      (/Fortnite.com/Items/CrashPadJr/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CrashPadJr_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CreepinCardboard
  CreepinCardboard<public> := module {
    # Module import path: /Fortnite.com/Items/CreepinCardboard/BattleRoyale
    (/Fortnite.com/Items/CreepinCardboard:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CreepinCardboard/BattleRoyale/CH2S2
      (/Fortnite.com/Items/CreepinCardboard/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CreepinCardboard_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Crossbow
  Crossbow<public> := module {
    # Module import path: /Fortnite.com/Items/Crossbow/BattleRoyale
    (/Fortnite.com/Items/Crossbow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Crossbow/BattleRoyale/CH1S3
      (/Fortnite.com/Items/Crossbow/BattleRoyale:)CH1S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Crossbow_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        Crossbow_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Crystal
  Crystal<public> := module {
    # Module import path: /Fortnite.com/Items/Crystal/Creative
    (/Fortnite.com/Items/Crystal:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      QuartzCrystal_Uncommon<public> := class<final><concrete>(entity) {}

      @experimental
      RainbowCrystal_Epic<public> := class<final><concrete>(entity) {}

      @experimental
      ShadowshardCrystal_Epic<public> := class<final><concrete>(entity) {}

      @experimental
      SunbeamCrystal_Epic<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/CuddleFish
  CuddleFish<public> := module {
    # Module import path: /Fortnite.com/Items/CuddleFish/BattleRoyale
    (/Fortnite.com/Items/CuddleFish:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CuddleFish/BattleRoyale/CH2S6
      (/Fortnite.com/Items/CuddleFish/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CuddleFish_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/CupidsCrossbow
  CupidsCrossbow<public> := module {
    # Module import path: /Fortnite.com/Items/CupidsCrossbow/BattleRoyale
    (/Fortnite.com/Items/CupidsCrossbow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/CupidsCrossbow/BattleRoyale/CH1S2
      (/Fortnite.com/Items/CupidsCrossbow/BattleRoyale:)CH1S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        CupidsCrossbow_Epic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/CupidsCrossbow/BattleRoyale/CH7S1
      (/Fortnite.com/Items/CupidsCrossbow/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EmpoweredCupidsCrossbow_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DMR
  DMR<public> := module {
    # Module import path: /Fortnite.com/Items/DMR/BattleRoyale
    (/Fortnite.com/Items/DMR:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DMR/BattleRoyale/CH3S3
      (/Fortnite.com/Items/DMR/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DMR_Common<public> := class<final><concrete>(entity) {}

        @experimental
        DMR_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        DMR_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        DMR_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        DMR_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        DMR_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DamageTrap
  DamageTrap<public> := module {
    # Module import path: /Fortnite.com/Items/DamageTrap/BattleRoyale
    (/Fortnite.com/Items/DamageTrap:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DamageTrap/BattleRoyale/CH1S2
      (/Fortnite.com/Items/DamageTrap/BattleRoyale:)CH1S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DamageTrap_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DeadeyeAssaultRifle
  DeadeyeAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/DeadeyeAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/DeadeyeAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DeadeyeAssaultRifle/BattleRoyale/CH7S1
      (/Fortnite.com/Items/DeadeyeAssaultRifle/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DeadeyeAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        DeadeyeAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        DeadeyeAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        DeadeyeAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        DeadeyeAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        HushsDeadeyeAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DeadeyeDMR
  DeadeyeDMR<public> := module {
    # Module import path: /Fortnite.com/Items/DeadeyeDMR/BattleRoyale
    (/Fortnite.com/Items/DeadeyeDMR:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DeadeyeDMR/BattleRoyale/CH6S3
      (/Fortnite.com/Items/DeadeyeDMR/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DeadeyeDMR_Common<public> := class<final><concrete>(entity) {}

        @experimental
        DeadeyeDMR_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        DeadeyeDMR_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        DeadeyeDMR_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        DeadeyeDMR_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        KorsDeadeyeDMR_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        UnstableThunderclapDMR_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Decoy
  Decoy<public> := module {
    # Module import path: /Fortnite.com/Items/Decoy/BattleRoyale
    (/Fortnite.com/Items/Decoy:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Decoy/BattleRoyale/CH2S2
      (/Fortnite.com/Items/Decoy/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Decoy_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DialADrop
  DialADrop<public> := module {
    # Module import path: /Fortnite.com/Items/DialADrop/BattleRoyale
    (/Fortnite.com/Items/DialADrop:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DialADrop/BattleRoyale/CH3S4
      (/Fortnite.com/Items/DialADrop/BattleRoyale:)CH3S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DialADrop_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Diamond
  Diamond<public> := module {
    # Module import path: /Fortnite.com/Items/Diamond/Creative
    (/Fortnite.com/Items/Diamond:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Diamond_Epic<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/DinoEgg
  DinoEgg<public> := module {
    # Module import path: /Fortnite.com/Items/DinoEgg/Creative
    (/Fortnite.com/Items/DinoEgg:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      BlueFleckedDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      BlueShimmeringDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      BlueSpeckledDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      BrownDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      BrownSpeckledDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      GrayEruptionDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      GreenDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      GreenFleckedDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      GreenMarbledDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      PinkMarbledDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      RedEruptionDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      RedFleckedDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      RedShimmeringDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      WhiteDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      WhiteMarbledDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      WhiteShimmeringDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      WhiteSpeckledDinoEgg_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      YellowEruptionDinoEgg_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/Double
  Double<public> := module {
    # Module import path: /Fortnite.com/Items/Double/BattleRoyale
    (/Fortnite.com/Items/Double:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Double/BattleRoyale/CH6S4
      (/Fortnite.com/Items/Double/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Double_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DoubleBarrelShotgun
  DoubleBarrelShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/DoubleBarrelShotgun/BattleRoyale
    (/Fortnite.com/Items/DoubleBarrelShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DoubleBarrelShotgun/BattleRoyale/CH1S5
      (/Fortnite.com/Items/DoubleBarrelShotgun/BattleRoyale:)CH1S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DoubleBarrelShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        DoubleBarrelShotgun_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DragonsBreathShotgun
  DragonsBreathShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/DragonsBreathShotgun/BattleRoyale
    (/Fortnite.com/Items/DragonsBreathShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DragonsBreathShotgun/BattleRoyale/CH2S5
      (/Fortnite.com/Items/DragonsBreathShotgun/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/DragonsBreathShotgun/BattleRoyale/CH2S5:)DragonsBreathShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/DragonsBreathShotgun/BattleRoyale/CH2S5:)DragonsBreathShotgun_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/DragonsBreathShotgun/BattleRoyale/CH6S2
      (/Fortnite.com/Items/DragonsBreathShotgun/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/DragonsBreathShotgun/BattleRoyale/CH6S2:)DragonsBreathShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/DragonsBreathShotgun/BattleRoyale/CH6S2:)DragonsBreathShotgun_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DragonsBreathSniper
  DragonsBreathSniper<public> := module {
    # Module import path: /Fortnite.com/Items/DragonsBreathSniper/BattleRoyale
    (/Fortnite.com/Items/DragonsBreathSniper:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DragonsBreathSniper/BattleRoyale/CH2S5
      (/Fortnite.com/Items/DragonsBreathSniper/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DragonsBreathSniper_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DrumGun
  DrumGun<public> := module {
    # Module import path: /Fortnite.com/Items/DrumGun/Ballistic
    (/Fortnite.com/Items/DrumGun:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      DrumGun_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/DrumGun/BattleRoyale
    (/Fortnite.com/Items/DrumGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DrumGun/BattleRoyale/CH1S4
      (/Fortnite.com/Items/DrumGun/BattleRoyale:)CH1S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/DrumGun/BattleRoyale/CH1S4:)DrumGun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        DrumGun_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/DrumGun/BattleRoyale/CH2S2
      (/Fortnite.com/Items/DrumGun/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/DrumGun/BattleRoyale/CH2S2:)MidasDrumGun_Mythic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/DrumGun/BattleRoyale/CH2S3
      (/Fortnite.com/Items/DrumGun/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        JulesDrumGun_Mythic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/DrumGun/BattleRoyale/CH2S4
      (/Fortnite.com/Items/DrumGun/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ShadowMidasDrumGun_Mythic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/DrumGun/BattleRoyale/CH5S2
      (/Fortnite.com/Items/DrumGun/BattleRoyale:)CH5S2<public> := module {
        # Module import path: /Fortnite.com/Items/DrumGun/BattleRoyale/CH5S2/Modular
        (/Fortnite.com/Items/DrumGun/BattleRoyale/CH5S2:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          (/Fortnite.com/Items/DrumGun/BattleRoyale/CH5S2/Modular:)DrumGun_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/DrumGun/BattleRoyale/CH5S2/Modular:)DrumGun_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/DrumGun/BattleRoyale/CH5S2/Modular:)DrumGun_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/DrumGun/BattleRoyale/CH5S2/Modular:)MidasDrumGun_Mythic<public> := class<final><concrete>(entity) {}
        }
      }

      # Module import path: /Fortnite.com/Items/DrumGun/BattleRoyale/CH6MS2
      (/Fortnite.com/Items/DrumGun/BattleRoyale:)CH6MS2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/DrumGun/BattleRoyale/CH6MS2:)DrumGun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/DrumGun/BattleRoyale/CH6MS2:)DrumGun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/DrumGun/BattleRoyale/CH6MS2:)DrumGun_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/DrumGun/BattleRoyale/CH6S2
      (/Fortnite.com/Items/DrumGun/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MidasGildedEyeDrumGun_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DrumShotgun
  DrumShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/DrumShotgun/BattleRoyale
    (/Fortnite.com/Items/DrumShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DrumShotgun/BattleRoyale/CH1S9
      (/Fortnite.com/Items/DrumShotgun/BattleRoyale:)CH1S9<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DrumShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        DrumShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        DrumShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/DrumShotgun/BattleRoyale/CH3S2
      (/Fortnite.com/Items/DrumShotgun/BattleRoyale:)CH3S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DrumShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        DrumShotgun_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/DrumShotgun/BattleRoyale/CH4S3
      (/Fortnite.com/Items/DrumShotgun/BattleRoyale:)CH4S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedDrumShotgun_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DualFiendHunters
  DualFiendHunters<public> := module {
    # Module import path: /Fortnite.com/Items/DualFiendHunters/BattleRoyale
    (/Fortnite.com/Items/DualFiendHunters:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DualFiendHunters/BattleRoyale/CH2S8
      (/Fortnite.com/Items/DualFiendHunters/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DualFiendHunters_Common<public> := class<final><concrete>(entity) {}

        @experimental
        DualFiendHunters_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        DualFiendHunters_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        DualFiendHunters_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        DualFiendHunters_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DualMicroSMGs
  DualMicroSMGs<public> := module {
    # Module import path: /Fortnite.com/Items/DualMicroSMGs/BattleRoyale
    (/Fortnite.com/Items/DualMicroSMGs:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DualMicroSMGs/BattleRoyale/CH5S4
      (/Fortnite.com/Items/DualMicroSMGs/BattleRoyale:)CH5S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/DualMicroSMGs/BattleRoyale/CH5S4:)DualMicroSMGs_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/DualMicroSMGs/BattleRoyale/CH5S4:)DualMicroSMGs_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/DualMicroSMGs/BattleRoyale/CH5S4:)DualMicroSMGs_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/DualMicroSMGs/BattleRoyale/CH5S4:)DualMicroSMGs_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/DualMicroSMGs/BattleRoyale/CH5S4:)DualMicroSMGs_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/DualMicroSMGs/BattleRoyale/CH7S1
      (/Fortnite.com/Items/DualMicroSMGs/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/DualMicroSMGs/BattleRoyale/CH7S1:)DualMicroSMGs_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/DualMicroSMGs/BattleRoyale/CH7S1:)DualMicroSMGs_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/DualMicroSMGs/BattleRoyale/CH7S1:)DualMicroSMGs_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/DualMicroSMGs/BattleRoyale/CH7S1:)DualMicroSMGs_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/DualMicroSMGs/BattleRoyale/CH7S1:)DualMicroSMGs_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DualPistols
  DualPistols<public> := module {
    # Module import path: /Fortnite.com/Items/DualPistols/BattleRoyale
    (/Fortnite.com/Items/DualPistols:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DualPistols/BattleRoyale/CH1S4
      (/Fortnite.com/Items/DualPistols/BattleRoyale:)CH1S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DualPistols_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        DualPistols_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/DualPistols/BattleRoyale/CH2S6
      (/Fortnite.com/Items/DualPistols/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DualPistols_Common<public> := class<final><concrete>(entity) {}

        @experimental
        DualPistols_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        DualPistols_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DualSuppressedPistols
  DualSuppressedPistols<public> := module {
    # Module import path: /Fortnite.com/Items/DualSuppressedPistols/BattleRoyale
    (/Fortnite.com/Items/DualSuppressedPistols:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/DualSuppressedPistols/BattleRoyale/CH3S1
      (/Fortnite.com/Items/DualSuppressedPistols/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DualSuppressedPistols_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        DualSuppressedPistols_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        DualSuppressedPistols_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        DualSuppressedPistols_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/DuctTape
  DuctTape<public> := module {
    # Module import path: /Fortnite.com/Items/DuctTape/Creative
    (/Fortnite.com/Items/DuctTape:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      DuctTape_Uncommon<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/Dynamite
  Dynamite<public> := module {
    # Module import path: /Fortnite.com/Items/Dynamite/BattleRoyale
    (/Fortnite.com/Items/Dynamite:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Dynamite/BattleRoyale/CH1S6
      (/Fortnite.com/Items/Dynamite/BattleRoyale:)CH1S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Dynamite_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/EggLauncher
  EggLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/EggLauncher/BattleRoyale
    (/Fortnite.com/Items/EggLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/EggLauncher/BattleRoyale/CH1S3
      (/Fortnite.com/Items/EggLauncher/BattleRoyale:)CH1S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EggLauncher_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        EggLauncher_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        EggLauncher_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/EggLauncher/BattleRoyale/CH2S6
      (/Fortnite.com/Items/EggLauncher/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EggLauncher_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/EnforcerAR
  EnforcerAR<public> := module {
    # Module import path: /Fortnite.com/Items/EnforcerAR/Ballistic
    (/Fortnite.com/Items/EnforcerAR:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      (/Fortnite.com/Items/EnforcerAR/Ballistic:)EnforcerAR_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/EnforcerAR/BattleRoyale
    (/Fortnite.com/Items/EnforcerAR:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/EnforcerAR/BattleRoyale/CH5S1
      (/Fortnite.com/Items/EnforcerAR/BattleRoyale:)CH5S1<public> := module {
        # Module import path: /Fortnite.com/Items/EnforcerAR/BattleRoyale/CH5S1/Modular
        (/Fortnite.com/Items/EnforcerAR/BattleRoyale/CH5S1:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          (/Fortnite.com/Items/EnforcerAR/BattleRoyale/CH5S1/Modular:)EnforcerAR_Common<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/EnforcerAR/BattleRoyale/CH5S1/Modular:)EnforcerAR_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/EnforcerAR/BattleRoyale/CH5S1/Modular:)EnforcerAR_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/EnforcerAR/BattleRoyale/CH5S1/Modular:)EnforcerAR_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/EnforcerAR/BattleRoyale/CH5S1/Modular:)EnforcerAR_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }

      # Module import path: /Fortnite.com/Items/EnforcerAR/BattleRoyale/CH7S1
      (/Fortnite.com/Items/EnforcerAR/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/EnforcerAR/BattleRoyale/CH7S1:)EnforcerAR_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/EnforcerAR/BattleRoyale/CH7S1:)EnforcerAR_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/EnforcerAR/BattleRoyale/CH7S1:)EnforcerAR_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/EnforcerAR/BattleRoyale/CH7S1:)EnforcerAR_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/EnforcerAR/BattleRoyale/CH7S1:)EnforcerAR_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/EstateVaultKeycard
  EstateVaultKeycard<public> := module {
    # Module import path: /Fortnite.com/Items/EstateVaultKeycard/BattleRoyale
    (/Fortnite.com/Items/EstateVaultKeycard:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/EstateVaultKeycard/BattleRoyale/CH4S4
      (/Fortnite.com/Items/EstateVaultKeycard/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EstateVaultKeycard_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/EvoChromeBurstRifle
  EvoChromeBurstRifle<public> := module {
    # Module import path: /Fortnite.com/Items/EvoChromeBurstRifle/BattleRoyale
    (/Fortnite.com/Items/EvoChromeBurstRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/EvoChromeBurstRifle/BattleRoyale/CH3S4
      (/Fortnite.com/Items/EvoChromeBurstRifle/BattleRoyale:)CH3S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EvoChromeBurstRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        EvoChromeBurstRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        EvoChromeBurstRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        EvoChromeBurstRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        EvoChromeBurstRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        EvoChromeBurstRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/EvoChromeShotgun
  EvoChromeShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/EvoChromeShotgun/BattleRoyale
    (/Fortnite.com/Items/EvoChromeShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/EvoChromeShotgun/BattleRoyale/CH3S4
      (/Fortnite.com/Items/EvoChromeShotgun/BattleRoyale:)CH3S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EvoChromeShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        EvoChromeShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        EvoChromeShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        EvoChromeShotgun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        EvoChromeShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        EvoChromeShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ExCaliberRifle
  ExCaliberRifle<public> := module {
    # Module import path: /Fortnite.com/Items/ExCaliberRifle/BattleRoyale
    (/Fortnite.com/Items/ExCaliberRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ExCaliberRifle/BattleRoyale/CH4S1
      (/Fortnite.com/Items/ExCaliberRifle/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ExCaliberRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        ExCaliberRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ExCaliberRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        ExCaliberRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        ExCaliberRifle_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        TheAgelessChampionsExCaliberRifle_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ExoticSlapBerryFizz
  ExoticSlapBerryFizz<public> := module {
    # Module import path: /Fortnite.com/Items/ExoticSlapBerryFizz/BattleRoyale
    (/Fortnite.com/Items/ExoticSlapBerryFizz:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ExoticSlapBerryFizz/BattleRoyale/CH6S4
      (/Fortnite.com/Items/ExoticSlapBerryFizz/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ExoticSlapBerryFizz_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ExplosiveGooGun
  ExplosiveGooGun<public> := module {
    # Module import path: /Fortnite.com/Items/ExplosiveGooGun/BattleRoyale
    (/Fortnite.com/Items/ExplosiveGooGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ExplosiveGooGun/BattleRoyale/CH3S4
      (/Fortnite.com/Items/ExplosiveGooGun/BattleRoyale:)CH3S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ExplosiveGooGun_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ExplosiveRepeaterRifle
  ExplosiveRepeaterRifle<public> := module {
    # Module import path: /Fortnite.com/Items/ExplosiveRepeaterRifle/BattleRoyale
    (/Fortnite.com/Items/ExplosiveRepeaterRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ExplosiveRepeaterRifle/BattleRoyale/CH4S3
      (/Fortnite.com/Items/ExplosiveRepeaterRifle/BattleRoyale:)CH4S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ExplosiveRepeaterRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        ExplosiveRepeaterRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ExplosiveRepeaterRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        ExplosiveRepeaterRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        ExplosiveRepeaterRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        ExplosiveRepeaterRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FalconEyeSniper
  FalconEyeSniper<public> := module {
    # Module import path: /Fortnite.com/Items/FalconEyeSniper/BattleRoyale
    (/Fortnite.com/Items/FalconEyeSniper:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FalconEyeSniper/BattleRoyale/CH6S2
      (/Fortnite.com/Items/FalconEyeSniper/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedFalconEyeSniper_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        FalconEyeSniper_Common<public> := class<final><concrete>(entity) {}

        @experimental
        FalconEyeSniper_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        FalconEyeSniper_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        FalconEyeSniper_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        FalconEyeSniper_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FalconScout
  FalconScout<public> := module {
    # Module import path: /Fortnite.com/Items/FalconScout/BattleRoyale
    (/Fortnite.com/Items/FalconScout:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FalconScout/BattleRoyale/CH4S1
      (/Fortnite.com/Items/FalconScout/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FalconScout_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FibrousHerbs
  FibrousHerbs<public> := module {
    # Module import path: /Fortnite.com/Items/FibrousHerbs/Creative
    (/Fortnite.com/Items/FibrousHerbs:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      FibrousHerbs_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/FiendHunterCrossbow
  FiendHunterCrossbow<public> := module {
    # Module import path: /Fortnite.com/Items/FiendHunterCrossbow/BattleRoyale
    (/Fortnite.com/Items/FiendHunterCrossbow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FiendHunterCrossbow/BattleRoyale/CH1S6
      (/Fortnite.com/Items/FiendHunterCrossbow/BattleRoyale:)CH1S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FiendHunterCrossbow_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FireGrenade
  FireGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/FireGrenade/Ballistic
    (/Fortnite.com/Items/FireGrenade:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      FireGrenade_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/FireOniMask
  FireOniMask<public> := module {
    # Module import path: /Fortnite.com/Items/FireOniMask/BattleRoyale
    (/Fortnite.com/Items/FireOniMask:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FireOniMask/BattleRoyale/CH6S1
      (/Fortnite.com/Items/FireOniMask/BattleRoyale:)CH6S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FireOniMask_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ShogunXsFireOniMask_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FireTrap
  FireTrap<public> := module {
    # Module import path: /Fortnite.com/Items/FireTrap/BattleRoyale
    (/Fortnite.com/Items/FireTrap:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FireTrap/BattleRoyale/CH2S4
      (/Fortnite.com/Items/FireTrap/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FireTrap_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FireflyJar
  FireflyJar<public> := module {
    # Module import path: /Fortnite.com/Items/FireflyJar/BattleRoyale
    (/Fortnite.com/Items/FireflyJar:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FireflyJar/BattleRoyale/CH2S3
      (/Fortnite.com/Items/FireflyJar/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FireflyJar_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FireworkFlareGun
  FireworkFlareGun<public> := module {
    # Module import path: /Fortnite.com/Items/FireworkFlareGun/BattleRoyale
    (/Fortnite.com/Items/FireworkFlareGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FireworkFlareGun/BattleRoyale/CH3S3
      (/Fortnite.com/Items/FireworkFlareGun/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FireworkFlareGun_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FishingRod
  FishingRod<public> := module {
    # Module import path: /Fortnite.com/Items/FishingRod/Creative
    (/Fortnite.com/Items/FishingRod:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      CreativeFishingRod_Common<public> := class<final><concrete>(entity) {}

      @experimental
      CreativeProFishingRod_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/Flag
  Flag<public> := module {
    # Module import path: /Fortnite.com/Items/Flag/Creative
    (/Fortnite.com/Items/Flag:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Flag_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/FlapjackRifle
  FlapjackRifle<public> := module {
    # Module import path: /Fortnite.com/Items/FlapjackRifle/BattleRoyale
    (/Fortnite.com/Items/FlapjackRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FlapjackRifle/BattleRoyale/CH4S3
      (/Fortnite.com/Items/FlapjackRifle/BattleRoyale:)CH4S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedFlapJackRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        FlapjackRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        FlapjackRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        FlapjackRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        FlapjackRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        FlapjackRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FlareGun
  FlareGun<public> := module {
    # Module import path: /Fortnite.com/Items/FlareGun/BattleRoyale
    (/Fortnite.com/Items/FlareGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FlareGun/BattleRoyale/CH2S3
      (/Fortnite.com/Items/FlareGun/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FlareGun_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Flashbang
  Flashbang<public> := module {
    # Module import path: /Fortnite.com/Items/Flashbang/Ballistic
    (/Fortnite.com/Items/Flashbang:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Flashbang_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/Flashlight
  Flashlight<public> := module {
    # Module import path: /Fortnite.com/Items/Flashlight/Creative
    (/Fortnite.com/Items/Flashlight:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Flashlight_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/FlashlightPistol
  FlashlightPistol<public> := module {
    # Module import path: /Fortnite.com/Items/FlashlightPistol/Creative
    (/Fortnite.com/Items/FlashlightPistol:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      FlashlightPistol_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/FlexSMG
  FlexSMG<public> := module {
    # Module import path: /Fortnite.com/Items/FlexSMG/BattleRoyale
    (/Fortnite.com/Items/FlexSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FlexSMG/BattleRoyale/CH7S1
      (/Fortnite.com/Items/FlexSMG/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BigfootsFlexSMG_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        FlexSMG_Common<public> := class<final><concrete>(entity) {}

        @experimental
        FlexSMG_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        FlexSMG_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        FlexSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        FlexSMG_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FlintKnockPistol
  FlintKnockPistol<public> := module {
    # Module import path: /Fortnite.com/Items/FlintKnockPistol/BattleRoyale
    (/Fortnite.com/Items/FlintKnockPistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FlintKnockPistol/BattleRoyale/CH1S8
      (/Fortnite.com/Items/FlintKnockPistol/BattleRoyale:)CH1S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FlintKnockPistol_Common<public> := class<final><concrete>(entity) {}

        @experimental
        FlintKnockPistol_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Flopper
  Flopper<public> := module {
    # Module import path: /Fortnite.com/Items/Flopper/BattleRoyale
    (/Fortnite.com/Items/Flopper:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Flopper/BattleRoyale/CH2S1
      (/Fortnite.com/Items/Flopper/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Flopper_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FlowBerry
  FlowBerry<public> := module {
    # Module import path: /Fortnite.com/Items/FlowBerry/BattleRoyale
    (/Fortnite.com/Items/FlowBerry:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FlowBerry/BattleRoyale/CH5S1
      (/Fortnite.com/Items/FlowBerry/BattleRoyale:)CH5S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FlowBerry_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FlowBerryFizz
  FlowBerryFizz<public> := module {
    # Module import path: /Fortnite.com/Items/FlowBerryFizz/BattleRoyale
    (/Fortnite.com/Items/FlowBerryFizz:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FlowBerryFizz/BattleRoyale/CH5S1
      (/Fortnite.com/Items/FlowBerryFizz/BattleRoyale:)CH5S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FlowBerryFizz_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FlowBerryMistGrenade
  FlowBerryMistGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/FlowBerryMistGrenade/BattleRoyale
    (/Fortnite.com/Items/FlowBerryMistGrenade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FlowBerryMistGrenade/BattleRoyale/CH7S1
      (/Fortnite.com/Items/FlowBerryMistGrenade/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FlowBerryMistGrenade_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FlowerPetals
  FlowerPetals<public> := module {
    # Module import path: /Fortnite.com/Items/FlowerPetals/Creative
    (/Fortnite.com/Items/FlowerPetals:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      FlowerPetals_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/ForcePower
  ForcePower<public> := module {
    # Module import path: /Fortnite.com/Items/ForcePower/StarWars
    (/Fortnite.com/Items/ForcePower:)StarWars<public> := module {
      @experimental
      # Force Awareness as an augment item. Only usable with a lightsaber equipped.
      ForcePowerAwareness_LightsaberAugment<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Awareness as a weapon item. Must be equipped to use.
      ForcePowerAwareness_Weapon<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Distraction as an augment item. Only usable with a lightsaber equipped.
      ForcePowerDistraction_LightsaberAugment<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Distraction as a weapon item. Must be equipped to use.
      ForcePowerDistraction_Weapon<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Heal as an augment item. Only usable with a lightsaber equipped.
      ForcePowerHeal_LightsaberAugment<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Heal as a weapon item. Must be equipped to use.
      ForcePowerHeal_Weapon<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Lightning as an augment item. Only usable with a lightsaber equipped.
      ForcePowerLightning_LightsaberAugment<native><public> := class<concrete><final>(entity) {}

      using { /Verse.org/SceneGraph }
      @experimental
      # Force Lightning as a weapon item. Must be equipped to use.
      ForcePowerLightning_Weapon<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Pull as an augment item. Only usable with a lightsaber equipped.
      ForcePowerPull_LightsaberAugment<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Pull as a weapon item. Must be equipped to use.
      ForcePowerPull_Weapon<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Push as an augment item. Only usable with a lightsaber equipped.
      ForcePowerPush_LightsaberAugment<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Push as a weapon item. Must be equipped to use.
      ForcePowerPush_Weapon<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Saber Throw as an augment item. Only usable with a lightsaber equipped.
      ForcePowerSaberThrow_LightsaberAugment<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Saber Throw as a weapon item. Must be equipped to use.
      ForcePowerSaberThrow_Weapon<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Shield as an augment item. Only usable with a lightsaber equipped.
      ForcePowerShield_LightsaberAugment<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Shield as a weapon item. Must be equipped to use.
      ForcePowerShield_Weapon<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Throw as an augment item. Only usable with a lightsaber equipped.
      ForcePowerThrow_LightsaberAugment<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Throw as a weapon item. Must be equipped to use.
      ForcePowerThrow_Weapon<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Training (Jump & Sprint) as an augment item.
      ForcePowerTraining_Augment<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Mind Trick as an augment item. Only usable with a lightsaber equipped.
      ForcePowerTrick_LightsaberAugment<native><public> := class<concrete><final>(entity) {}

      @experimental
      # Force Mind Trick as a weapon item. Must be equipped to use.
      ForcePowerTrick_Weapon<native><public> := class<concrete><final>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/FortillaKeycard
  FortillaKeycard<public> := module {
    # Module import path: /Fortnite.com/Items/FortillaKeycard/BattleRoyale
    (/Fortnite.com/Items/FortillaKeycard:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FortillaKeycard/BattleRoyale/CH2S3
      (/Fortnite.com/Items/FortillaKeycard/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FortillaKeycard_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FragGrenade
  FragGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/FragGrenade/Ballistic
    (/Fortnite.com/Items/FragGrenade:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      FragGrenade_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/FrenzyAutoShotgun
  FrenzyAutoShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/FrenzyAutoShotgun/Ballistic
    (/Fortnite.com/Items/FrenzyAutoShotgun:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      (/Fortnite.com/Items/FrenzyAutoShotgun/Ballistic:)FrenzyAutoShotgun_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/FrenzyAutoShotgun/BattleRoyale
    (/Fortnite.com/Items/FrenzyAutoShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FrenzyAutoShotgun/BattleRoyale/CH5S1
      (/Fortnite.com/Items/FrenzyAutoShotgun/BattleRoyale:)CH5S1<public> := module {
        # Module import path: /Fortnite.com/Items/FrenzyAutoShotgun/BattleRoyale/CH5S1/Modular
        (/Fortnite.com/Items/FrenzyAutoShotgun/BattleRoyale/CH5S1:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          (/Fortnite.com/Items/FrenzyAutoShotgun/BattleRoyale/CH5S1/Modular:)FrenzyAutoShotgun_Common<public> := class<final><concrete>(entity) {}

          @experimental
          FrenzyAutoShotgun_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          FrenzyAutoShotgun_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          FrenzyAutoShotgun_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          FrenzyAutoShotgun_Uncommon<public> := class<final><concrete>(entity) {}

          @experimental
          OscarsFrenzyAutoShotgun_Mythic<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FrozenIcecreamCone
  FrozenIcecreamCone<public> := module {
    # Module import path: /Fortnite.com/Items/FrozenIcecreamCone/BattleRoyale
    (/Fortnite.com/Items/FrozenIcecreamCone:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FrozenIcecreamCone/BattleRoyale/CH3S3
      (/Fortnite.com/Items/FrozenIcecreamCone/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FrozenIcecreamCone_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/FuryAssaultRifle
  FuryAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/FuryAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/FuryAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/FuryAssaultRifle/BattleRoyale/CH6S1
      (/Fortnite.com/Items/FuryAssaultRifle/BattleRoyale:)CH6S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedFuryAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        FuryAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        FuryAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        FuryAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        FuryAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        FuryAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/FuryAssaultRifle/BattleRoyale/CH6S4
      (/Fortnite.com/Items/FuryAssaultRifle/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EradicatorHopRockFuryAssaultRifle_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/GasCan
  GasCan<public> := module {
    # Module import path: /Fortnite.com/Items/GasCan/BattleRoyale
    (/Fortnite.com/Items/GasCan:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/GasCan/BattleRoyale/CH2S3
      (/Fortnite.com/Items/GasCan/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        GasCan_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/GatekeeperShotgun
  GatekeeperShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/GatekeeperShotgun/BattleRoyale
    (/Fortnite.com/Items/GatekeeperShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/GatekeeperShotgun/BattleRoyale/CH5S2
      (/Fortnite.com/Items/GatekeeperShotgun/BattleRoyale:)CH5S2<public> := module {
        # Module import path: /Fortnite.com/Items/GatekeeperShotgun/BattleRoyale/CH5S2/Modular
        (/Fortnite.com/Items/GatekeeperShotgun/BattleRoyale/CH5S2:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          CerberusGatekeeperShotgun_Mythic<public> := class<final><concrete>(entity) {}

          @experimental
          GatekeeperShotgun_Common<public> := class<final><concrete>(entity) {}

          @experimental
          GatekeeperShotgun_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          GatekeeperShotgun_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          GatekeeperShotgun_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          GatekeeperShotgun_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Gliders
  Gliders<public> := module {
    # Module import path: /Fortnite.com/Items/Gliders/BattleRoyale
    (/Fortnite.com/Items/Gliders:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Gliders/BattleRoyale/CH1S7
      (/Fortnite.com/Items/Gliders/BattleRoyale:)CH1S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Gliders_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Gold
  (/Fortnite.com/Items:)Gold<public> := module {
    # Module import path: /Fortnite.com/Items/Gold/BattleRoyale
    (/Fortnite.com/Items/Gold:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Gold/BattleRoyale/CH2S1
      (/Fortnite.com/Items/Gold/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Gold_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/GoldSplash
  GoldSplash<public> := module {
    # Module import path: /Fortnite.com/Items/GoldSplash/BattleRoyale
    (/Fortnite.com/Items/GoldSplash:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/GoldSplash/BattleRoyale/CH6S2
      (/Fortnite.com/Items/GoldSplash/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        GoldSplash_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/GrappleBlade
  GrappleBlade<public> := module {
    # Module import path: /Fortnite.com/Items/GrappleBlade/BattleRoyale
    (/Fortnite.com/Items/GrappleBlade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/GrappleBlade/BattleRoyale/CH5S1
      (/Fortnite.com/Items/GrappleBlade/BattleRoyale:)CH5S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        GrappleBlade_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/GrappleGlider
  GrappleGlider<public> := module {
    # Module import path: /Fortnite.com/Items/GrappleGlider/BattleRoyale
    (/Fortnite.com/Items/GrappleGlider:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/GrappleGlider/BattleRoyale/CH3S4
      (/Fortnite.com/Items/GrappleGlider/BattleRoyale:)CH3S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        GrappleGlider_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/GrappleGlove
  GrappleGlove<public> := module {
    # Module import path: /Fortnite.com/Items/GrappleGlove/BattleRoyale
    (/Fortnite.com/Items/GrappleGlove:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/GrappleGlove/BattleRoyale/CH3S3
      (/Fortnite.com/Items/GrappleGlove/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        GrappleGlove_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Grappler
  Grappler<public> := module {
    # Module import path: /Fortnite.com/Items/Grappler/BattleRoyale
    (/Fortnite.com/Items/Grappler:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Grappler/BattleRoyale/CH1S5
      (/Fortnite.com/Items/Grappler/BattleRoyale:)CH1S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Grappler_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/GrapplerBow
  GrapplerBow<public> := module {
    # Module import path: /Fortnite.com/Items/GrapplerBow/BattleRoyale
    (/Fortnite.com/Items/GrapplerBow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/GrapplerBow/BattleRoyale/CH2S6
      (/Fortnite.com/Items/GrapplerBow/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        GrapplerBow_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Grenade
  Grenade<public> := module {
    # Module import path: /Fortnite.com/Items/Grenade/BattleRoyale
    (/Fortnite.com/Items/Grenade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Grenade/BattleRoyale/CH4MS1
      (/Fortnite.com/Items/Grenade/BattleRoyale:)CH4MS1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/Grenade/BattleRoyale/CH4MS1:)Grenade_Common<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/Grenade/BattleRoyale/CH7S1
      (/Fortnite.com/Items/Grenade/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/Grenade/BattleRoyale/CH7S1:)Grenade_Common<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/Grenade/BattleRoyale/PreSeason
      (/Fortnite.com/Items/Grenade/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/Grenade/BattleRoyale/PreSeason:)Grenade_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/GrenadeLauncher
  GrenadeLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/GrenadeLauncher/BattleRoyale
    (/Fortnite.com/Items/GrenadeLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/GrenadeLauncher/BattleRoyale/PreSeason
      (/Fortnite.com/Items/GrenadeLauncher/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        GrenadeLauncher_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        GrenadeLauncher_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        GrenadeLauncher_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/GrottoKeycard
  GrottoKeycard<public> := module {
    # Module import path: /Fortnite.com/Items/GrottoKeycard/BattleRoyale
    (/Fortnite.com/Items/GrottoKeycard:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/GrottoKeycard/BattleRoyale/CH2S2
      (/Fortnite.com/Items/GrottoKeycard/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        GrottoKeycard_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Grub
  Grub<public> := module {
    # Module import path: /Fortnite.com/Items/Grub/Creative
    (/Fortnite.com/Items/Grub:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Grub_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/GuardianShield
  GuardianShield<public> := module {
    # Module import path: /Fortnite.com/Items/GuardianShield/BattleRoyale
    (/Fortnite.com/Items/GuardianShield:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/GuardianShield/BattleRoyale/CH4S1
      (/Fortnite.com/Items/GuardianShield/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        GuardianShield_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/GuidedMissile
  GuidedMissile<public> := module {
    # Module import path: /Fortnite.com/Items/GuidedMissile/BattleRoyale
    (/Fortnite.com/Items/GuidedMissile:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/GuidedMissile/BattleRoyale/CH4MS1
      (/Fortnite.com/Items/GuidedMissile/BattleRoyale:)CH4MS1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        GuidedMissile_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        GuidedMissile_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/GuzzleJuice
  GuzzleJuice<public> := module {
    # Module import path: /Fortnite.com/Items/GuzzleJuice/BattleRoyale
    (/Fortnite.com/Items/GuzzleJuice:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/GuzzleJuice/BattleRoyale/CH3S1
      (/Fortnite.com/Items/GuzzleJuice/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        GuzzleJuice_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/GuzzlingIcecreamCone
  GuzzlingIcecreamCone<public> := module {
    # Module import path: /Fortnite.com/Items/GuzzlingIcecreamCone/BattleRoyale
    (/Fortnite.com/Items/GuzzlingIcecreamCone:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/GuzzlingIcecreamCone/BattleRoyale/CH3S3
      (/Fortnite.com/Items/GuzzlingIcecreamCone/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        GuzzlingIcecreamCone_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HammerAssaultRifle
  HammerAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/HammerAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/HammerAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HammerAssaultRifle/BattleRoyale/CH3S3
      (/Fortnite.com/Items/HammerAssaultRifle/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HammerAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        HammerAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        HammerAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        HammerAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        HammerAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        HammerAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HammerPumpShotgun
  HammerPumpShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/HammerPumpShotgun/Ballistic
    (/Fortnite.com/Items/HammerPumpShotgun:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      (/Fortnite.com/Items/HammerPumpShotgun/Ballistic:)HammerPumpShotgun_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/HammerPumpShotgun/BattleRoyale
    (/Fortnite.com/Items/HammerPumpShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HammerPumpShotgun/BattleRoyale/CH5S1
      (/Fortnite.com/Items/HammerPumpShotgun/BattleRoyale:)CH5S1<public> := module {
        # Module import path: /Fortnite.com/Items/HammerPumpShotgun/BattleRoyale/CH5S1/Modular
        (/Fortnite.com/Items/HammerPumpShotgun/BattleRoyale/CH5S1:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          (/Fortnite.com/Items/HammerPumpShotgun/BattleRoyale/CH5S1/Modular:)HammerPumpShotgun_Common<public> := class<final><concrete>(entity) {}

          @experimental
          HammerPumpShotgun_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          HammerPumpShotgun_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          HammerPumpShotgun_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          HammerPumpShotgun_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HandCannon
  HandCannon<public> := module {
    # Module import path: /Fortnite.com/Items/HandCannon/Ballistic
    (/Fortnite.com/Items/HandCannon:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      HandCannon_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/HandCannon/BattleRoyale
    (/Fortnite.com/Items/HandCannon:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HandCannon/BattleRoyale/CH1S3
      (/Fortnite.com/Items/HandCannon/BattleRoyale:)CH1S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/HandCannon/BattleRoyale/CH1S3:)HandCannon_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/HandCannon/BattleRoyale/CH1S3:)HandCannon_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/HandCannon/BattleRoyale/CH2S2
      (/Fortnite.com/Items/HandCannon/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/HandCannon/BattleRoyale/CH2S2:)HandCannon_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/HandCannon/BattleRoyale/CH5S2
      (/Fortnite.com/Items/HandCannon/BattleRoyale:)CH5S2<public> := module {
        # Module import path: /Fortnite.com/Items/HandCannon/BattleRoyale/CH5S2/Modular
        (/Fortnite.com/Items/HandCannon/BattleRoyale/CH5S2:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          (/Fortnite.com/Items/HandCannon/BattleRoyale/CH5S2/Modular:)HandCannon_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/HandCannon/BattleRoyale/CH5S2/Modular:)HandCannon_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/HandCannon/BattleRoyale/CH5S2/Modular:)HandCannon_Rare<public> := class<final><concrete>(entity) {}
        }
      }

      # Module import path: /Fortnite.com/Items/HandCannon/BattleRoyale/CH5S3
      (/Fortnite.com/Items/HandCannon/BattleRoyale:)CH5S3<public> := module {
        # Module import path: /Fortnite.com/Items/HandCannon/BattleRoyale/CH5S3/Modular
        (/Fortnite.com/Items/HandCannon/BattleRoyale/CH5S3:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          ConductorHandCannon_Mythic<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HarbingerSMG
  HarbingerSMG<public> := module {
    # Module import path: /Fortnite.com/Items/HarbingerSMG/BattleRoyale
    (/Fortnite.com/Items/HarbingerSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HarbingerSMG/BattleRoyale/CH5S2
      (/Fortnite.com/Items/HarbingerSMG/BattleRoyale:)CH5S2<public> := module {
        # Module import path: /Fortnite.com/Items/HarbingerSMG/BattleRoyale/CH5S2/Modular
        (/Fortnite.com/Items/HarbingerSMG/BattleRoyale/CH5S2:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          HadesHarbingerSMG_Mythic<public> := class<final><concrete>(entity) {}

          @experimental
          HarbingerSMG_Common<public> := class<final><concrete>(entity) {}

          @experimental
          HarbingerSMG_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          HarbingerSMG_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          HarbingerSMG_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          HarbingerSMG_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HarpoonGun
  HarpoonGun<public> := module {
    # Module import path: /Fortnite.com/Items/HarpoonGun/BattleRoyale
    (/Fortnite.com/Items/HarpoonGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HarpoonGun/BattleRoyale/CH2S1
      (/Fortnite.com/Items/HarpoonGun/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HarpoonGun_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HavocPumpShotgun
  HavocPumpShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/HavocPumpShotgun/BattleRoyale
    (/Fortnite.com/Items/HavocPumpShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HavocPumpShotgun/BattleRoyale/CH4S2
      (/Fortnite.com/Items/HavocPumpShotgun/BattleRoyale:)CH4S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedHavocShotgun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        HavocPumpShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        HavocPumpShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        HavocPumpShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        HavocPumpShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        HavocPumpShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HavocSuppressedAssaultRifle
  HavocSuppressedAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/HavocSuppressedAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/HavocSuppressedAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HavocSuppressedAssaultRifle/BattleRoyale/CH4S2
      (/Fortnite.com/Items/HavocSuppressedAssaultRifle/BattleRoyale:)CH4S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HavocSuppressedAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        HavocSuppressedAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        HavocSuppressedAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        HavocSuppressedAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        HavocSuppressedAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        HavocSuppressedAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        HighcardsHavocSuppressedRifle_Mythic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/HavocSuppressedAssaultRifle/BattleRoyale/CH4S4
      (/Fortnite.com/Items/HavocSuppressedAssaultRifle/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HeartsHavocSuppressedRifle_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HealEgg
  HealEgg<public> := module {
    # Module import path: /Fortnite.com/Items/HealEgg/BattleRoyale
    (/Fortnite.com/Items/HealEgg:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HealEgg/BattleRoyale/CH4S2
      (/Fortnite.com/Items/HealEgg/BattleRoyale:)CH4S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HealEgg_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HeavyAssaultRifle
  HeavyAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/HeavyAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/HeavyAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HeavyAssaultRifle/BattleRoyale/CH1S6
      (/Fortnite.com/Items/HeavyAssaultRifle/BattleRoyale:)CH1S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HeavyAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        HeavyAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        HeavyAssaultRifle_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/HeavyAssaultRifle/BattleRoyale/CH1S8
      (/Fortnite.com/Items/HeavyAssaultRifle/BattleRoyale:)CH1S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HeavyAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        HeavyAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HeavyImpactSniperRifle
  HeavyImpactSniperRifle<public> := module {
    # Module import path: /Fortnite.com/Items/HeavyImpactSniperRifle/BattleRoyale
    (/Fortnite.com/Items/HeavyImpactSniperRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HeavyImpactSniperRifle/BattleRoyale/CH5S3
      (/Fortnite.com/Items/HeavyImpactSniperRifle/BattleRoyale:)CH5S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HeavyImpactSniperRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        HeavyImpactSniperRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        HeavyImpactSniperRifle_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/HeavyImpactSniperRifle/BattleRoyale/CH6S2
      (/Fortnite.com/Items/HeavyImpactSniperRifle/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LawlessHeavyImpactTrackingRifle_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HeavyShotgun
  HeavyShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/HeavyShotgun/BattleRoyale
    (/Fortnite.com/Items/HeavyShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HeavyShotgun/BattleRoyale/CH3S1
      (/Fortnite.com/Items/HeavyShotgun/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HeavyShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/HeavyShotgun/BattleRoyale/CH3S1:)HeavyShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/HeavyShotgun/BattleRoyale/CH3S1:)HeavyShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        HeavyShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        HeavyShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/HeavyShotgun/BattleRoyale/CH4S1
      (/Fortnite.com/Items/HeavyShotgun/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HeistedBreacherShotgun_Exotic<public> := class<final><concrete>(entity) {}
      }
    }

    # Module import path: /Fortnite.com/Items/HeavyShotgun/OG
    (/Fortnite.com/Items/HeavyShotgun:)OG<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      (/Fortnite.com/Items/HeavyShotgun/OG:)HeavyShotgun_Epic<public> := class<final><concrete>(entity) {}

      @experimental
      (/Fortnite.com/Items/HeavyShotgun/OG:)HeavyShotgun_Legendary<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/HeavySniperRifle
  HeavySniperRifle<public> := module {
    # Module import path: /Fortnite.com/Items/HeavySniperRifle/BattleRoyale
    (/Fortnite.com/Items/HeavySniperRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HeavySniperRifle/BattleRoyale/CH1S5
      (/Fortnite.com/Items/HeavySniperRifle/BattleRoyale:)CH1S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HeavySniperRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        HeavySniperRifle_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/HeavySniperRifle/BattleRoyale/CH3S3
      (/Fortnite.com/Items/HeavySniperRifle/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HeavySniperRifle_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Herb
  Herb<public> := module {
    # Module import path: /Fortnite.com/Items/Herb/Creative
    (/Fortnite.com/Items/Herb:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Herb_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/HolidayPresents
  HolidayPresents<public> := module {
    # Module import path: /Fortnite.com/Items/HolidayPresents/BattleRoyale
    (/Fortnite.com/Items/HolidayPresents:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HolidayPresents/BattleRoyale/CH2S5
      (/Fortnite.com/Items/HolidayPresents/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HolidayPresents_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HoloRushSMG
  HoloRushSMG<public> := module {
    # Module import path: /Fortnite.com/Items/HoloRushSMG/BattleRoyale
    (/Fortnite.com/Items/HoloRushSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HoloRushSMG/BattleRoyale/CH7S1
      (/Fortnite.com/Items/HoloRushSMG/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HoloRushSMG_Common<public> := class<final><concrete>(entity) {}

        @experimental
        HoloRushSMG_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        HoloRushSMG_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        HoloRushSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        HoloRushSMG_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        YuleTroopersHoloRushSMG_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HoloTwisterAssaultRifle
  HoloTwisterAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/HoloTwisterAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/HoloTwisterAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HoloTwisterAssaultRifle/BattleRoyale/CH6S1
      (/Fortnite.com/Items/HoloTwisterAssaultRifle/BattleRoyale:)CH6S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedHoloTwisterAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        HoloTwisterAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        HoloTwisterAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        HoloTwisterAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        HoloTwisterAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        HoloTwisterAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Honey
  Honey<public> := module {
    # Module import path: /Fortnite.com/Items/Honey/Creative
    (/Fortnite.com/Items/Honey:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Honey_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/HopDrop
  HopDrop<public> := module {
    # Module import path: /Fortnite.com/Items/HopDrop/BattleRoyale
    (/Fortnite.com/Items/HopDrop:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HopDrop/BattleRoyale/CH2S4
      (/Fortnite.com/Items/HopDrop/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HopDrop_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HopEgg
  HopEgg<public> := module {
    # Module import path: /Fortnite.com/Items/HopEgg/BattleRoyale
    (/Fortnite.com/Items/HopEgg:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HopEgg/BattleRoyale/CH4S2
      (/Fortnite.com/Items/HopEgg/BattleRoyale:)CH4S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HopEgg_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HopFlopper
  HopFlopper<public> := module {
    # Module import path: /Fortnite.com/Items/HopFlopper/BattleRoyale
    (/Fortnite.com/Items/HopFlopper:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HopFlopper/BattleRoyale/CH2S4
      (/Fortnite.com/Items/HopFlopper/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HopFlopper_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HopRockDualies
  HopRockDualies<public> := module {
    # Module import path: /Fortnite.com/Items/HopRockDualies/BattleRoyale
    (/Fortnite.com/Items/HopRockDualies:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HopRockDualies/BattleRoyale/CH2S5
      (/Fortnite.com/Items/HopRockDualies/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HopRockDualies_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HunterBoltActionSniper
  HunterBoltActionSniper<public> := module {
    # Module import path: /Fortnite.com/Items/HunterBoltActionSniper/BattleRoyale
    (/Fortnite.com/Items/HunterBoltActionSniper:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HunterBoltActionSniper/BattleRoyale/CH3S1
      (/Fortnite.com/Items/HunterBoltActionSniper/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HunterBoltActionSniper_Common<public> := class<final><concrete>(entity) {}

        @experimental
        HunterBoltActionSniper_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        HunterBoltActionSniper_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        HunterBoltActionSniper_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        HunterBoltActionSniper_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HuntingRifle
  HuntingRifle<public> := module {
    # Module import path: /Fortnite.com/Items/HuntingRifle/BattleRoyale
    (/Fortnite.com/Items/HuntingRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HuntingRifle/BattleRoyale/CH1S3
      (/Fortnite.com/Items/HuntingRifle/BattleRoyale:)CH1S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/HuntingRifle/BattleRoyale/CH1S3:)HuntingRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/HuntingRifle/BattleRoyale/CH1S3:)HuntingRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/HuntingRifle/BattleRoyale/CH2S3
      (/Fortnite.com/Items/HuntingRifle/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HuntingRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        HuntingRifle_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/HuntingRifle/BattleRoyale/CH6S1
      (/Fortnite.com/Items/HuntingRifle/BattleRoyale:)CH6S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HuntingRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/HuntingRifle/BattleRoyale/CH6S1:)HuntingRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/HuntingRifle/BattleRoyale/CH6S1:)HuntingRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/HuntingRifle/BattleRoyale/CH6S2
      (/Fortnite.com/Items/HuntingRifle/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LawlessStinkRifle_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HuntressDMR
  HuntressDMR<public> := module {
    # Module import path: /Fortnite.com/Items/HuntressDMR/BattleRoyale
    (/Fortnite.com/Items/HuntressDMR:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HuntressDMR/BattleRoyale/CH5S2
      (/Fortnite.com/Items/HuntressDMR/BattleRoyale:)CH5S2<public> := module {
        # Module import path: /Fortnite.com/Items/HuntressDMR/BattleRoyale/CH5S2/Modular
        (/Fortnite.com/Items/HuntressDMR/BattleRoyale/CH5S2:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          HuntressDMR_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          HuntressDMR_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          HuntressDMR_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          HuntressDMR_Uncommon<public> := class<final><concrete>(entity) {}

          @experimental
          ZeusHuntressDMR_Mythic<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HyperSMG
  HyperSMG<public> := module {
    # Module import path: /Fortnite.com/Items/HyperSMG/Ballistic
    (/Fortnite.com/Items/HyperSMG:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      (/Fortnite.com/Items/HyperSMG/Ballistic:)HyperSMG_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/HyperSMG/BattleRoyale
    (/Fortnite.com/Items/HyperSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HyperSMG/BattleRoyale/CH5S1
      (/Fortnite.com/Items/HyperSMG/BattleRoyale:)CH5S1<public> := module {
        # Module import path: /Fortnite.com/Items/HyperSMG/BattleRoyale/CH5S1/Modular
        (/Fortnite.com/Items/HyperSMG/BattleRoyale/CH5S1:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          (/Fortnite.com/Items/HyperSMG/BattleRoyale/CH5S1/Modular:)HyperSMG_Common<public> := class<final><concrete>(entity) {}

          @experimental
          HyperSMG_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          HyperSMG_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          HyperSMG_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          HyperSMG_Uncommon<public> := class<final><concrete>(entity) {}

          @experimental
          ValeriasHyperSMG_Mythic<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/HyperburstPistol
  HyperburstPistol<public> := module {
    # Module import path: /Fortnite.com/Items/HyperburstPistol/BattleRoyale
    (/Fortnite.com/Items/HyperburstPistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/HyperburstPistol/BattleRoyale/CH6S3
      (/Fortnite.com/Items/HyperburstPistol/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedHyperburstPistol_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        HyperburstPistol_Common<public> := class<final><concrete>(entity) {}

        @experimental
        HyperburstPistol_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        HyperburstPistol_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        HyperburstPistol_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        HyperburstPistol_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        UnstableVoltageBurstPistol_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/IceKingsGauntlets
  IceKingsGauntlets<public> := module {
    # Module import path: /Fortnite.com/Items/IceKingsGauntlets/BattleRoyale
    (/Fortnite.com/Items/IceKingsGauntlets:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/IceKingsGauntlets/BattleRoyale/CH7S2
      (/Fortnite.com/Items/IceKingsGauntlets/BattleRoyale:)CH7S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        IceKingsGauntlets_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/IcecreamCone
  IcecreamCone<public> := module {
    # Module import path: /Fortnite.com/Items/IcecreamCone/BattleRoyale
    (/Fortnite.com/Items/IcecreamCone:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/IcecreamCone/BattleRoyale/CH3S3
      (/Fortnite.com/Items/IcecreamCone/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        IcecreamCone_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/IcyGrappler
  IcyGrappler<public> := module {
    # Module import path: /Fortnite.com/Items/IcyGrappler/BattleRoyale
    (/Fortnite.com/Items/IcyGrappler:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/IcyGrappler/BattleRoyale/CH2S8
      (/Fortnite.com/Items/IcyGrappler/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        IcyGrappler_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ImpulseGrenade
  ImpulseGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/ImpulseGrenade/Ballistic
    (/Fortnite.com/Items/ImpulseGrenade:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      ImpulseGrenade_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/ImpulseGrenade/BattleRoyale
    (/Fortnite.com/Items/ImpulseGrenade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ImpulseGrenade/BattleRoyale/CH1S2
      (/Fortnite.com/Items/ImpulseGrenade/BattleRoyale:)CH1S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ImpulseGrenade_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/InfantryRifle
  InfantryRifle<public> := module {
    # Module import path: /Fortnite.com/Items/InfantryRifle/BattleRoyale
    (/Fortnite.com/Items/InfantryRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/InfantryRifle/BattleRoyale/CH1S7
      (/Fortnite.com/Items/InfantryRifle/BattleRoyale:)CH1S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        InfantryRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        InfantryRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        InfantryRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/InfantryRifle/BattleRoyale/CH1S8
      (/Fortnite.com/Items/InfantryRifle/BattleRoyale:)CH1S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/InfantryRifle/BattleRoyale/CH1S8:)InfantryRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/InfantryRifle/BattleRoyale/CH1S8:)InfantryRifle_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/InfantryRifle/BattleRoyale/CH6MS2
      (/Fortnite.com/Items/InfantryRifle/BattleRoyale:)CH6MS2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/InfantryRifle/BattleRoyale/CH6MS2:)InfantryRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/InfantryRifle/BattleRoyale/CH6MS2:)InfantryRifle_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/InfiltratorPumpShotgun
  InfiltratorPumpShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/InfiltratorPumpShotgun/BattleRoyale
    (/Fortnite.com/Items/InfiltratorPumpShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/InfiltratorPumpShotgun/BattleRoyale/CH4S4
      (/Fortnite.com/Items/InfiltratorPumpShotgun/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedInfiltratorPumpShotgun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        InfiltratorPumpShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        InfiltratorPumpShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        InfiltratorPumpShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        InfiltratorPumpShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        InfiltratorPumpShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/InfinityBlade
  InfinityBlade<public> := module {
    # Module import path: /Fortnite.com/Items/InfinityBlade/BattleRoyale
    (/Fortnite.com/Items/InfinityBlade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/InfinityBlade/BattleRoyale/CH1S7
      (/Fortnite.com/Items/InfinityBlade/BattleRoyale:)CH1S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        InfinityBlade_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/InflateABull
  InflateABull<public> := module {
    # Module import path: /Fortnite.com/Items/InflateABull/BattleRoyale
    (/Fortnite.com/Items/InflateABull:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/InflateABull/BattleRoyale/CH2S7
      (/Fortnite.com/Items/InflateABull/BattleRoyale:)CH2S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        InflateABull_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/InkyPistol
  InkyPistol<public> := module {
    # Module import path: /Fortnite.com/Items/InkyPistol/BattleRoyale
    (/Fortnite.com/Items/InkyPistol:)BattleRoyale<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      InkyPistol_Exotic<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/IronPumpShotgun
  IronPumpShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/IronPumpShotgun/BattleRoyale
    (/Fortnite.com/Items/IronPumpShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/IronPumpShotgun/BattleRoyale/CH7S1
      (/Fortnite.com/Items/IronPumpShotgun/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        IronPumpShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        IronPumpShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        IronPumpShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        IronPumpShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        IronPumpShotgun_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        PinpointIronPumpShotgun_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/JellyBean
  JellyBean<public> := module {
    # Module import path: /Fortnite.com/Items/JellyBean/BattleRoyale
    (/Fortnite.com/Items/JellyBean:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/JellyBean/BattleRoyale/CH2S4
      (/Fortnite.com/Items/JellyBean/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        JellyBean_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Jellyfish
  Jellyfish<public> := module {
    # Module import path: /Fortnite.com/Items/Jellyfish/BattleRoyale
    (/Fortnite.com/Items/Jellyfish:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Jellyfish/BattleRoyale/CH2S4
      (/Fortnite.com/Items/Jellyfish/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Jellyfish_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Jetpack
  Jetpack<public> := module {
    # Module import path: /Fortnite.com/Items/Jetpack/BattleRoyale
    (/Fortnite.com/Items/Jetpack:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Jetpack/BattleRoyale/CH1S4
      (/Fortnite.com/Items/Jetpack/BattleRoyale:)CH1S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Jetpack_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Jewel
  Jewel<public> := module {
    # Module import path: /Fortnite.com/Items/Jewel/Creative
    (/Fortnite.com/Items/Jewel:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Jewel_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/JulesGliderGun
  JulesGliderGun<public> := module {
    # Module import path: /Fortnite.com/Items/JulesGliderGun/BattleRoyale
    (/Fortnite.com/Items/JulesGliderGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/JulesGliderGun/BattleRoyale/CH2S3
      (/Fortnite.com/Items/JulesGliderGun/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        JulesGliderGun_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/JunkRift
  JunkRift<public> := module {
    # Module import path: /Fortnite.com/Items/JunkRift/BattleRoyale
    (/Fortnite.com/Items/JunkRift:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/JunkRift/BattleRoyale/CH1SX
      (/Fortnite.com/Items/JunkRift/BattleRoyale:)CH1SX<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        JunkRift_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Key
  Key<public> := module {
    # Module import path: /Fortnite.com/Items/Key/BattleRoyale
    (/Fortnite.com/Items/Key:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Key/BattleRoyale/CH3S4
      (/Fortnite.com/Items/Key/BattleRoyale:)CH3S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Key_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/KillswitchRevolvers
  KillswitchRevolvers<public> := module {
    # Module import path: /Fortnite.com/Items/KillswitchRevolvers/BattleRoyale
    (/Fortnite.com/Items/KillswitchRevolvers:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/KillswitchRevolvers/BattleRoyale/CH6S3
      (/Fortnite.com/Items/KillswitchRevolvers/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        KillswitchRevolvers_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        KillswitchRevolvers_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        KillswitchRevolvers_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/KillswitchsRevolvers
  KillswitchsRevolvers<public> := module {
    # Module import path: /Fortnite.com/Items/KillswitchsRevolvers/BattleRoyale
    (/Fortnite.com/Items/KillswitchsRevolvers:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/KillswitchsRevolvers/BattleRoyale/CH6S3
      (/Fortnite.com/Items/KillswitchsRevolvers/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        KillswitchsRevolvers_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/KineticBlade
  KineticBlade<public> := module {
    # Module import path: /Fortnite.com/Items/KineticBlade/BattleRoyale
    (/Fortnite.com/Items/KineticBlade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/KineticBlade/BattleRoyale/CH4S2
      (/Fortnite.com/Items/KineticBlade/BattleRoyale:)CH4S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        KineticBlade_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        KineticBlade_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/KineticBlade/BattleRoyale/CH4S4
      (/Fortnite.com/Items/KineticBlade/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ThornesVampiricBlade_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/KineticBoomerang
  KineticBoomerang<public> := module {
    # Module import path: /Fortnite.com/Items/KineticBoomerang/BattleRoyale
    (/Fortnite.com/Items/KineticBoomerang:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/KineticBoomerang/BattleRoyale/CH4S3
      (/Fortnite.com/Items/KineticBoomerang/BattleRoyale:)CH4S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        KineticBoomerang_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/KymeraRayGun
  KymeraRayGun<public> := module {
    # Module import path: /Fortnite.com/Items/KymeraRayGun/BattleRoyale
    (/Fortnite.com/Items/KymeraRayGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/KymeraRayGun/BattleRoyale/CH2S7
      (/Fortnite.com/Items/KymeraRayGun/BattleRoyale:)CH2S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        KymeraRayGun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        KymeraRayGun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        KymeraRayGun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        ZygAndChoppysRayGun_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/LaunchPad
  LaunchPad<public> := module {
    # Module import path: /Fortnite.com/Items/LaunchPad/BattleRoyale
    (/Fortnite.com/Items/LaunchPad:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LaunchPad/BattleRoyale/CH3S4
      (/Fortnite.com/Items/LaunchPad/BattleRoyale:)CH3S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LaunchPad_Rare<public> := class<final><concrete>(entity) {}
      }
    }

    # Module import path: /Fortnite.com/Items/LaunchPad/Creative
    (/Fortnite.com/Items/LaunchPad:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      SuperLaunchPad_Epic<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/LawlessAccelerantHoloTwisterAR
  LawlessAccelerantHoloTwisterAR<public> := module {
    # Module import path: /Fortnite.com/Items/LawlessAccelerantHoloTwisterAR/BattleRoyale
    (/Fortnite.com/Items/LawlessAccelerantHoloTwisterAR:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LawlessAccelerantHoloTwisterAR/BattleRoyale/CH6S2
      (/Fortnite.com/Items/LawlessAccelerantHoloTwisterAR/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LawlessAccelerantHoloTwisterAR_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/LawlessFinalMarkRifle
  LawlessFinalMarkRifle<public> := module {
    # Module import path: /Fortnite.com/Items/LawlessFinalMarkRifle/BattleRoyale
    (/Fortnite.com/Items/LawlessFinalMarkRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LawlessFinalMarkRifle/BattleRoyale/CH6S2
      (/Fortnite.com/Items/LawlessFinalMarkRifle/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LawlessFinalMarkRifle_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/LawlessRiftLauncher
  LawlessRiftLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/LawlessRiftLauncher/BattleRoyale
    (/Fortnite.com/Items/LawlessRiftLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LawlessRiftLauncher/BattleRoyale/CH6S2
      (/Fortnite.com/Items/LawlessRiftLauncher/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LawlessRiftLauncher_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/LawlessShockwaveRocketLauncher
  LawlessShockwaveRocketLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/LawlessShockwaveRocketLauncher/BattleRoyale
    (/Fortnite.com/Items/LawlessShockwaveRocketLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LawlessShockwaveRocketLauncher/BattleRoyale/CH6S2
      (/Fortnite.com/Items/LawlessShockwaveRocketLauncher/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LawlessShockwaveRocketLauncher_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/LawlessSlapCannon
  LawlessSlapCannon<public> := module {
    # Module import path: /Fortnite.com/Items/LawlessSlapCannon/BattleRoyale
    (/Fortnite.com/Items/LawlessSlapCannon:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LawlessSlapCannon/BattleRoyale/CH6S2
      (/Fortnite.com/Items/LawlessSlapCannon/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LawlessSlapCannon_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/LawlessSlapJug
  LawlessSlapJug<public> := module {
    # Module import path: /Fortnite.com/Items/LawlessSlapJug/BattleRoyale
    (/Fortnite.com/Items/LawlessSlapJug:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LawlessSlapJug/BattleRoyale/CH6S2
      (/Fortnite.com/Items/LawlessSlapJug/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LawlessSlapJug_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Leadspitter3000
  Leadspitter3000<public> := module {
    # Module import path: /Fortnite.com/Items/Leadspitter3000/BattleRoyale
    (/Fortnite.com/Items/Leadspitter3000:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Leadspitter3000/BattleRoyale/CH6S4
      (/Fortnite.com/Items/Leadspitter3000/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Leadspitter3000_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        Leadspitter3000_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        Leadspitter3000_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/LemonLime
  LemonLime<public> := module {
    # Module import path: /Fortnite.com/Items/LemonLime/Creative
    (/Fortnite.com/Items/LemonLime:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      LemonLime_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/LeverActionRifle
  LeverActionRifle<public> := module {
    # Module import path: /Fortnite.com/Items/LeverActionRifle/BattleRoyale
    (/Fortnite.com/Items/LeverActionRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LeverActionRifle/BattleRoyale/CH2S5
      (/Fortnite.com/Items/LeverActionRifle/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LeverActionRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        LeverActionRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        LeverActionRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        LeverActionRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/LeverActionShotgun
  LeverActionShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/LeverActionShotgun/BattleRoyale
    (/Fortnite.com/Items/LeverActionShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LeverActionShotgun/BattleRoyale/CH2S5
      (/Fortnite.com/Items/LeverActionShotgun/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LeverActionShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        LeverActionShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        LeverActionShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        LeverActionShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        LeverActionShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/LightMachineGun
  LightMachineGun<public> := module {
    # Module import path: /Fortnite.com/Items/LightMachineGun/BattleRoyale
    (/Fortnite.com/Items/LightMachineGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LightMachineGun/BattleRoyale/CH1S3
      (/Fortnite.com/Items/LightMachineGun/BattleRoyale:)CH1S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LightMachineGun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        LightMachineGun_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/LightMachineGun/BattleRoyale/CH3S2
      (/Fortnite.com/Items/LightMachineGun/BattleRoyale:)CH3S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LightMachineGun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        LightMachineGun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        LightMachineGun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Lightsaber
  Lightsaber<public> := module {
    # Module import path: /Fortnite.com/Items/Lightsaber/StarWars
    (/Fortnite.com/Items/Lightsaber:)StarWars<public> := module {
      @experimental
      LightsaberJediPadawanA<native><public> := class<concrete><final>(entity) {}

      @experimental
      LightsaberJediPadawanB<native><public> := class<concrete><final>(entity) {}

      @experimental
      LightsaberJediTraining<native><public> := class<concrete><final>(entity) {}

      using { /Verse.org/SceneGraph }
      @experimental
      LightsaberKenobi<native><public> := class<final><concrete>(entity) {}

      @experimental
      LightsaberRen<native><public> := class<concrete><final>(entity) {}

      @experimental
      LightsaberRey<native><public> := class<concrete><final>(entity) {}

      @experimental
      LightsaberSithApprentice<native><public> := class<concrete><final>(entity) {}

      @experimental
      LightsaberSkywalker<native><public> := class<concrete><final>(entity) {}

      @experimental
      LightsaberVader<native><public> := class<concrete><final>(entity) {}

      @experimental
      LightsaberWindu<native><public> := class<concrete><final>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/LilWhipsSpecialServe
  LilWhipsSpecialServe<public> := module {
    # Module import path: /Fortnite.com/Items/LilWhipsSpecialServe/BattleRoyale
    (/Fortnite.com/Items/LilWhipsSpecialServe:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LilWhipsSpecialServe/BattleRoyale/CH3S3
      (/Fortnite.com/Items/LilWhipsSpecialServe/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LilWhipsSpecialServe_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/LockOnAssaultRifle
  LockOnAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/LockOnAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/LockOnAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LockOnAssaultRifle/BattleRoyale/CH7S1
      (/Fortnite.com/Items/LockOnAssaultRifle/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LockOnAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        LockOnAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        LockOnAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        LockOnAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        LockOnAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/LockOnPistol
  LockOnPistol<public> := module {
    # Module import path: /Fortnite.com/Items/LockOnPistol/BattleRoyale
    (/Fortnite.com/Items/LockOnPistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LockOnPistol/BattleRoyale/CH4S2
      (/Fortnite.com/Items/LockOnPistol/BattleRoyale:)CH4S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LockOnPistol_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/LumpOfCoal
  LumpOfCoal<public> := module {
    # Module import path: /Fortnite.com/Items/LumpOfCoal/BattleRoyale
    (/Fortnite.com/Items/LumpOfCoal:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/LumpOfCoal/BattleRoyale/CH2S1
      (/Fortnite.com/Items/LumpOfCoal/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LumpOfCoal_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MKAlphaAssaultRifle
  MKAlphaAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/MKAlphaAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/MKAlphaAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MKAlphaAssaultRifle/BattleRoyale/CH4S2
      (/Fortnite.com/Items/MKAlphaAssaultRifle/BattleRoyale:)CH4S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MKAlphaAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        MKAlphaAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        MKAlphaAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        MKAlphaAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        MKAlphaAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        ReliksMKAlphaAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MKSevenAssaultRifle
  MKSevenAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/MKSevenAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/MKSevenAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MKSevenAssaultRifle/BattleRoyale/CH3S1
      (/Fortnite.com/Items/MKSevenAssaultRifle/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MKSevenAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        MKSevenAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        MKSevenAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        MKSevenAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        MKSevenAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        TheFoundationsMKSevenAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MachinePistol
  MachinePistol<public> := module {
    # Module import path: /Fortnite.com/Items/MachinePistol/Ballistic
    (/Fortnite.com/Items/MachinePistol:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      MachinePistol_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/MachineSMG
  MachineSMG<public> := module {
    # Module import path: /Fortnite.com/Items/MachineSMG/BattleRoyale
    (/Fortnite.com/Items/MachineSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MachineSMG/BattleRoyale/CH3S1
      (/Fortnite.com/Items/MachineSMG/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MachineSMG_Common<public> := class<final><concrete>(entity) {}

        @experimental
        MachineSMG_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        MachineSMG_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        MachineSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        MachineSMG_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MakeshiftBow
  MakeshiftBow<public> := module {
    # Module import path: /Fortnite.com/Items/MakeshiftBow/BattleRoyale
    (/Fortnite.com/Items/MakeshiftBow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MakeshiftBow/BattleRoyale/CH2S6
      (/Fortnite.com/Items/MakeshiftBow/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MakeshiftBow_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MakeshiftRevolver
  MakeshiftRevolver<public> := module {
    # Module import path: /Fortnite.com/Items/MakeshiftRevolver/BattleRoyale
    (/Fortnite.com/Items/MakeshiftRevolver:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MakeshiftRevolver/BattleRoyale/CH2S6
      (/Fortnite.com/Items/MakeshiftRevolver/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MakeshiftRevolver_Common<public> := class<final><concrete>(entity) {}

        @experimental
        MakeshiftRevolver_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        MakeshiftRevolver_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MakeshiftRifle
  MakeshiftRifle<public> := module {
    # Module import path: /Fortnite.com/Items/MakeshiftRifle/BattleRoyale
    (/Fortnite.com/Items/MakeshiftRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MakeshiftRifle/BattleRoyale/CH2S6
      (/Fortnite.com/Items/MakeshiftRifle/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MakeshiftRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        MakeshiftRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        MakeshiftRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MakeshiftShotgun
  MakeshiftShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/MakeshiftShotgun/BattleRoyale
    (/Fortnite.com/Items/MakeshiftShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MakeshiftShotgun/BattleRoyale/CH2S6
      (/Fortnite.com/Items/MakeshiftShotgun/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MakeshiftShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        MakeshiftShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        MakeshiftShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MakeshiftSubmachineGun
  MakeshiftSubmachineGun<public> := module {
    # Module import path: /Fortnite.com/Items/MakeshiftSubmachineGun/BattleRoyale
    (/Fortnite.com/Items/MakeshiftSubmachineGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MakeshiftSubmachineGun/BattleRoyale/CH2S6
      (/Fortnite.com/Items/MakeshiftSubmachineGun/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MakeshiftSubmachineGun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        MakeshiftSubmachineGun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        MakeshiftSubmachineGun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MammothPistol
  MammothPistol<public> := module {
    # Module import path: /Fortnite.com/Items/MammothPistol/BattleRoyale
    (/Fortnite.com/Items/MammothPistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MammothPistol/BattleRoyale/CH4S3
      (/Fortnite.com/Items/MammothPistol/BattleRoyale:)CH4S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MammothPistol_Common<public> := class<final><concrete>(entity) {}

        @experimental
        MammothPistol_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        MammothPistol_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        MammothPistol_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        MammothPistol_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/MammothPistol/BattleRoyale/CH6S2
      (/Fortnite.com/Items/MammothPistol/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BaronsDoubleDownPistol_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        LawlessExplosiveMammothPistol_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MapleSyrup
  MapleSyrup<public> := module {
    # Module import path: /Fortnite.com/Items/MapleSyrup/Creative
    (/Fortnite.com/Items/MapleSyrup:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      MapleSyrup_Uncommon<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/MarksmanSixShooter
  MarksmanSixShooter<public> := module {
    # Module import path: /Fortnite.com/Items/MarksmanSixShooter/BattleRoyale
    (/Fortnite.com/Items/MarksmanSixShooter:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MarksmanSixShooter/BattleRoyale/CH2S6
      (/Fortnite.com/Items/MarksmanSixShooter/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MarksmanSixShooter_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MavenAutoShotgun
  MavenAutoShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/MavenAutoShotgun/BattleRoyale
    (/Fortnite.com/Items/MavenAutoShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MavenAutoShotgun/BattleRoyale/CH4S1
      (/Fortnite.com/Items/MavenAutoShotgun/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HeistedAccelerantShotgun_Exotic<public> := class<final><concrete>(entity) {}

        @experimental
        MavenAutoShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        MavenAutoShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        MavenAutoShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        MavenAutoShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        MavenAutoShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Meat
  Meat<public> := module {
    # Module import path: /Fortnite.com/Items/Meat/BattleRoyale
    (/Fortnite.com/Items/Meat:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Meat/BattleRoyale/CH2S6
      (/Fortnite.com/Items/Meat/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Meat_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MechanicalBow
  MechanicalBow<public> := module {
    # Module import path: /Fortnite.com/Items/MechanicalBow/BattleRoyale
    (/Fortnite.com/Items/MechanicalBow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MechanicalBow/BattleRoyale/CH2S6
      (/Fortnite.com/Items/MechanicalBow/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MechanicalBow_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MechanicalExplosiveBow
  MechanicalExplosiveBow<public> := module {
    # Module import path: /Fortnite.com/Items/MechanicalExplosiveBow/BattleRoyale
    (/Fortnite.com/Items/MechanicalExplosiveBow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MechanicalExplosiveBow/BattleRoyale/CH2S6
      (/Fortnite.com/Items/MechanicalExplosiveBow/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MechanicalExplosiveBow_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        MechanicalExplosiveBow_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        MechanicalExplosiveBow_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        RazsExplosiveBow_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MechanicalParts
  MechanicalParts<public> := module {
    # Module import path: /Fortnite.com/Items/MechanicalParts/BattleRoyale
    (/Fortnite.com/Items/MechanicalParts:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MechanicalParts/BattleRoyale/CH2S6
      (/Fortnite.com/Items/MechanicalParts/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MechanicalParts_Common<public> := class<final><concrete>(entity) {}
      }
    }

    # Module import path: /Fortnite.com/Items/MechanicalParts/Creative
    (/Fortnite.com/Items/MechanicalParts:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      EfficientMechanicalParts_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      RustyMechanicalParts_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      SimpleMechanicalParts_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      SleekMechanicalParts_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      SturdyMechanicalParts_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      VindertechMechanicalParts_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/MechanicalShockwaveBow
  MechanicalShockwaveBow<public> := module {
    # Module import path: /Fortnite.com/Items/MechanicalShockwaveBow/BattleRoyale
    (/Fortnite.com/Items/MechanicalShockwaveBow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MechanicalShockwaveBow/BattleRoyale/CH2S6
      (/Fortnite.com/Items/MechanicalShockwaveBow/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MechanicalShockwaveBow_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        MechanicalShockwaveBow_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        MechanicalShockwaveBow_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MedKit
  MedKit<public> := module {
    # Module import path: /Fortnite.com/Items/MedKit/BattleRoyale
    (/Fortnite.com/Items/MedKit:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MedKit/BattleRoyale/CH5S1
      (/Fortnite.com/Items/MedKit/BattleRoyale:)CH5S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/MedKit/BattleRoyale/CH5S1:)MedKit_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/MedKit/BattleRoyale/PreSeason
      (/Fortnite.com/Items/MedKit/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/MedKit/BattleRoyale/PreSeason:)MedKit_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MedMist
  MedMist<public> := module {
    # Module import path: /Fortnite.com/Items/MedMist/BattleRoyale
    (/Fortnite.com/Items/MedMist:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MedMist/BattleRoyale/CH3S1
      (/Fortnite.com/Items/MedMist/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MedMist_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MedMistSmokeGrenade
  MedMistSmokeGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/MedMistSmokeGrenade/BattleRoyale
    (/Fortnite.com/Items/MedMistSmokeGrenade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MedMistSmokeGrenade/BattleRoyale/CH6S2
      (/Fortnite.com/Items/MedMistSmokeGrenade/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MedMistSmokeGrenade_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MeowsclesPeowPeowRifle
  MeowsclesPeowPeowRifle<public> := module {
    # Module import path: /Fortnite.com/Items/MeowsclesPeowPeowRifle/BattleRoyale
    (/Fortnite.com/Items/MeowsclesPeowPeowRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MeowsclesPeowPeowRifle/BattleRoyale/CH2S2
      (/Fortnite.com/Items/MeowsclesPeowPeowRifle/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MeowsclesPeowPeowRifle_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Metal
  Metal<public> := module {
    # Module import path: /Fortnite.com/Items/Metal/BattleRoyale
    (/Fortnite.com/Items/Metal:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Metal/BattleRoyale/PreSeason
      (/Fortnite.com/Items/Metal/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Metal_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MidasFlopper
  MidasFlopper<public> := module {
    # Module import path: /Fortnite.com/Items/MidasFlopper/BattleRoyale
    (/Fortnite.com/Items/MidasFlopper:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MidasFlopper/BattleRoyale/CH2S4
      (/Fortnite.com/Items/MidasFlopper/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MidasFlopper_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Milk
  Milk<public> := module {
    # Module import path: /Fortnite.com/Items/Milk/Creative
    (/Fortnite.com/Items/Milk:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Milk_Uncommon<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/MineralPowder
  MineralPowder<public> := module {
    # Module import path: /Fortnite.com/Items/MineralPowder/Creative
    (/Fortnite.com/Items/MineralPowder:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      CharBlackMineralPowder_Common<public> := class<final><concrete>(entity) {}

      @experimental
      FineGrainMineralPowder_Common<public> := class<final><concrete>(entity) {}

      @experimental
      OxidizedMineralPowder_Common<public> := class<final><concrete>(entity) {}

      @experimental
      RoughMineralPowder_Common<public> := class<final><concrete>(entity) {}

      @experimental
      SimpleMineralPowder_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/Minigun
  Minigun<public> := module {
    # Module import path: /Fortnite.com/Items/Minigun/BattleRoyale
    (/Fortnite.com/Items/Minigun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Minigun/BattleRoyale/CH1S2
      (/Fortnite.com/Items/Minigun/BattleRoyale:)CH1S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Minigun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        Minigun_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/Minigun/BattleRoyale/CH2S2
      (/Fortnite.com/Items/Minigun/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BrutusMinigun_Mythic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/Minigun/BattleRoyale/CH5S3
      (/Fortnite.com/Items/Minigun/BattleRoyale:)CH5S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Minigun_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MonarchPistol
  MonarchPistol<public> := module {
    # Module import path: /Fortnite.com/Items/MonarchPistol/BattleRoyale
    (/Fortnite.com/Items/MonarchPistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MonarchPistol/BattleRoyale/CH5S4
      (/Fortnite.com/Items/MonarchPistol/BattleRoyale:)CH5S4<public> := module {
        # Module import path: /Fortnite.com/Items/MonarchPistol/BattleRoyale/CH5S4/Modular
        (/Fortnite.com/Items/MonarchPistol/BattleRoyale/CH5S4:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          MonarchPistol_Common<public> := class<final><concrete>(entity) {}

          @experimental
          MonarchPistol_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          MonarchPistol_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          MonarchPistol_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          MonarchPistol_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MonsterParts
  MonsterParts<public> := module {
    # Module import path: /Fortnite.com/Items/MonsterParts/BattleRoyale
    (/Fortnite.com/Items/MonsterParts:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MonsterParts/BattleRoyale/CH2S8
      (/Fortnite.com/Items/MonsterParts/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MonsterParts_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Mushroom
  Mushroom<public> := module {
    # Module import path: /Fortnite.com/Items/Mushroom/Creative
    (/Fortnite.com/Items/Mushroom:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      BlueMushroom_Uncommon<public> := class<final><concrete>(entity) {}

      @experimental
      PinkMushroom_Uncommon<public> := class<final><concrete>(entity) {}

      @experimental
      RedMushroom_Uncommon<public> := class<final><concrete>(entity) {}

      @experimental
      WhiteMushroom_Uncommon<public> := class<final><concrete>(entity) {}

      @experimental
      YellowMushroom_Uncommon<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/MystForm
  MystForm<public> := module {
    # Module import path: /Fortnite.com/Items/MystForm/BattleRoyale
    (/Fortnite.com/Items/MystForm:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MystForm/BattleRoyale/CH6S3
      (/Fortnite.com/Items/MystForm/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MystForm_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MystGauntlets
  MystGauntlets<public> := module {
    # Module import path: /Fortnite.com/Items/MystGauntlets/BattleRoyale
    (/Fortnite.com/Items/MystGauntlets:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MystGauntlets/BattleRoyale/CH6S3
      (/Fortnite.com/Items/MystGauntlets/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MystGauntlets_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/MythicGoldfish
  MythicGoldfish<public> := module {
    # Module import path: /Fortnite.com/Items/MythicGoldfish/BattleRoyale
    (/Fortnite.com/Items/MythicGoldfish:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/MythicGoldfish/BattleRoyale/CH2S1
      (/Fortnite.com/Items/MythicGoldfish/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MythicGoldfish_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/NemesisAR
  NemesisAR<public> := module {
    # Module import path: /Fortnite.com/Items/NemesisAR/Ballistic
    (/Fortnite.com/Items/NemesisAR:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      (/Fortnite.com/Items/NemesisAR/Ballistic:)NemesisAR_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/NemesisAR/BattleRoyale
    (/Fortnite.com/Items/NemesisAR:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/NemesisAR/BattleRoyale/CH5S1
      (/Fortnite.com/Items/NemesisAR/BattleRoyale:)CH5S1<public> := module {
        # Module import path: /Fortnite.com/Items/NemesisAR/BattleRoyale/CH5S1/Modular
        (/Fortnite.com/Items/NemesisAR/BattleRoyale/CH5S1:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          MontaguesNemesisAR_Mythic<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/NemesisAR/BattleRoyale/CH5S1/Modular:)NemesisAR_Common<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/NemesisAR/BattleRoyale/CH5S1/Modular:)NemesisAR_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/NemesisAR/BattleRoyale/CH5S1/Modular:)NemesisAR_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/NemesisAR/BattleRoyale/CH5S1/Modular:)NemesisAR_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/NemesisAR/BattleRoyale/CH5S1/Modular:)NemesisAR_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }

      # Module import path: /Fortnite.com/Items/NemesisAR/BattleRoyale/CH7S2
      (/Fortnite.com/Items/NemesisAR/BattleRoyale:)CH7S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/NemesisAR/BattleRoyale/CH7S2:)NemesisAR_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/NemesisAR/BattleRoyale/CH7S2:)NemesisAR_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/NemesisAR/BattleRoyale/CH7S2:)NemesisAR_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/NemesisAR/BattleRoyale/CH7S2:)NemesisAR_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/NemesisAR/BattleRoyale/CH7S2:)NemesisAR_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/NightHawk
  NightHawk<public> := module {
    # Module import path: /Fortnite.com/Items/NightHawk/BattleRoyale
    (/Fortnite.com/Items/NightHawk:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/NightHawk/BattleRoyale/CH2S5
      (/Fortnite.com/Items/NightHawk/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        NightHawk_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/NitroFists
  NitroFists<public> := module {
    # Module import path: /Fortnite.com/Items/NitroFists/BattleRoyale
    (/Fortnite.com/Items/NitroFists:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/NitroFists/BattleRoyale/CH5S3
      (/Fortnite.com/Items/NitroFists/BattleRoyale:)CH5S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        MegaloDonsNitroFists_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        NitroFists_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/NitroSplash
  NitroSplash<public> := module {
    # Module import path: /Fortnite.com/Items/NitroSplash/BattleRoyale
    (/Fortnite.com/Items/NitroSplash:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/NitroSplash/BattleRoyale/CH5S3
      (/Fortnite.com/Items/NitroSplash/BattleRoyale:)CH5S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        NitroSplash_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/OXRRifle
  OXRRifle<public> := module {
    # Module import path: /Fortnite.com/Items/OXRRifle/BattleRoyale
    (/Fortnite.com/Items/OXRRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/OXRRifle/BattleRoyale/CH6S4
      (/Fortnite.com/Items/OXRRifle/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EradicatorOXRRifle_Exotic<public> := class<final><concrete>(entity) {}

        @experimental
        OXRRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        OXRRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        OXRRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        OXRRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        OXRRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        OXRRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/OniShotgun
  OniShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/OniShotgun/BattleRoyale
    (/Fortnite.com/Items/OniShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/OniShotgun/BattleRoyale/CH6S1
      (/Fortnite.com/Items/OniShotgun/BattleRoyale:)CH6S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedOniShotgun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        OniShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        OniShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        OniShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        OniShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        OniShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/OrangePaintGrenade
  OrangePaintGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/OrangePaintGrenade/BattleRoyale
    (/Fortnite.com/Items/OrangePaintGrenade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/OrangePaintGrenade/BattleRoyale/CH2S2
      (/Fortnite.com/Items/OrangePaintGrenade/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        OrangePaintGrenade_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/OrangePaintLauncher
  OrangePaintLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/OrangePaintLauncher/BattleRoyale
    (/Fortnite.com/Items/OrangePaintLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/OrangePaintLauncher/BattleRoyale/CH2S2
      (/Fortnite.com/Items/OrangePaintLauncher/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        OrangePaintLauncher_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Ore
  Ore<public> := module {
    # Module import path: /Fortnite.com/Items/Ore/Creative
    (/Fortnite.com/Items/Ore:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      BrightcoreOre_Epic<public> := class<final><concrete>(entity) {}

      @experimental
      Coal_Uncommon<public> := class<final><concrete>(entity) {}

      @experimental
      CopperOre_Epic<public> := class<final><concrete>(entity) {}

      @experimental
      MalachiteOre_Epic<public> := class<final><concrete>(entity) {}

      @experimental
      ObsidianOre_Epic<public> := class<final><concrete>(entity) {}

      @experimental
      RoughOre_Common<public> := class<final><concrete>(entity) {}

      @experimental
      SilverOre_Epic<public> := class<final><concrete>(entity) {}

      @experimental
      SpectroliteOre_Epic<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/OutlawShotgun
  OutlawShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/OutlawShotgun/BattleRoyale
    (/Fortnite.com/Items/OutlawShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/OutlawShotgun/BattleRoyale/CH6S2
      (/Fortnite.com/Items/OutlawShotgun/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedOutlawShotgun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        OutlawShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        OutlawShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        OutlawShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        OutlawShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        OutlawShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/OutlawShotgun/BattleRoyale/CH6S3
      (/Fortnite.com/Items/OutlawShotgun/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        UnstableYoinkShotgun_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Overdrive
  Overdrive<public> := module {
    # Module import path: /Fortnite.com/Items/Overdrive/Ballistic
    (/Fortnite.com/Items/Overdrive:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Overdrive_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/PatchworkTool
  PatchworkTool<public> := module {
    # Module import path: /Fortnite.com/Items/PatchworkTool/Creative
    (/Fortnite.com/Items/PatchworkTool:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      PatchworkTool_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/Pepper
  Pepper<public> := module {
    # Module import path: /Fortnite.com/Items/Pepper/BattleRoyale
    (/Fortnite.com/Items/Pepper:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Pepper/BattleRoyale/CH1S8
      (/Fortnite.com/Items/Pepper/BattleRoyale:)CH1S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Pepper_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PepperMint
  PepperMint<public> := module {
    # Module import path: /Fortnite.com/Items/PepperMint/BattleRoyale
    (/Fortnite.com/Items/PepperMint:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PepperMint/BattleRoyale/CH2S4
      (/Fortnite.com/Items/PepperMint/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PepperMint_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Pistol
  Pistol<public> := module {
    # Module import path: /Fortnite.com/Items/Pistol/BattleRoyale
    (/Fortnite.com/Items/Pistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Pistol/BattleRoyale/CH4MS1
      (/Fortnite.com/Items/Pistol/BattleRoyale:)CH4MS1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/Pistol/BattleRoyale/CH4MS1:)Pistol_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/Pistol/BattleRoyale/CH4MS1:)Pistol_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/Pistol/BattleRoyale/CH4MS1:)Pistol_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/Pistol/BattleRoyale/CH7S2
      (/Fortnite.com/Items/Pistol/BattleRoyale:)CH7S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/Pistol/BattleRoyale/CH7S2:)Pistol_Common<public> := class<final><concrete>(entity) {}

        @experimental
        Pistol_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        Pistol_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/Pistol/BattleRoyale/CH7S2:)Pistol_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/Pistol/BattleRoyale/CH7S2:)Pistol_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PizzaParty
  PizzaParty<public> := module {
    # Module import path: /Fortnite.com/Items/PizzaParty/BattleRoyale
    (/Fortnite.com/Items/PizzaParty:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PizzaParty/BattleRoyale/CH3S1
      (/Fortnite.com/Items/PizzaParty/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PizzaParty_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PizzaSlice
  PizzaSlice<public> := module {
    # Module import path: /Fortnite.com/Items/PizzaSlice/BattleRoyale
    (/Fortnite.com/Items/PizzaSlice:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PizzaSlice/BattleRoyale/CH3S1
      (/Fortnite.com/Items/PizzaSlice/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PizzaSlice_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Planks
  Planks<public> := module {
    # Module import path: /Fortnite.com/Items/Planks/Creative
    (/Fortnite.com/Items/Planks:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Planks_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/PlasmaBurstLaser
  PlasmaBurstLaser<public> := module {
    # Module import path: /Fortnite.com/Items/PlasmaBurstLaser/BattleRoyale
    (/Fortnite.com/Items/PlasmaBurstLaser:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PlasmaBurstLaser/BattleRoyale/CH6S2
      (/Fortnite.com/Items/PlasmaBurstLaser/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PlasmaBurstLaser_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PlasmaCannon
  PlasmaCannon<public> := module {
    # Module import path: /Fortnite.com/Items/PlasmaCannon/BattleRoyale
    (/Fortnite.com/Items/PlasmaCannon:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PlasmaCannon/BattleRoyale/CH2S7
      (/Fortnite.com/Items/PlasmaCannon/BattleRoyale:)CH2S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PlasmaCannon_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PoisonDartTrap
  PoisonDartTrap<public> := module {
    # Module import path: /Fortnite.com/Items/PoisonDartTrap/BattleRoyale
    (/Fortnite.com/Items/PoisonDartTrap:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PoisonDartTrap/BattleRoyale/CH1S8
      (/Fortnite.com/Items/PoisonDartTrap/BattleRoyale:)CH1S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PoisonDartTrap_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PortABunker
  PortABunker<public> := module {
    # Module import path: /Fortnite.com/Items/PortABunker/BattleRoyale
    (/Fortnite.com/Items/PortABunker:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PortABunker/BattleRoyale/CH3S4
      (/Fortnite.com/Items/PortABunker/BattleRoyale:)CH3S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PortABunker_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PortACover
  PortACover<public> := module {
    # Module import path: /Fortnite.com/Items/PortACover/BattleRoyale
    (/Fortnite.com/Items/PortACover:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PortACover/BattleRoyale/CH6S2
      (/Fortnite.com/Items/PortACover/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PortACover_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PortAFort
  PortAFort<public> := module {
    # Module import path: /Fortnite.com/Items/PortAFort/BattleRoyale
    (/Fortnite.com/Items/PortAFort:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PortAFort/BattleRoyale/CH1S3
      (/Fortnite.com/Items/PortAFort/BattleRoyale:)CH1S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PortAFort_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PortAFortress
  PortAFortress<public> := module {
    # Module import path: /Fortnite.com/Items/PortAFortress/BattleRoyale
    (/Fortnite.com/Items/PortAFortress:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PortAFortress/BattleRoyale/CH1S5
      (/Fortnite.com/Items/PortAFortress/BattleRoyale:)CH1S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PortAFortress_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PrecisionAirStrike
  PrecisionAirStrike<public> := module {
    # Module import path: /Fortnite.com/Items/PrecisionAirStrike/BattleRoyale
    (/Fortnite.com/Items/PrecisionAirStrike:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PrecisionAirStrike/BattleRoyale/CH6S4
      (/Fortnite.com/Items/PrecisionAirStrike/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PrecisionAirStrike_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Presents
  Presents<public> := module {
    # Module import path: /Fortnite.com/Items/Presents/BattleRoyale
    (/Fortnite.com/Items/Presents:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Presents/BattleRoyale/CH1S7
      (/Fortnite.com/Items/Presents/BattleRoyale:)CH1S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Presents_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PrimalBow
  PrimalBow<public> := module {
    # Module import path: /Fortnite.com/Items/PrimalBow/BattleRoyale
    (/Fortnite.com/Items/PrimalBow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PrimalBow/BattleRoyale/CH2S6
      (/Fortnite.com/Items/PrimalBow/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PrimalBow_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PrimalFlameBow
  PrimalFlameBow<public> := module {
    # Module import path: /Fortnite.com/Items/PrimalFlameBow/BattleRoyale
    (/Fortnite.com/Items/PrimalFlameBow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PrimalFlameBow/BattleRoyale/CH2S6
      (/Fortnite.com/Items/PrimalFlameBow/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PrimalFlameBow_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalFlameBow_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalFlameBow_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PrimalPistol
  PrimalPistol<public> := module {
    # Module import path: /Fortnite.com/Items/PrimalPistol/BattleRoyale
    (/Fortnite.com/Items/PrimalPistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PrimalPistol/BattleRoyale/CH2S6
      (/Fortnite.com/Items/PrimalPistol/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PrimalPistol_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalPistol_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalPistol_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalPistol_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PrimalRifle
  PrimalRifle<public> := module {
    # Module import path: /Fortnite.com/Items/PrimalRifle/BattleRoyale
    (/Fortnite.com/Items/PrimalRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PrimalRifle/BattleRoyale/CH2S6
      (/Fortnite.com/Items/PrimalRifle/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PrimalRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalRifle_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        SpireGuardiansPrimalAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PrimalSMG
  PrimalSMG<public> := module {
    # Module import path: /Fortnite.com/Items/PrimalSMG/BattleRoyale
    (/Fortnite.com/Items/PrimalSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PrimalSMG/BattleRoyale/CH2S6
      (/Fortnite.com/Items/PrimalSMG/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PrimalSMG_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalSMG_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalSMG_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PrimalShotgun
  PrimalShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/PrimalShotgun/BattleRoyale
    (/Fortnite.com/Items/PrimalShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PrimalShotgun/BattleRoyale/CH2S6
      (/Fortnite.com/Items/PrimalShotgun/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PrimalShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalShotgun_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        SpireAssassinsPrimalShotgun_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PrimalStinkBow
  PrimalStinkBow<public> := module {
    # Module import path: /Fortnite.com/Items/PrimalStinkBow/BattleRoyale
    (/Fortnite.com/Items/PrimalStinkBow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PrimalStinkBow/BattleRoyale/CH2S6
      (/Fortnite.com/Items/PrimalStinkBow/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PrimalStinkBow_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalStinkBow_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        PrimalStinkBow_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PrimeShotgun
  PrimeShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/PrimeShotgun/BattleRoyale
    (/Fortnite.com/Items/PrimeShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PrimeShotgun/BattleRoyale/CH3S3
      (/Fortnite.com/Items/PrimeShotgun/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PrimeShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        PrimeShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        PrimeShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        PrimeShotgun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        PrimeShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        PrimeShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PropOMatic
  PropOMatic<public> := module {
    # Module import path: /Fortnite.com/Items/PropOMatic/Creative
    (/Fortnite.com/Items/PropOMatic:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      PropOMatic_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/ProximityGrenadeLauncher
  ProximityGrenadeLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/ProximityGrenadeLauncher/BattleRoyale
    (/Fortnite.com/Items/ProximityGrenadeLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ProximityGrenadeLauncher/BattleRoyale/CH1S9
      (/Fortnite.com/Items/ProximityGrenadeLauncher/BattleRoyale:)CH1S9<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ProximityGrenadeLauncher_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ProximityGrenadeLauncher_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ProximityMine
  ProximityMine<public> := module {
    # Module import path: /Fortnite.com/Items/ProximityMine/Ballistic
    (/Fortnite.com/Items/ProximityMine:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      ProximityMine_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/ProximityMine/BattleRoyale
    (/Fortnite.com/Items/ProximityMine:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ProximityMine/BattleRoyale/CH2S2
      (/Fortnite.com/Items/ProximityMine/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ProximityMine_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PulseRifle
  PulseRifle<public> := module {
    # Module import path: /Fortnite.com/Items/PulseRifle/BattleRoyale
    (/Fortnite.com/Items/PulseRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PulseRifle/BattleRoyale/CH2S7
      (/Fortnite.com/Items/PulseRifle/BattleRoyale:)CH2S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BurstPulseRifle_Exotic<public> := class<final><concrete>(entity) {}

        @experimental
        PulseRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        PulseRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        PulseRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SlonesPulseRifle_Mythic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/PulseRifle/BattleRoyale/CH4S2
      (/Fortnite.com/Items/PulseRifle/BattleRoyale:)CH4S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        OverclockedPulseRifle_Mythic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/PulseRifle/BattleRoyale/CH7S2
      (/Fortnite.com/Items/PulseRifle/BattleRoyale:)CH7S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PulseRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PulseScanner
  PulseScanner<public> := module {
    # Module import path: /Fortnite.com/Items/PulseScanner/BattleRoyale
    (/Fortnite.com/Items/PulseScanner:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PulseScanner/BattleRoyale/CH6S2
      (/Fortnite.com/Items/PulseScanner/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PulseScanner_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PumpDump
  PumpDump<public> := module {
    # Module import path: /Fortnite.com/Items/PumpDump/BattleRoyale
    (/Fortnite.com/Items/PumpDump:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PumpDump/BattleRoyale/CH6S2
      (/Fortnite.com/Items/PumpDump/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LawlessBlinkPumpDump_Exotic<public> := class<final><concrete>(entity) {}

        @experimental
        PumpDump_Common<public> := class<final><concrete>(entity) {}

        @experimental
        PumpDump_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        PumpDump_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        PumpDump_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        PumpDump_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        PumpDump_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PumpShotgun
  PumpShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/PumpShotgun/BattleRoyale
    (/Fortnite.com/Items/PumpShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PumpShotgun/BattleRoyale/CH1S6
      (/Fortnite.com/Items/PumpShotgun/BattleRoyale:)CH1S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/PumpShotgun/BattleRoyale/CH1S6:)PumpShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/PumpShotgun/BattleRoyale/CH1S6:)PumpShotgun_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/PumpShotgun/BattleRoyale/CH2S1
      (/Fortnite.com/Items/PumpShotgun/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/PumpShotgun/BattleRoyale/CH2S1:)PumpShotgun_Common<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/PumpShotgun/BattleRoyale/CH4MS1
      (/Fortnite.com/Items/PumpShotgun/BattleRoyale:)CH4MS1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/PumpShotgun/BattleRoyale/CH4MS1:)PumpShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/PumpShotgun/BattleRoyale/CH4MS1:)PumpShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/PumpShotgun/BattleRoyale/CH4MS1:)PumpShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/PumpShotgun/BattleRoyale/CH4MS1:)PumpShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/PumpShotgun/BattleRoyale/CH4MS1:)PumpShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/PumpShotgun/BattleRoyale/PreSeason
      (/Fortnite.com/Items/PumpShotgun/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/PumpShotgun/BattleRoyale/PreSeason:)PumpShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/PumpShotgun/BattleRoyale/PreSeason:)PumpShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Pumpkin
  Pumpkin<public> := module {
    # Module import path: /Fortnite.com/Items/Pumpkin/Creative
    (/Fortnite.com/Items/Pumpkin:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Pumpkin_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/PumpkinLauncher
  PumpkinLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/PumpkinLauncher/BattleRoyale
    (/Fortnite.com/Items/PumpkinLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PumpkinLauncher/BattleRoyale/CH1S1
      (/Fortnite.com/Items/PumpkinLauncher/BattleRoyale:)CH1S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/PumpkinLauncher/BattleRoyale/CH1S1:)PumpkinLauncher_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/PumpkinLauncher/BattleRoyale/CH1S1:)PumpkinLauncher_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/PumpkinLauncher/BattleRoyale/CH1S1:)PumpkinLauncher_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/PumpkinLauncher/BattleRoyale/CH2S1
      (/Fortnite.com/Items/PumpkinLauncher/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PumpkinLauncher_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/PumpkinLauncher/BattleRoyale/CH6S4
      (/Fortnite.com/Items/PumpkinLauncher/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/PumpkinLauncher/BattleRoyale/CH6S4:)PumpkinLauncher_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/PumpkinLauncher/BattleRoyale/CH6S4:)PumpkinLauncher_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/PumpkinLauncher/BattleRoyale/CH6S4:)PumpkinLauncher_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PurplePaintGrenade
  PurplePaintGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/PurplePaintGrenade/BattleRoyale
    (/Fortnite.com/Items/PurplePaintGrenade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PurplePaintGrenade/BattleRoyale/CH2S2
      (/Fortnite.com/Items/PurplePaintGrenade/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PurplePaintGrenade_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/PurplePaintLauncher
  PurplePaintLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/PurplePaintLauncher/BattleRoyale
    (/Fortnite.com/Items/PurplePaintLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/PurplePaintLauncher/BattleRoyale/CH2S2
      (/Fortnite.com/Items/PurplePaintLauncher/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        PurplePaintLauncher_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/QuadLauncher
  QuadLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/QuadLauncher/BattleRoyale
    (/Fortnite.com/Items/QuadLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/QuadLauncher/BattleRoyale/CH1S6
      (/Fortnite.com/Items/QuadLauncher/BattleRoyale:)CH1S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        QuadLauncher_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        QuadLauncher_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RailGun
  RailGun<public> := module {
    # Module import path: /Fortnite.com/Items/RailGun/BattleRoyale
    (/Fortnite.com/Items/RailGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RailGun/BattleRoyale/CH2S7
      (/Fortnite.com/Items/RailGun/BattleRoyale:)CH2S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RailGun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        RailGun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        RailGun_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RangerAssaultRifle
  RangerAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/RangerAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/RangerAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RangerAssaultRifle/BattleRoyale/CH3S1
      (/Fortnite.com/Items/RangerAssaultRifle/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RangerAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        RangerAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        RangerAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        RangerAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        RangerAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        RangerAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RangerPistol
  RangerPistol<public> := module {
    # Module import path: /Fortnite.com/Items/RangerPistol/Ballistic
    (/Fortnite.com/Items/RangerPistol:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      (/Fortnite.com/Items/RangerPistol/Ballistic:)RangerPistol_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/RangerPistol/BattleRoyale
    (/Fortnite.com/Items/RangerPistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RangerPistol/BattleRoyale/CH5S1
      (/Fortnite.com/Items/RangerPistol/BattleRoyale:)CH5S1<public> := module {
        # Module import path: /Fortnite.com/Items/RangerPistol/BattleRoyale/CH5S1/Modular
        (/Fortnite.com/Items/RangerPistol/BattleRoyale/CH5S1:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          (/Fortnite.com/Items/RangerPistol/BattleRoyale/CH5S1/Modular:)RangerPistol_Common<public> := class<final><concrete>(entity) {}

          @experimental
          RangerPistol_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          RangerPistol_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          RangerPistol_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          RangerPistol_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RangerShotgun
  RangerShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/RangerShotgun/BattleRoyale
    (/Fortnite.com/Items/RangerShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RangerShotgun/BattleRoyale/CH3S2
      (/Fortnite.com/Items/RangerShotgun/BattleRoyale:)CH3S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RangerShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        RangerShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        RangerShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        RangerShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        RangerShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RapidFireSMG
  RapidFireSMG<public> := module {
    # Module import path: /Fortnite.com/Items/RapidFireSMG/BattleRoyale
    (/Fortnite.com/Items/RapidFireSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RapidFireSMG/BattleRoyale/CH2S2
      (/Fortnite.com/Items/RapidFireSMG/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RapidFireSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        RapidFireSMG_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/RapidFireSMG/BattleRoyale/CH2S3
      (/Fortnite.com/Items/RapidFireSMG/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RapidFireSMG_Common<public> := class<final><concrete>(entity) {}

        @experimental
        RapidFireSMG_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        RapidFireSMG_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/RapidFireSMG/BattleRoyale/CH3S4
      (/Fortnite.com/Items/RapidFireSMG/BattleRoyale:)CH3S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RapidFireSMG_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RaptorEye
  RaptorEye<public> := module {
    # Module import path: /Fortnite.com/Items/RaptorEye/Creative
    (/Fortnite.com/Items/RaptorEye:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      RaptorEye_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/ReaperSniperRifle
  ReaperSniperRifle<public> := module {
    # Module import path: /Fortnite.com/Items/ReaperSniperRifle/Ballistic
    (/Fortnite.com/Items/ReaperSniperRifle:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      ReaperSniperRifle_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/ReaperSniperRifle/BattleRoyale
    (/Fortnite.com/Items/ReaperSniperRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ReaperSniperRifle/BattleRoyale/CH5S1
      (/Fortnite.com/Items/ReaperSniperRifle/BattleRoyale:)CH5S1<public> := module {
        # Module import path: /Fortnite.com/Items/ReaperSniperRifle/BattleRoyale/CH5S1/Modular
        (/Fortnite.com/Items/ReaperSniperRifle/BattleRoyale/CH5S1:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          ReaperSniperRifle_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          ReaperSniperRifle_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          ReaperSniperRifle_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          ReaperSniperRifle_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ReconGrenade
  ReconGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/ReconGrenade/Ballistic
    (/Fortnite.com/Items/ReconGrenade:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      ReconGrenade_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/ReconScanner
  ReconScanner<public> := module {
    # Module import path: /Fortnite.com/Items/ReconScanner/BattleRoyale
    (/Fortnite.com/Items/ReconScanner:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ReconScanner/BattleRoyale/CH2S7
      (/Fortnite.com/Items/ReconScanner/BattleRoyale:)CH2S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ReconScanner_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Recycler
  Recycler<public> := module {
    # Module import path: /Fortnite.com/Items/Recycler/BattleRoyale
    (/Fortnite.com/Items/Recycler:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Recycler/BattleRoyale/CH2S6
      (/Fortnite.com/Items/Recycler/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Recycler_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        Recycler_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        Recycler_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SpireAssassinsRecycler_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RedEyeAssaultRifle
  RedEyeAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/RedEyeAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/RedEyeAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RedEyeAssaultRifle/BattleRoyale/CH4S1
      (/Fortnite.com/Items/RedEyeAssaultRifle/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HeistedExplosiveAssaultRifle_Exotic<public> := class<final><concrete>(entity) {}

        @experimental
        RedEyeAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        RedEyeAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        RedEyeAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        RedEyeAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        RedEyeAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RemoteExplosives
  RemoteExplosives<public> := module {
    # Module import path: /Fortnite.com/Items/RemoteExplosives/BattleRoyale
    (/Fortnite.com/Items/RemoteExplosives:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RemoteExplosives/BattleRoyale/CH1S3
      (/Fortnite.com/Items/RemoteExplosives/BattleRoyale:)CH1S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RemoteExplosives_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RepairTorch
  RepairTorch<public> := module {
    # Module import path: /Fortnite.com/Items/RepairTorch/BattleRoyale
    (/Fortnite.com/Items/RepairTorch:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RepairTorch/BattleRoyale/CH3S2
      (/Fortnite.com/Items/RepairTorch/BattleRoyale:)CH3S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RepairTorch_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Revolver
  Revolver<public> := module {
    # Module import path: /Fortnite.com/Items/Revolver/BattleRoyale
    (/Fortnite.com/Items/Revolver:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Revolver/BattleRoyale/CH1S9
      (/Fortnite.com/Items/Revolver/BattleRoyale:)CH1S9<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/Revolver/BattleRoyale/CH1S9:)Revolver_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/Revolver/BattleRoyale/CH1S9:)Revolver_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/Revolver/BattleRoyale/CH4MS1
      (/Fortnite.com/Items/Revolver/BattleRoyale:)CH4MS1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/Revolver/BattleRoyale/CH4MS1:)Revolver_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/Revolver/BattleRoyale/CH4MS1:)Revolver_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/Revolver/BattleRoyale/CH4MS1:)Revolver_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/Revolver/BattleRoyale/CH4MS1:)Revolver_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/Revolver/BattleRoyale/CH4MS1:)Revolver_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/Revolver/BattleRoyale/PreSeason
      (/Fortnite.com/Items/Revolver/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/Revolver/BattleRoyale/PreSeason:)Revolver_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/Revolver/BattleRoyale/PreSeason:)Revolver_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/Revolver/BattleRoyale/PreSeason:)Revolver_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RiftFish
  RiftFish<public> := module {
    # Module import path: /Fortnite.com/Items/RiftFish/BattleRoyale
    (/Fortnite.com/Items/RiftFish:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RiftFish/BattleRoyale/CH2S5
      (/Fortnite.com/Items/RiftFish/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RiftFish_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RiftPointDevice
  RiftPointDevice<public> := module {
    # Module import path: /Fortnite.com/Items/RiftPointDevice/Ballistic
    (/Fortnite.com/Items/RiftPointDevice:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      RiftPointDevice_Exotic<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/RiftToGo
  RiftToGo<public> := module {
    # Module import path: /Fortnite.com/Items/RiftToGo/BattleRoyale
    (/Fortnite.com/Items/RiftToGo:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RiftToGo/BattleRoyale/CH1S5
      (/Fortnite.com/Items/RiftToGo/BattleRoyale:)CH1S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RiftToGo_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RigKeycard
  RigKeycard<public> := module {
    # Module import path: /Fortnite.com/Items/RigKeycard/BattleRoyale
    (/Fortnite.com/Items/RigKeycard:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RigKeycard/BattleRoyale/CH2S2
      (/Fortnite.com/Items/RigKeycard/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RigKeycard_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RipsawLauncher
  RipsawLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/RipsawLauncher/BattleRoyale
    (/Fortnite.com/Items/RipsawLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RipsawLauncher/BattleRoyale/CH3S3
      (/Fortnite.com/Items/RipsawLauncher/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RipsawLauncher_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RoastedChicken
  RoastedChicken<public> := module {
    # Module import path: /Fortnite.com/Items/RoastedChicken/Creative
    (/Fortnite.com/Items/RoastedChicken:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      RoastedChicken_Uncommon<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/RocketDrill
  RocketDrill<public> := module {
    # Module import path: /Fortnite.com/Items/RocketDrill/BattleRoyale
    (/Fortnite.com/Items/RocketDrill:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RocketDrill/BattleRoyale/CH6S2
      (/Fortnite.com/Items/RocketDrill/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RocketDrill_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RocketLauncher
  RocketLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/RocketLauncher/BattleRoyale
    (/Fortnite.com/Items/RocketLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RocketLauncher/BattleRoyale/CH2S1
      (/Fortnite.com/Items/RocketLauncher/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RocketLauncher_Common<public> := class<final><concrete>(entity) {}

        @experimental
        RocketLauncher_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/RocketLauncher/BattleRoyale/PreSeason
      (/Fortnite.com/Items/RocketLauncher/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RocketLauncher_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        RocketLauncher_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        RocketLauncher_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RocketRam
  RocketRam<public> := module {
    # Module import path: /Fortnite.com/Items/RocketRam/BattleRoyale
    (/Fortnite.com/Items/RocketRam:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RocketRam/BattleRoyale/CH4S4
      (/Fortnite.com/Items/RocketRam/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RocketRam_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/RotatingGizmo
  RotatingGizmo<public> := module {
    # Module import path: /Fortnite.com/Items/RotatingGizmo/Creative
    (/Fortnite.com/Items/RotatingGizmo:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      RotatingGizmo_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/RustyCan
  RustyCan<public> := module {
    # Module import path: /Fortnite.com/Items/RustyCan/BattleRoyale
    (/Fortnite.com/Items/RustyCan:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/RustyCan/BattleRoyale/CH2S1
      (/Fortnite.com/Items/RustyCan/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        RustyCan_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ScopedAssaultRifle
  ScopedAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/ScopedAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/ScopedAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ScopedAssaultRifle/BattleRoyale/CH2S4
      (/Fortnite.com/Items/ScopedAssaultRifle/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ScopedAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ScopedAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/ScopedAssaultRifle/BattleRoyale/PreSeason
      (/Fortnite.com/Items/ScopedAssaultRifle/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ScopedAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        ScopedAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ScopedBurstSMG
  ScopedBurstSMG<public> := module {
    # Module import path: /Fortnite.com/Items/ScopedBurstSMG/BattleRoyale
    (/Fortnite.com/Items/ScopedBurstSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ScopedBurstSMG/BattleRoyale/CH4S4
      (/Fortnite.com/Items/ScopedBurstSMG/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ScopedBurstSMG_Common<public> := class<final><concrete>(entity) {}

        @experimental
        ScopedBurstSMG_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ScopedBurstSMG_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        ScopedBurstSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        ScopedBurstSMG_Uncommon<public> := class<final><concrete>(entity) {}

        @experimental
        ThornesScopedBurstSMG_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ScopedRevolver
  ScopedRevolver<public> := module {
    # Module import path: /Fortnite.com/Items/ScopedRevolver/BattleRoyale
    (/Fortnite.com/Items/ScopedRevolver:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ScopedRevolver/BattleRoyale/CH1S7
      (/Fortnite.com/Items/ScopedRevolver/BattleRoyale:)CH1S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ScopedRevolver_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ScopedRevolver_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SemiAutoPistol
  SemiAutoPistol<public> := module {
    # Module import path: /Fortnite.com/Items/SemiAutoPistol/BattleRoyale
    (/Fortnite.com/Items/SemiAutoPistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SemiAutoPistol/BattleRoyale/CH2S1
      (/Fortnite.com/Items/SemiAutoPistol/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SemiAutoPistol_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SemiAutoPistol_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SemiAutoPistol/BattleRoyale/PreSeason
      (/Fortnite.com/Items/SemiAutoPistol/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SemiAutoPistol_Common<public> := class<final><concrete>(entity) {}

        @experimental
        SemiAutoPistol_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SemiAutoPistol_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SemiAutoSniperRifle
  SemiAutoSniperRifle<public> := module {
    # Module import path: /Fortnite.com/Items/SemiAutoSniperRifle/BattleRoyale
    (/Fortnite.com/Items/SemiAutoSniperRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SemiAutoSniperRifle/BattleRoyale/CH2S2
      (/Fortnite.com/Items/SemiAutoSniperRifle/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SemiAutoSniperRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SemiAutoSniperRifle_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SemiAutoSniperRifle/BattleRoyale/PreSeason
      (/Fortnite.com/Items/SemiAutoSniperRifle/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SemiAutoSniperRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SemiAutoSniperRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SemiAutoSuppressedPistol
  SemiAutoSuppressedPistol<public> := module {
    # Module import path: /Fortnite.com/Items/SemiAutoSuppressedPistol/BattleRoyale
    (/Fortnite.com/Items/SemiAutoSuppressedPistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SemiAutoSuppressedPistol/BattleRoyale/CH1S2
      (/Fortnite.com/Items/SemiAutoSuppressedPistol/BattleRoyale:)CH1S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SemiAutoSuppressedPistol_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SemiAutoSuppressedPistol_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SemiAutoSuppressedPistol/BattleRoyale/CH3S1
      (/Fortnite.com/Items/SemiAutoSuppressedPistol/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SemiAutoSuppressedPistol_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        SemiAutoSuppressedPistol_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SentinelPumpShotgun
  SentinelPumpShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/SentinelPumpShotgun/BattleRoyale
    (/Fortnite.com/Items/SentinelPumpShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SentinelPumpShotgun/BattleRoyale/CH6S1
      (/Fortnite.com/Items/SentinelPumpShotgun/BattleRoyale:)CH6S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedSentinelPumpShotgun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        SentinelPumpShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        SentinelPumpShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SentinelPumpShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        SentinelPumpShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SentinelPumpShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SevenClusterCannon
  SevenClusterCannon<public> := module {
    # Module import path: /Fortnite.com/Items/SevenClusterCannon/BattleRoyale
    (/Fortnite.com/Items/SevenClusterCannon:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SevenClusterCannon/BattleRoyale/CH7S2
      (/Fortnite.com/Items/SevenClusterCannon/BattleRoyale:)CH7S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SevenClusterCannon_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SevenClusterCannon_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SevenPowerGloves
  SevenPowerGloves<public> := module {
    # Module import path: /Fortnite.com/Items/SevenPowerGloves/BattleRoyale
    (/Fortnite.com/Items/SevenPowerGloves:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SevenPowerGloves/BattleRoyale/CH7S2
      (/Fortnite.com/Items/SevenPowerGloves/BattleRoyale:)CH7S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        FoundationsPowerGloves_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        SevenPowerGloves_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ShadowBomb
  ShadowBomb<public> := module {
    # Module import path: /Fortnite.com/Items/ShadowBomb/BattleRoyale
    (/Fortnite.com/Items/ShadowBomb:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ShadowBomb/BattleRoyale/CH1S8
      (/Fortnite.com/Items/ShadowBomb/BattleRoyale:)CH1S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ShadowBomb_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ShadowFlopper
  ShadowFlopper<public> := module {
    # Module import path: /Fortnite.com/Items/ShadowFlopper/BattleRoyale
    (/Fortnite.com/Items/ShadowFlopper:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ShadowFlopper/BattleRoyale/CH2S8
      (/Fortnite.com/Items/ShadowFlopper/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ShadowFlopper_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ShadowTracker
  ShadowTracker<public> := module {
    # Module import path: /Fortnite.com/Items/ShadowTracker/BattleRoyale
    (/Fortnite.com/Items/ShadowTracker:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ShadowTracker/BattleRoyale/CH2S5
      (/Fortnite.com/Items/ShadowTracker/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ShadowTracker_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SharkKeycard
  SharkKeycard<public> := module {
    # Module import path: /Fortnite.com/Items/SharkKeycard/BattleRoyale
    (/Fortnite.com/Items/SharkKeycard:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SharkKeycard/BattleRoyale/CH2S2
      (/Fortnite.com/Items/SharkKeycard/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SharkKeycard_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SharkTooth
  SharkTooth<public> := module {
    # Module import path: /Fortnite.com/Items/SharkTooth/Creative
    (/Fortnite.com/Items/SharkTooth:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      SharkTooth_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/SharpToothShotgun
  SharpToothShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/SharpToothShotgun/BattleRoyale
    (/Fortnite.com/Items/SharpToothShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SharpToothShotgun/BattleRoyale/CH4S3
      (/Fortnite.com/Items/SharpToothShotgun/BattleRoyale:)CH4S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SharpToothShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SharpToothShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        SharpToothShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SharpToothShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ShieldBreakerEMP
  ShieldBreakerEMP<public> := module {
    # Module import path: /Fortnite.com/Items/ShieldBreakerEMP/BattleRoyale
    (/Fortnite.com/Items/ShieldBreakerEMP:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ShieldBreakerEMP/BattleRoyale/CH4S4
      (/Fortnite.com/Items/ShieldBreakerEMP/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ShieldBreakerEMP_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ShieldBubble
  ShieldBubble<public> := module {
    # Module import path: /Fortnite.com/Items/ShieldBubble/BattleRoyale
    (/Fortnite.com/Items/ShieldBubble:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ShieldBubble/BattleRoyale/CH1SX
      (/Fortnite.com/Items/ShieldBubble/BattleRoyale:)CH1SX<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ShieldBubble_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ShieldBubbleJr
  ShieldBubbleJr<public> := module {
    # Module import path: /Fortnite.com/Items/ShieldBubbleJr/BattleRoyale
    (/Fortnite.com/Items/ShieldBubbleJr:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ShieldBubbleJr/BattleRoyale/CH5S2
      (/Fortnite.com/Items/ShieldBubbleJr/BattleRoyale:)CH5S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ShieldBubbleJr_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ShieldFish
  ShieldFish<public> := module {
    # Module import path: /Fortnite.com/Items/ShieldFish/BattleRoyale
    (/Fortnite.com/Items/ShieldFish:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ShieldFish/BattleRoyale/CH2S4
      (/Fortnite.com/Items/ShieldFish/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ShieldFish_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ShieldKeg
  ShieldKeg<public> := module {
    # Module import path: /Fortnite.com/Items/ShieldKeg/BattleRoyale
    (/Fortnite.com/Items/ShieldKeg:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ShieldKeg/BattleRoyale/CH3S1
      (/Fortnite.com/Items/ShieldKeg/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ShieldKeg_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ShieldMushroom
  ShieldMushroom<public> := module {
    # Module import path: /Fortnite.com/Items/ShieldMushroom/BattleRoyale
    (/Fortnite.com/Items/ShieldMushroom:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ShieldMushroom/BattleRoyale/CH1S4
      (/Fortnite.com/Items/ShieldMushroom/BattleRoyale:)CH1S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ShieldMushroom_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ShieldPotion
  ShieldPotion<public> := module {
    # Module import path: /Fortnite.com/Items/ShieldPotion/BattleRoyale
    (/Fortnite.com/Items/ShieldPotion:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ShieldPotion/BattleRoyale/CH5S1
      (/Fortnite.com/Items/ShieldPotion/BattleRoyale:)CH5S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/ShieldPotion/BattleRoyale/CH5S1:)ShieldPotion_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/ShieldPotion/BattleRoyale/PreSeason
      (/Fortnite.com/Items/ShieldPotion/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/ShieldPotion/BattleRoyale/PreSeason:)ShieldPotion_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ShockwaveGrenade
  ShockwaveGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/ShockwaveGrenade/BattleRoyale
    (/Fortnite.com/Items/ShockwaveGrenade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ShockwaveGrenade/BattleRoyale/CH1S5
      (/Fortnite.com/Items/ShockwaveGrenade/BattleRoyale:)CH1S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ShockwaveGrenade_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ShockwaveHammer
  ShockwaveHammer<public> := module {
    # Module import path: /Fortnite.com/Items/ShockwaveHammer/BattleRoyale
    (/Fortnite.com/Items/ShockwaveHammer:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ShockwaveHammer/BattleRoyale/CH4S1
      (/Fortnite.com/Items/ShockwaveHammer/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ShockwaveHammer_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        TheAgelessChampionsShockwaveHammer_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ShockwaveLauncher
  ShockwaveLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/ShockwaveLauncher/BattleRoyale
    (/Fortnite.com/Items/ShockwaveLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ShockwaveLauncher/BattleRoyale/CH2S3
      (/Fortnite.com/Items/ShockwaveLauncher/BattleRoyale:)CH2S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        KitsShockwaveLauncher_Mythic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/ShockwaveLauncher/BattleRoyale/CH2S8
      (/Fortnite.com/Items/ShockwaveLauncher/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ShockwaveLauncher_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/ShockwaveLauncher/BattleRoyale/CH6S4
      (/Fortnite.com/Items/ShockwaveLauncher/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EradicatorShockNSlowShockwaveLauncher_Exotic<public> := class<final><concrete>(entity) {}

        @experimental
        ShockwaveLauncher_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Shove
  Shove<public> := module {
    # Module import path: /Fortnite.com/Items/Shove/Creative
    (/Fortnite.com/Items/Shove:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Shove_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/SidearmPistol
  SidearmPistol<public> := module {
    # Module import path: /Fortnite.com/Items/SidearmPistol/BattleRoyale
    (/Fortnite.com/Items/SidearmPistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SidearmPistol/BattleRoyale/CH3S1
      (/Fortnite.com/Items/SidearmPistol/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SidearmPistol_Common<public> := class<final><concrete>(entity) {}

        @experimental
        SidearmPistol_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SidearmPistol_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        SidearmPistol_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SidearmPistol_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SidewaysMinigun
  SidewaysMinigun<public> := module {
    # Module import path: /Fortnite.com/Items/SidewaysMinigun/BattleRoyale
    (/Fortnite.com/Items/SidewaysMinigun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SidewaysMinigun/BattleRoyale/CH2S8
      (/Fortnite.com/Items/SidewaysMinigun/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SidewaysMinigun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysMinigun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysMinigun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysMinigun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysMinigun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysMinigun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SidewaysRifle
  SidewaysRifle<public> := module {
    # Module import path: /Fortnite.com/Items/SidewaysRifle/BattleRoyale
    (/Fortnite.com/Items/SidewaysRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SidewaysRifle/BattleRoyale/CH2S8
      (/Fortnite.com/Items/SidewaysRifle/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SidewaysRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SidewaysScythe
  SidewaysScythe<public> := module {
    # Module import path: /Fortnite.com/Items/SidewaysScythe/BattleRoyale
    (/Fortnite.com/Items/SidewaysScythe:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SidewaysScythe/BattleRoyale/CH2S8
      (/Fortnite.com/Items/SidewaysScythe/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SidewaysScythe_Common<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysScythe_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysScythe_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysScythe_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysScythe_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SidewaysScythe_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SignalRemote
  SignalRemote<public> := module {
    # Module import path: /Fortnite.com/Items/SignalRemote/Creative
    (/Fortnite.com/Items/SignalRemote:)Creative<public> := module {
      @experimental
      SignalRemoteA_Uncommon<public> := class<final><concrete>(entity) {}

      @experimental
      SignalRemoteB_Rare<public> := class<final><concrete>(entity) {}

      @experimental
      SignalRemoteC_Epic<public> := class<final><concrete>(entity) {}

      @experimental
      SignalRemoteD_Legendary<public> := class<final><concrete>(entity) {}

      using { /Verse.org/SceneGraph }
      @experimental
      SignalRemote_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/SixShooter
  SixShooter<public> := module {
    # Module import path: /Fortnite.com/Items/SixShooter/BattleRoyale
    (/Fortnite.com/Items/SixShooter:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SixShooter/BattleRoyale/CH1S6
      (/Fortnite.com/Items/SixShooter/BattleRoyale:)CH1S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SixShooter_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SixShooter_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SixShooter_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SixShooter/BattleRoyale/CH7S1
      (/Fortnite.com/Items/SixShooter/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SixShooter_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SkyesGrappler
  SkyesGrappler<public> := module {
    # Module import path: /Fortnite.com/Items/SkyesGrappler/BattleRoyale
    (/Fortnite.com/Items/SkyesGrappler:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SkyesGrappler/BattleRoyale/CH2S2
      (/Fortnite.com/Items/SkyesGrappler/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SkyesGrappler_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SkylineDeployer
  SkylineDeployer<public> := module {
    # Module import path: /Fortnite.com/Items/SkylineDeployer/BattleRoyale
    (/Fortnite.com/Items/SkylineDeployer:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SkylineDeployer/BattleRoyale/CH7S2
      (/Fortnite.com/Items/SkylineDeployer/BattleRoyale:)CH7S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SkylineDeployer_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SlapBerry
  SlapBerry<public> := module {
    # Module import path: /Fortnite.com/Items/SlapBerry/BattleRoyale
    (/Fortnite.com/Items/SlapBerry:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SlapBerry/BattleRoyale/CH4S1
      (/Fortnite.com/Items/SlapBerry/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SlapBerry_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SlapJuice
  SlapJuice<public> := module {
    # Module import path: /Fortnite.com/Items/SlapJuice/BattleRoyale
    (/Fortnite.com/Items/SlapJuice:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SlapJuice/BattleRoyale/CH4S1
      (/Fortnite.com/Items/SlapJuice/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SlapJuice_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SlapSplash
  SlapSplash<public> := module {
    # Module import path: /Fortnite.com/Items/SlapSplash/BattleRoyale
    (/Fortnite.com/Items/SlapSplash:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SlapSplash/BattleRoyale/CH4S3
      (/Fortnite.com/Items/SlapSplash/BattleRoyale:)CH4S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SlapSplash_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SuperSlapSplash_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SlapperoniPizza
  SlapperoniPizza<public> := module {
    # Module import path: /Fortnite.com/Items/SlapperoniPizza/BattleRoyale
    (/Fortnite.com/Items/SlapperoniPizza:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SlapperoniPizza/BattleRoyale/CH7S2
      (/Fortnite.com/Items/SlapperoniPizza/BattleRoyale:)CH7S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SlapperoniPizza_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SlapperoniSlice
  SlapperoniSlice<public> := module {
    # Module import path: /Fortnite.com/Items/SlapperoniSlice/BattleRoyale
    (/Fortnite.com/Items/SlapperoniSlice:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SlapperoniSlice/BattleRoyale/CH7S2
      (/Fortnite.com/Items/SlapperoniSlice/BattleRoyale:)CH7S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SlapperoniSlice_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SlurpJuice
  SlurpJuice<public> := module {
    # Module import path: /Fortnite.com/Items/SlurpJuice/BattleRoyale
    (/Fortnite.com/Items/SlurpJuice:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SlurpJuice/BattleRoyale/CH1S1
      (/Fortnite.com/Items/SlurpJuice/BattleRoyale:)CH1S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SlurpJuice_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SlurpJuice/BattleRoyale/CH6S4
      (/Fortnite.com/Items/SlurpJuice/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SlurpJuice_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SlurpMushroom
  SlurpMushroom<public> := module {
    # Module import path: /Fortnite.com/Items/SlurpMushroom/BattleRoyale
    (/Fortnite.com/Items/SlurpMushroom:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SlurpMushroom/BattleRoyale/CH2S1
      (/Fortnite.com/Items/SlurpMushroom/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SlurpMushroom_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Slurpfish
  Slurpfish<public> := module {
    # Module import path: /Fortnite.com/Items/Slurpfish/BattleRoyale
    (/Fortnite.com/Items/Slurpfish:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Slurpfish/BattleRoyale/CH2S1
      (/Fortnite.com/Items/Slurpfish/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Slurpfish_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SmallFry
  SmallFry<public> := module {
    # Module import path: /Fortnite.com/Items/SmallFry/BattleRoyale
    (/Fortnite.com/Items/SmallFry:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SmallFry/BattleRoyale/CH2S1
      (/Fortnite.com/Items/SmallFry/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SmallFry_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SmallShieldPotion
  SmallShieldPotion<public> := module {
    # Module import path: /Fortnite.com/Items/SmallShieldPotion/BattleRoyale
    (/Fortnite.com/Items/SmallShieldPotion:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SmallShieldPotion/BattleRoyale/CH1S2
      (/Fortnite.com/Items/SmallShieldPotion/BattleRoyale:)CH1S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/SmallShieldPotion/BattleRoyale/CH1S2:)SmallShieldPotion_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SmallShieldPotion/BattleRoyale/CH5S1
      (/Fortnite.com/Items/SmallShieldPotion/BattleRoyale:)CH5S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/SmallShieldPotion/BattleRoyale/CH5S1:)SmallShieldPotion_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SmokeGrenade
  SmokeGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/SmokeGrenade/Ballistic
    (/Fortnite.com/Items/SmokeGrenade:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      SmokeGrenade_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/SmokeGrenade/BattleRoyale
    (/Fortnite.com/Items/SmokeGrenade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SmokeGrenade/BattleRoyale/CH1S1
      (/Fortnite.com/Items/SmokeGrenade/BattleRoyale:)CH1S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SmokeGrenade_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SneakySnowman
  SneakySnowman<public> := module {
    # Module import path: /Fortnite.com/Items/SneakySnowman/BattleRoyale
    (/Fortnite.com/Items/SneakySnowman:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SneakySnowman/BattleRoyale/CH2S1
      (/Fortnite.com/Items/SneakySnowman/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SneakySnowman_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SnowballLauncher
  SnowballLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/SnowballLauncher/BattleRoyale
    (/Fortnite.com/Items/SnowballLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SnowballLauncher/BattleRoyale/CH1S2
      (/Fortnite.com/Items/SnowballLauncher/BattleRoyale:)CH1S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SnowballLauncher_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SnowballLauncher_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        SnowballLauncher_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SnowballLauncher/BattleRoyale/CH2S1
      (/Fortnite.com/Items/SnowballLauncher/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SnowballLauncher_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SnowyFlopper
  SnowyFlopper<public> := module {
    # Module import path: /Fortnite.com/Items/SnowyFlopper/BattleRoyale
    (/Fortnite.com/Items/SnowyFlopper:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SnowyFlopper/BattleRoyale/CH2S5
      (/Fortnite.com/Items/SnowyFlopper/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SnowyFlopper_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SovereignShotgun
  SovereignShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/SovereignShotgun/BattleRoyale
    (/Fortnite.com/Items/SovereignShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH5S4
      (/Fortnite.com/Items/SovereignShotgun/BattleRoyale:)CH5S4<public> := module {
        # Module import path: /Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH5S4/Modular
        (/Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH5S4:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          (/Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH5S4/Modular:)SovereignShotgun_Common<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH5S4/Modular:)SovereignShotgun_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH5S4/Modular:)SovereignShotgun_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH5S4/Modular:)SovereignShotgun_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH5S4/Modular:)SovereignShotgun_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }

      # Module import path: /Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH7S1
      (/Fortnite.com/Items/SovereignShotgun/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH7S1:)SovereignShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH7S1:)SovereignShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH7S1:)SovereignShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH7S1:)SovereignShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/SovereignShotgun/BattleRoyale/CH7S1:)SovereignShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SovereignSniper
  SovereignSniper<public> := module {
    # Module import path: /Fortnite.com/Items/SovereignSniper/Ballistic
    (/Fortnite.com/Items/SovereignSniper:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      SovereignSniper_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/SpeedBoost
  SpeedBoost<public> := module {
    # Module import path: /Fortnite.com/Items/SpeedBoost/Creative
    (/Fortnite.com/Items/SpeedBoost:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      SpeedBoostHigh_Epic<public> := class<final><concrete>(entity) {}

      @experimental
      SpeedBoostLow_Uncommon<public> := class<final><concrete>(entity) {}

      @experimental
      SpeedBoostMedium_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/SpicyFish
  SpicyFish<public> := module {
    # Module import path: /Fortnite.com/Items/SpicyFish/BattleRoyale
    (/Fortnite.com/Items/SpicyFish:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SpicyFish/BattleRoyale/CH2S4
      (/Fortnite.com/Items/SpicyFish/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SpicyFish_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SpicyIcecreamCone
  SpicyIcecreamCone<public> := module {
    # Module import path: /Fortnite.com/Items/SpicyIcecreamCone/BattleRoyale
    (/Fortnite.com/Items/SpicyIcecreamCone:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SpicyIcecreamCone/BattleRoyale/CH3S3
      (/Fortnite.com/Items/SpicyIcecreamCone/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SpicyIcecreamCone_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SpireJumpboots
  SpireJumpboots<public> := module {
    # Module import path: /Fortnite.com/Items/SpireJumpboots/BattleRoyale
    (/Fortnite.com/Items/SpireJumpboots:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SpireJumpboots/BattleRoyale/CH2S6
      (/Fortnite.com/Items/SpireJumpboots/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SpireJumpboots_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SpireRifle
  SpireRifle<public> := module {
    # Module import path: /Fortnite.com/Items/SpireRifle/BattleRoyale
    (/Fortnite.com/Items/SpireRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SpireRifle/BattleRoyale/CH6S3
      (/Fortnite.com/Items/SpireRifle/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedSpireRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        SpireRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        SpireRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SpireRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        SpireRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SpireRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/StealthSplash
  StealthSplash<public> := module {
    # Module import path: /Fortnite.com/Items/StealthSplash/BattleRoyale
    (/Fortnite.com/Items/StealthSplash:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/StealthSplash/BattleRoyale/CH7S1
      (/Fortnite.com/Items/StealthSplash/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        StealthSplash_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/StickyGrenadeLauncher
  StickyGrenadeLauncher<public> := module {
    # Module import path: /Fortnite.com/Items/StickyGrenadeLauncher/BattleRoyale
    (/Fortnite.com/Items/StickyGrenadeLauncher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/StickyGrenadeLauncher/BattleRoyale/CH4S4
      (/Fortnite.com/Items/StickyGrenadeLauncher/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        StickyGrenadeLauncher_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        StickyGrenadeLauncher_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/StimpulseGrenade
  StimpulseGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/StimpulseGrenade/BattleRoyale
    (/Fortnite.com/Items/StimpulseGrenade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/StimpulseGrenade/BattleRoyale/CH7S2
      (/Fortnite.com/Items/StimpulseGrenade/BattleRoyale:)CH7S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        StimpulseGrenade_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/StingerSMG
  StingerSMG<public> := module {
    # Module import path: /Fortnite.com/Items/StingerSMG/BattleRoyale
    (/Fortnite.com/Items/StingerSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/StingerSMG/BattleRoyale/CH3S1
      (/Fortnite.com/Items/StingerSMG/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        GunnarsStingerSMG_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        StingerSMG_Common<public> := class<final><concrete>(entity) {}

        @experimental
        StingerSMG_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        StingerSMG_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        StingerSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        StingerSMG_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/StinkBomb
  StinkBomb<public> := module {
    # Module import path: /Fortnite.com/Items/StinkBomb/BattleRoyale
    (/Fortnite.com/Items/StinkBomb:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/StinkBomb/BattleRoyale/CH1S4
      (/Fortnite.com/Items/StinkBomb/BattleRoyale:)CH1S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        StinkBomb_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/StinkFish
  StinkFish<public> := module {
    # Module import path: /Fortnite.com/Items/StinkFish/BattleRoyale
    (/Fortnite.com/Items/StinkFish:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/StinkFish/BattleRoyale/CH2S6
      (/Fortnite.com/Items/StinkFish/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        StinkFish_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/StinkSac
  StinkSac<public> := module {
    # Module import path: /Fortnite.com/Items/StinkSac/BattleRoyale
    (/Fortnite.com/Items/StinkSac:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/StinkSac/BattleRoyale/CH2S6
      (/Fortnite.com/Items/StinkSac/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        StinkSac_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Stone
  Stone<public> := module {
    # Module import path: /Fortnite.com/Items/Stone/BattleRoyale
    (/Fortnite.com/Items/Stone:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Stone/BattleRoyale/PreSeason
      (/Fortnite.com/Items/Stone/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Stone_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/StormFlip
  StormFlip<public> := module {
    # Module import path: /Fortnite.com/Items/StormFlip/BattleRoyale
    (/Fortnite.com/Items/StormFlip:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/StormFlip/BattleRoyale/CH1S9
      (/Fortnite.com/Items/StormFlip/BattleRoyale:)CH1S9<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        StormFlip_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/StormScout
  StormScout<public> := module {
    # Module import path: /Fortnite.com/Items/StormScout/BattleRoyale
    (/Fortnite.com/Items/StormScout:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/StormScout/BattleRoyale/CH2S5
      (/Fortnite.com/Items/StormScout/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        StormScout_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/StormScoutSniperRifle
  StormScoutSniperRifle<public> := module {
    # Module import path: /Fortnite.com/Items/StormScoutSniperRifle/BattleRoyale
    (/Fortnite.com/Items/StormScoutSniperRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/StormScoutSniperRifle/BattleRoyale/CH1S9
      (/Fortnite.com/Items/StormScoutSniperRifle/BattleRoyale:)CH1S9<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        StormScoutSniperRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        StormScoutSniperRifle_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/StrikerAR
  StrikerAR<public> := module {
    # Module import path: /Fortnite.com/Items/StrikerAR/Ballistic
    (/Fortnite.com/Items/StrikerAR:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      (/Fortnite.com/Items/StrikerAR/Ballistic:)StrikerAR_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/StrikerAR/BattleRoyale
    (/Fortnite.com/Items/StrikerAR:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/StrikerAR/BattleRoyale/CH5S1
      (/Fortnite.com/Items/StrikerAR/BattleRoyale:)CH5S1<public> := module {
        # Module import path: /Fortnite.com/Items/StrikerAR/BattleRoyale/CH5S1/Modular
        (/Fortnite.com/Items/StrikerAR/BattleRoyale/CH5S1:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          NishasStrikerAR_Mythic<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/StrikerAR/BattleRoyale/CH5S1/Modular:)StrikerAR_Common<public> := class<final><concrete>(entity) {}

          @experimental
          StrikerAR_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          StrikerAR_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          StrikerAR_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          StrikerAR_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/StrikerBurstRifle
  StrikerBurstRifle<public> := module {
    # Module import path: /Fortnite.com/Items/StrikerBurstRifle/BattleRoyale
    (/Fortnite.com/Items/StrikerBurstRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH3S2
      (/Fortnite.com/Items/StrikerBurstRifle/BattleRoyale:)CH3S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SlonesStrikerBurstRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH3S2:)StrikerBurstRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH3S2:)StrikerBurstRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH3S2:)StrikerBurstRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        StrikerBurstRifle_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH3S2:)StrikerBurstRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH3S2:)StrikerBurstRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH5S4
      (/Fortnite.com/Items/StrikerBurstRifle/BattleRoyale:)CH5S4<public> := module {
        # Module import path: /Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH5S4/Modular
        (/Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH5S4:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          (/Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH5S4/Modular:)StrikerBurstRifle_Common<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH5S4/Modular:)StrikerBurstRifle_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH5S4/Modular:)StrikerBurstRifle_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH5S4/Modular:)StrikerBurstRifle_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/StrikerBurstRifle/BattleRoyale/CH5S4/Modular:)StrikerBurstRifle_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/StrikerPumpShotgun
  StrikerPumpShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/StrikerPumpShotgun/BattleRoyale
    (/Fortnite.com/Items/StrikerPumpShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/StrikerPumpShotgun/BattleRoyale/CH3S1
      (/Fortnite.com/Items/StrikerPumpShotgun/BattleRoyale:)CH3S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        StrikerPumpShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        StrikerPumpShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        StrikerPumpShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        StrikerPumpShotgun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        StrikerPumpShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        StrikerPumpShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SubmachineGun
  SubmachineGun<public> := module {
    # Module import path: /Fortnite.com/Items/SubmachineGun/BattleRoyale
    (/Fortnite.com/Items/SubmachineGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SubmachineGun/BattleRoyale/CH1S5
      (/Fortnite.com/Items/SubmachineGun/BattleRoyale:)CH1S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/SubmachineGun/BattleRoyale/CH1S5:)SubmachineGun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/SubmachineGun/BattleRoyale/CH1S5:)SubmachineGun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/SubmachineGun/BattleRoyale/CH1S5:)SubmachineGun_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SubmachineGun/BattleRoyale/CH2S1
      (/Fortnite.com/Items/SubmachineGun/BattleRoyale:)CH2S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/SubmachineGun/BattleRoyale/CH2S1:)SubmachineGun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/SubmachineGun/BattleRoyale/CH2S1:)SubmachineGun_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SubmachineGun/BattleRoyale/CH4MS1
      (/Fortnite.com/Items/SubmachineGun/BattleRoyale:)CH4MS1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/SubmachineGun/BattleRoyale/CH4MS1:)SubmachineGun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/SubmachineGun/BattleRoyale/CH4MS1:)SubmachineGun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/SubmachineGun/BattleRoyale/CH4MS1:)SubmachineGun_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SubmachineGun/BattleRoyale/CH4S1
      (/Fortnite.com/Items/SubmachineGun/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HeistedRunNGunSMG_Exotic<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SubmachineGun/BattleRoyale/CH4S2
      (/Fortnite.com/Items/SubmachineGun/BattleRoyale:)CH4S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/SubmachineGun/BattleRoyale/CH4S2:)SubmachineGun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/SubmachineGun/BattleRoyale/CH4S2:)SubmachineGun_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SuppressedAssaultRifle
  SuppressedAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/SuppressedAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/SuppressedAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SuppressedAssaultRifle/BattleRoyale/CH1S5
      (/Fortnite.com/Items/SuppressedAssaultRifle/BattleRoyale:)CH1S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SuppressedAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SuppressedAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SuppressedAssaultRifle/BattleRoyale/CH2S2
      (/Fortnite.com/Items/SuppressedAssaultRifle/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SuppressedAssaultRifle_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SuppressedAssaultRifle/BattleRoyale/CH6MS2
      (/Fortnite.com/Items/SuppressedAssaultRifle/BattleRoyale:)CH6MS2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SuppressedAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        SuppressedAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SuppressedPistol
  SuppressedPistol<public> := module {
    # Module import path: /Fortnite.com/Items/SuppressedPistol/BattleRoyale
    (/Fortnite.com/Items/SuppressedPistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SuppressedPistol/BattleRoyale/CH4S4
      (/Fortnite.com/Items/SuppressedPistol/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SuppressedPistol_Common<public> := class<final><concrete>(entity) {}

        @experimental
        SuppressedPistol_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SuppressedPistol_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        SuppressedPistol_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SuppressedPistol_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SuppressedPistol/BattleRoyale/CH6S2
      (/Fortnite.com/Items/SuppressedPistol/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SuppressedPistol_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SuppressedSniperRifle
  SuppressedSniperRifle<public> := module {
    # Module import path: /Fortnite.com/Items/SuppressedSniperRifle/BattleRoyale
    (/Fortnite.com/Items/SuppressedSniperRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SuppressedSniperRifle/BattleRoyale/CH1S7
      (/Fortnite.com/Items/SuppressedSniperRifle/BattleRoyale:)CH1S7<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SuppressedSniperRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SuppressedSniperRifle_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SuppressedSniperRifle/BattleRoyale/CH2S2
      (/Fortnite.com/Items/SuppressedSniperRifle/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SuppressedSniperRifle_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SuppressedSubmachineGun
  SuppressedSubmachineGun<public> := module {
    # Module import path: /Fortnite.com/Items/SuppressedSubmachineGun/BattleRoyale
    (/Fortnite.com/Items/SuppressedSubmachineGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SuppressedSubmachineGun/BattleRoyale/CH3S4
      (/Fortnite.com/Items/SuppressedSubmachineGun/BattleRoyale:)CH3S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        InkquisitorsSuppressedSMG_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        SuppressedSubmachineGun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SuppressedSubmachineGun_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/SuppressedSubmachineGun/BattleRoyale/PreSeason
      (/Fortnite.com/Items/SuppressedSubmachineGun/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SuppressedSubmachineGun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        SuppressedSubmachineGun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SuppressedSubmachineGun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SurfCube
  SurfCube<public> := module {
    # Module import path: /Fortnite.com/Items/SurfCube/BattleRoyale
    (/Fortnite.com/Items/SurfCube:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SurfCube/BattleRoyale/CH6S3
      (/Fortnite.com/Items/SurfCube/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LightridersSurfCube_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        SurfCube_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SurgefireSMG
  SurgefireSMG<public> := module {
    # Module import path: /Fortnite.com/Items/SurgefireSMG/BattleRoyale
    (/Fortnite.com/Items/SurgefireSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SurgefireSMG/BattleRoyale/CH6S1
      (/Fortnite.com/Items/SurgefireSMG/BattleRoyale:)CH6S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedSurgefireSMG_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        SurgefireSMG_Common<public> := class<final><concrete>(entity) {}

        @experimental
        SurgefireSMG_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SurgefireSMG_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        SurgefireSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SurgefireSMG_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Swarmstrike
  Swarmstrike<public> := module {
    # Module import path: /Fortnite.com/Items/Swarmstrike/BattleRoyale
    (/Fortnite.com/Items/Swarmstrike:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Swarmstrike/BattleRoyale/CH6S4
      (/Fortnite.com/Items/Swarmstrike/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Swarmstrike_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        Swarmstrike_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/SweeperShotgun
  SweeperShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/SweeperShotgun/BattleRoyale
    (/Fortnite.com/Items/SweeperShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/SweeperShotgun/BattleRoyale/CH6S4
      (/Fortnite.com/Items/SweeperShotgun/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        SweeperShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        SweeperShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        SweeperShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        SweeperShotgun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        SweeperShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        SweeperShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TNTinasKaBoomBow
  TNTinasKaBoomBow<public> := module {
    # Module import path: /Fortnite.com/Items/TNTinasKaBoomBow/BattleRoyale
    (/Fortnite.com/Items/TNTinasKaBoomBow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TNTinasKaBoomBow/BattleRoyale/CH2S2
      (/Fortnite.com/Items/TNTinasKaBoomBow/BattleRoyale:)CH2S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        TNTinasKaBoomBow_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TacticalAssaultRifle
  TacticalAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/TacticalAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH1S9
      (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale:)CH1S9<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH1S9:)TacticalAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH1S9:)TacticalAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH1S9:)TacticalAssaultRifle_Rare<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH4S1
      (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH4S1:)TacticalAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH4S1:)TacticalAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH5S2
      (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale:)CH5S2<public> := module {
        # Module import path: /Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH5S2/Modular
        (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH5S2:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH5S2/Modular:)TacticalAssaultRifle_Common<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH5S2/Modular:)TacticalAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH5S2/Modular:)TacticalAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH5S2/Modular:)TacticalAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH5S2/Modular:)TacticalAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }

      # Module import path: /Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH7S1
      (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH7S1:)TacticalAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH7S1:)TacticalAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH7S1:)TacticalAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH7S1:)TacticalAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalAssaultRifle/BattleRoyale/CH7S1:)TacticalAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TacticalDMR
  TacticalDMR<public> := module {
    # Module import path: /Fortnite.com/Items/TacticalDMR/BattleRoyale
    (/Fortnite.com/Items/TacticalDMR:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TacticalDMR/BattleRoyale/CH4S4
      (/Fortnite.com/Items/TacticalDMR/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        TacticalDMR_Common<public> := class<final><concrete>(entity) {}

        @experimental
        TacticalDMR_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        TacticalDMR_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        TacticalDMR_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        TacticalDMR_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TacticalPistol
  TacticalPistol<public> := module {
    # Module import path: /Fortnite.com/Items/TacticalPistol/BattleRoyale
    (/Fortnite.com/Items/TacticalPistol:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TacticalPistol/BattleRoyale/CH4S1
      (/Fortnite.com/Items/TacticalPistol/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/TacticalPistol/BattleRoyale/CH4S1:)TacticalPistol_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalPistol/BattleRoyale/CH4S1:)TacticalPistol_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalPistol/BattleRoyale/CH4S1:)TacticalPistol_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        TacticalPistol_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalPistol/BattleRoyale/CH4S1:)TacticalPistol_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalPistol/BattleRoyale/CH4S1:)TacticalPistol_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/TacticalPistol/BattleRoyale/CH7S1
      (/Fortnite.com/Items/TacticalPistol/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        OverdriveTacticalPistol_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalPistol/BattleRoyale/CH7S1:)TacticalPistol_Common<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalPistol/BattleRoyale/CH7S1:)TacticalPistol_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalPistol/BattleRoyale/CH7S1:)TacticalPistol_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalPistol/BattleRoyale/CH7S1:)TacticalPistol_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalPistol/BattleRoyale/CH7S1:)TacticalPistol_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TacticalShotgun
  TacticalShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/TacticalShotgun/BattleRoyale
    (/Fortnite.com/Items/TacticalShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TacticalShotgun/BattleRoyale/CH1S9
      (/Fortnite.com/Items/TacticalShotgun/BattleRoyale:)CH1S9<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/TacticalShotgun/BattleRoyale/CH1S9:)TacticalShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalShotgun/BattleRoyale/CH1S9:)TacticalShotgun_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/TacticalShotgun/BattleRoyale/CH6MS2
      (/Fortnite.com/Items/TacticalShotgun/BattleRoyale:)CH6MS2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        (/Fortnite.com/Items/TacticalShotgun/BattleRoyale/CH6MS2:)TacticalShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/TacticalShotgun/BattleRoyale/CH6MS2:)TacticalShotgun_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/TacticalShotgun/BattleRoyale/PreSeason
      (/Fortnite.com/Items/TacticalShotgun/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        TacticalShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        TacticalShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        TacticalShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TacticalSubmachineGun
  TacticalSubmachineGun<public> := module {
    # Module import path: /Fortnite.com/Items/TacticalSubmachineGun/BattleRoyale
    (/Fortnite.com/Items/TacticalSubmachineGun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TacticalSubmachineGun/BattleRoyale/CH1SX
      (/Fortnite.com/Items/TacticalSubmachineGun/BattleRoyale:)CH1SX<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        TacticalSubmachineGun_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/TacticalSubmachineGun/BattleRoyale/PreSeason
      (/Fortnite.com/Items/TacticalSubmachineGun/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        TacticalSubmachineGun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        TacticalSubmachineGun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        TacticalSubmachineGun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TheBigChill
  TheBigChill<public> := module {
    # Module import path: /Fortnite.com/Items/TheBigChill/BattleRoyale
    (/Fortnite.com/Items/TheBigChill:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TheBigChill/BattleRoyale/CH2S5
      (/Fortnite.com/Items/TheBigChill/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        TheBigChill_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TheDub
  TheDub<public> := module {
    # Module import path: /Fortnite.com/Items/TheDub/BattleRoyale
    (/Fortnite.com/Items/TheDub:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TheDub/BattleRoyale/CH2S5
      (/Fortnite.com/Items/TheDub/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        TheDub_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TheKneecapper
  TheKneecapper<public> := module {
    # Module import path: /Fortnite.com/Items/TheKneecapper/BattleRoyale
    (/Fortnite.com/Items/TheKneecapper:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TheKneecapper/BattleRoyale/CH6S2
      (/Fortnite.com/Items/TheKneecapper/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        TheKneecapper_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TheMandaloriansJetpack
  TheMandaloriansJetpack<public> := module {
    # Module import path: /Fortnite.com/Items/TheMandaloriansJetpack/BattleRoyale
    (/Fortnite.com/Items/TheMandaloriansJetpack:)BattleRoyale<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      TheMandaloriansJetpack_Mythic<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/ThermalDMR
  ThermalDMR<public> := module {
    # Module import path: /Fortnite.com/Items/ThermalDMR/BattleRoyale
    (/Fortnite.com/Items/ThermalDMR:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ThermalDMR/BattleRoyale/CH4S3
      (/Fortnite.com/Items/ThermalDMR/BattleRoyale:)CH4S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ThermalDMR_Common<public> := class<final><concrete>(entity) {}

        @experimental
        ThermalDMR_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ThermalDMR_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        ThermalDMR_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        ThermalDMR_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        ThermalDMR_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/ThermalDMR/BattleRoyale/CH4S4
      (/Fortnite.com/Items/ThermalDMR/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        DiamondsThermalDMR_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ThermalFish
  ThermalFish<public> := module {
    # Module import path: /Fortnite.com/Items/ThermalFish/BattleRoyale
    (/Fortnite.com/Items/ThermalFish:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ThermalFish/BattleRoyale/CH2S4
      (/Fortnite.com/Items/ThermalFish/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ThermalFish_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ThermalScopedAssaultRifle
  ThermalScopedAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/ThermalScopedAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/ThermalScopedAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ThermalScopedAssaultRifle/BattleRoyale/CH1S4
      (/Fortnite.com/Items/ThermalScopedAssaultRifle/BattleRoyale:)CH1S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ThermalScopedAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ThermalScopedAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/ThermalScopedAssaultRifle/BattleRoyale/CH3S2
      (/Fortnite.com/Items/ThermalScopedAssaultRifle/BattleRoyale:)CH3S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HuntmasterSabersThermalRifle_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ThermalTaffy
  ThermalTaffy<public> := module {
    # Module import path: /Fortnite.com/Items/ThermalTaffy/BattleRoyale
    (/Fortnite.com/Items/ThermalTaffy:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ThermalTaffy/BattleRoyale/CH2S4
      (/Fortnite.com/Items/ThermalTaffy/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ThermalTaffy_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Thermite
  Thermite<public> := module {
    # Module import path: /Fortnite.com/Items/Thermite/BattleRoyale
    (/Fortnite.com/Items/Thermite:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Thermite/BattleRoyale/CH6S2
      (/Fortnite.com/Items/Thermite/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Thermite_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ThunderBurstSMG
  ThunderBurstSMG<public> := module {
    # Module import path: /Fortnite.com/Items/ThunderBurstSMG/Ballistic
    (/Fortnite.com/Items/ThunderBurstSMG:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      (/Fortnite.com/Items/ThunderBurstSMG/Ballistic:)ThunderBurstSMG_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/ThunderBurstSMG/BattleRoyale
    (/Fortnite.com/Items/ThunderBurstSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ThunderBurstSMG/BattleRoyale/CH5S1
      (/Fortnite.com/Items/ThunderBurstSMG/BattleRoyale:)CH5S1<public> := module {
        # Module import path: /Fortnite.com/Items/ThunderBurstSMG/BattleRoyale/CH5S1/Modular
        (/Fortnite.com/Items/ThunderBurstSMG/BattleRoyale/CH5S1:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          (/Fortnite.com/Items/ThunderBurstSMG/BattleRoyale/CH5S1/Modular:)ThunderBurstSMG_Common<public> := class<final><concrete>(entity) {}

          @experimental
          ThunderBurstSMG_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          ThunderBurstSMG_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          ThunderBurstSMG_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          ThunderBurstSMG_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ThunderShotgun
  ThunderShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/ThunderShotgun/BattleRoyale
    (/Fortnite.com/Items/ThunderShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ThunderShotgun/BattleRoyale/CH4S1
      (/Fortnite.com/Items/ThunderShotgun/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ThunderShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        ThunderShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        ThunderShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        ThunderShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        ThunderShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ThunderboltOfZeus
  ThunderboltOfZeus<public> := module {
    # Module import path: /Fortnite.com/Items/ThunderboltOfZeus/BattleRoyale
    (/Fortnite.com/Items/ThunderboltOfZeus:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ThunderboltOfZeus/BattleRoyale/CH5S2
      (/Fortnite.com/Items/ThunderboltOfZeus/BattleRoyale:)CH5S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ThunderboltOfZeus_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Torch
  Torch<public> := module {
    # Module import path: /Fortnite.com/Items/Torch/Creative
    (/Fortnite.com/Items/Torch:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Torch_Rare<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/TowHookCannon
  TowHookCannon<public> := module {
    # Module import path: /Fortnite.com/Items/TowHookCannon/BattleRoyale
    (/Fortnite.com/Items/TowHookCannon:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TowHookCannon/BattleRoyale/CH5S3
      (/Fortnite.com/Items/TowHookCannon/BattleRoyale:)CH5S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        TowHookCannon_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TrackingVisor
  TrackingVisor<public> := module {
    # Module import path: /Fortnite.com/Items/TrackingVisor/BattleRoyale
    (/Fortnite.com/Items/TrackingVisor:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TrackingVisor/BattleRoyale/CH6S3
      (/Fortnite.com/Items/TrackingVisor/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        TrackingVisor_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Trouble
  Trouble<public> := module {
    # Module import path: /Fortnite.com/Items/Trouble/BattleRoyale
    (/Fortnite.com/Items/Trouble:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Trouble/BattleRoyale/CH6S4
      (/Fortnite.com/Items/Trouble/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Trouble_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TwinHammerShotguns
  TwinHammerShotguns<public> := module {
    # Module import path: /Fortnite.com/Items/TwinHammerShotguns/BattleRoyale
    (/Fortnite.com/Items/TwinHammerShotguns:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TwinHammerShotguns/BattleRoyale/CH7S1
      (/Fortnite.com/Items/TwinHammerShotguns/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        BrutusTwinHammerShotguns_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        TwinHammerShotguns_Common<public> := class<final><concrete>(entity) {}

        @experimental
        TwinHammerShotguns_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        TwinHammerShotguns_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        TwinHammerShotguns_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        TwinHammerShotguns_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TwinMagAssaultRifle
  TwinMagAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/TwinMagAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/TwinMagAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TwinMagAssaultRifle/BattleRoyale/CH4S4
      (/Fortnite.com/Items/TwinMagAssaultRifle/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        TwinMagAssaultRifle_Common<public> := class<final><concrete>(entity) {}

        @experimental
        TwinMagAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        TwinMagAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        TwinMagAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        TwinMagAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TwinMagSMG
  TwinMagSMG<public> := module {
    # Module import path: /Fortnite.com/Items/TwinMagSMG/BattleRoyale
    (/Fortnite.com/Items/TwinMagSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TwinMagSMG/BattleRoyale/CH4S1
      (/Fortnite.com/Items/TwinMagSMG/BattleRoyale:)CH4S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HeistedBlinkMagSMG_Exotic<public> := class<final><concrete>(entity) {}

        @experimental
        TwinMagSMG_Common<public> := class<final><concrete>(entity) {}

        @experimental
        TwinMagSMG_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        TwinMagSMG_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        TwinMagSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        TwinMagSMG_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Twine
  Twine<public> := module {
    # Module import path: /Fortnite.com/Items/Twine/Creative
    (/Fortnite.com/Items/Twine:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      CarvedTwine_Uncommon<public> := class<final><concrete>(entity) {}

      @experimental
      PeakyTwine_Uncommon<public> := class<final><concrete>(entity) {}

      @experimental
      SimpleTwine_Uncommon<public> := class<final><concrete>(entity) {}

      @experimental
      SpectralTwine_Uncommon<public> := class<final><concrete>(entity) {}

      @experimental
      StringyTwine_Uncommon<public> := class<final><concrete>(entity) {}

      @experimental
      SturdyTwine_Uncommon<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/TwinfireAutoShotgun
  TwinfireAutoShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/TwinfireAutoShotgun/BattleRoyale
    (/Fortnite.com/Items/TwinfireAutoShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TwinfireAutoShotgun/BattleRoyale/CH6S1
      (/Fortnite.com/Items/TwinfireAutoShotgun/BattleRoyale:)CH6S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedTwinfireAutoShotgun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        TwinfireAutoShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        TwinfireAutoShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        TwinfireAutoShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        TwinfireAutoShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        TwinfireAutoShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/TwinfireAutoShotgun/BattleRoyale/CH6S2
      (/Fortnite.com/Items/TwinfireAutoShotgun/BattleRoyale:)CH6S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        LawlessTwinfireSlapShotgun_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TwoShotShotgun
  TwoShotShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/TwoShotShotgun/BattleRoyale
    (/Fortnite.com/Items/TwoShotShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TwoShotShotgun/BattleRoyale/CH3S3
      (/Fortnite.com/Items/TwoShotShotgun/BattleRoyale:)CH3S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        TwoShotShotgun_Common<public> := class<final><concrete>(entity) {}

        @experimental
        TwoShotShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        TwoShotShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        TwoShotShotgun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        TwoShotShotgun_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        TwoShotShotgun_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/TyphoonBlade
  TyphoonBlade<public> := module {
    # Module import path: /Fortnite.com/Items/TyphoonBlade/BattleRoyale
    (/Fortnite.com/Items/TyphoonBlade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/TyphoonBlade/BattleRoyale/CH6S1
      (/Fortnite.com/Items/TyphoonBlade/BattleRoyale:)CH6S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        TyphoonBlade_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        TyphoonBlade_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/UnstableBounceGrenade
  UnstableBounceGrenade<public> := module {
    # Module import path: /Fortnite.com/Items/UnstableBounceGrenade/BattleRoyale
    (/Fortnite.com/Items/UnstableBounceGrenade:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/UnstableBounceGrenade/BattleRoyale/CH6S3
      (/Fortnite.com/Items/UnstableBounceGrenade/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        UnstableBounceGrenade_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/UnstableBow
  UnstableBow<public> := module {
    # Module import path: /Fortnite.com/Items/UnstableBow/BattleRoyale
    (/Fortnite.com/Items/UnstableBow:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/UnstableBow/BattleRoyale/CH2S6
      (/Fortnite.com/Items/UnstableBow/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        UnstableBow_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/UnstableFrostfireShotgun
  UnstableFrostfireShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/UnstableFrostfireShotgun/BattleRoyale
    (/Fortnite.com/Items/UnstableFrostfireShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/UnstableFrostfireShotgun/BattleRoyale/CH6S3
      (/Fortnite.com/Items/UnstableFrostfireShotgun/BattleRoyale:)CH6S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        UnstableFrostfireShotgun_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Vector7DMR
  Vector7DMR<public> := module {
    # Module import path: /Fortnite.com/Items/Vector7DMR/BattleRoyale
    (/Fortnite.com/Items/Vector7DMR:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Vector7DMR/BattleRoyale/CH7S2
      (/Fortnite.com/Items/Vector7DMR/BattleRoyale:)CH7S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Vector7DMR_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        Vector7DMR_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        Vector7DMR_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/VehicleModCowCatcher
  VehicleModCowCatcher<public> := module {
    # Module import path: /Fortnite.com/Items/VehicleModCowCatcher/BattleRoyale
    (/Fortnite.com/Items/VehicleModCowCatcher:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/VehicleModCowCatcher/BattleRoyale/CH3S2
      (/Fortnite.com/Items/VehicleModCowCatcher/BattleRoyale:)CH3S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        VehicleModCowCatcher_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/VehicleModOffRoadTires
  VehicleModOffRoadTires<public> := module {
    # Module import path: /Fortnite.com/Items/VehicleModOffRoadTires/BattleRoyale
    (/Fortnite.com/Items/VehicleModOffRoadTires:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/VehicleModOffRoadTires/BattleRoyale/CH2S6
      (/Fortnite.com/Items/VehicleModOffRoadTires/BattleRoyale:)CH2S6<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        VehicleModOffRoadTires_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/VeiledPrecisionSMG
  VeiledPrecisionSMG<public> := module {
    # Module import path: /Fortnite.com/Items/VeiledPrecisionSMG/Ballistic
    (/Fortnite.com/Items/VeiledPrecisionSMG:)Ballistic<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      (/Fortnite.com/Items/VeiledPrecisionSMG/Ballistic:)VeiledPrecisionSMG_Common<public> := class<final><concrete>(entity) {}
    }

    # Module import path: /Fortnite.com/Items/VeiledPrecisionSMG/BattleRoyale
    (/Fortnite.com/Items/VeiledPrecisionSMG:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/VeiledPrecisionSMG/BattleRoyale/CH6S1
      (/Fortnite.com/Items/VeiledPrecisionSMG/BattleRoyale:)CH6S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        NightRoseVeiledPrecisionSMG_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        (/Fortnite.com/Items/VeiledPrecisionSMG/BattleRoyale/CH6S1:)VeiledPrecisionSMG_Common<public> := class<final><concrete>(entity) {}

        @experimental
        VeiledPrecisionSMG_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        VeiledPrecisionSMG_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        VeiledPrecisionSMG_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        VeiledPrecisionSMG_Uncommon<public> := class<final><concrete>(entity) {}
      }

      # Module import path: /Fortnite.com/Items/VeiledPrecisionSMG/BattleRoyale/CH6S4
      (/Fortnite.com/Items/VeiledPrecisionSMG/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EradicatorShadowPrecisionSMG_Exotic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/VendettaFlopper
  VendettaFlopper<public> := module {
    # Module import path: /Fortnite.com/Items/VendettaFlopper/BattleRoyale
    (/Fortnite.com/Items/VendettaFlopper:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/VendettaFlopper/BattleRoyale/CH2S4
      (/Fortnite.com/Items/VendettaFlopper/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        VendettaFlopper_Legendary<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/VengefulSniperRifle
  VengefulSniperRifle<public> := module {
    # Module import path: /Fortnite.com/Items/VengefulSniperRifle/BattleRoyale
    (/Fortnite.com/Items/VengefulSniperRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/VengefulSniperRifle/BattleRoyale/CH7S1
      (/Fortnite.com/Items/VengefulSniperRifle/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        VengefulSniperRifle_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        VengefulSniperRifle_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        VengefulSniperRifle_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        VengefulSniperRifle_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/VoidOniMask
  VoidOniMask<public> := module {
    # Module import path: /Fortnite.com/Items/VoidOniMask/BattleRoyale
    (/Fortnite.com/Items/VoidOniMask:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/VoidOniMask/BattleRoyale/CH6S1
      (/Fortnite.com/Items/VoidOniMask/BattleRoyale:)CH6S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        NightRosesVoidOniMask_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        VoidOniMask_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/WallDynamo
  WallDynamo<public> := module {
    # Module import path: /Fortnite.com/Items/WallDynamo/BattleRoyale
    (/Fortnite.com/Items/WallDynamo:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/WallDynamo/BattleRoyale/CH4MS1
      (/Fortnite.com/Items/WallDynamo/BattleRoyale:)CH4MS1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        WallDynamo_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/WarforgedAssaultRifle
  WarforgedAssaultRifle<public> := module {
    # Module import path: /Fortnite.com/Items/WarforgedAssaultRifle/BattleRoyale
    (/Fortnite.com/Items/WarforgedAssaultRifle:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/WarforgedAssaultRifle/BattleRoyale/CH5S2
      (/Fortnite.com/Items/WarforgedAssaultRifle/BattleRoyale:)CH5S2<public> := module {
        # Module import path: /Fortnite.com/Items/WarforgedAssaultRifle/BattleRoyale/CH5S2/Modular
        (/Fortnite.com/Items/WarforgedAssaultRifle/BattleRoyale/CH5S2:)Modular<public> := module {
          using { /Verse.org/SceneGraph }
          @experimental
          AresWarforgedAssaultRifle_Mythic<public> := class<final><concrete>(entity) {}

          @experimental
          WarforgedAssaultRifle_Common<public> := class<final><concrete>(entity) {}

          @experimental
          WarforgedAssaultRifle_Epic<public> := class<final><concrete>(entity) {}

          @experimental
          WarforgedAssaultRifle_Legendary<public> := class<final><concrete>(entity) {}

          @experimental
          WarforgedAssaultRifle_Rare<public> := class<final><concrete>(entity) {}

          @experimental
          WarforgedAssaultRifle_Uncommon<public> := class<final><concrete>(entity) {}
        }
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Wheat
  (/Fortnite.com/Items:)Wheat<public> := module {
    # Module import path: /Fortnite.com/Items/Wheat/Creative
    (/Fortnite.com/Items/Wheat:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Wheat_Common<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/WildwaspJar
  WildwaspJar<public> := module {
    # Module import path: /Fortnite.com/Items/WildwaspJar/BattleRoyale
    (/Fortnite.com/Items/WildwaspJar:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/WildwaspJar/BattleRoyale/CH4S3
      (/Fortnite.com/Items/WildwaspJar/BattleRoyale:)CH4S3<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        WildwaspJar_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/WingsOfIcarus
  WingsOfIcarus<public> := module {
    # Module import path: /Fortnite.com/Items/WingsOfIcarus/BattleRoyale
    (/Fortnite.com/Items/WingsOfIcarus:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/WingsOfIcarus/BattleRoyale/CH5S2
      (/Fortnite.com/Items/WingsOfIcarus/BattleRoyale:)CH5S2<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        WingsOfIcarus_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Wingsuit
  Wingsuit<public> := module {
    # Module import path: /Fortnite.com/Items/Wingsuit/BattleRoyale
    (/Fortnite.com/Items/Wingsuit:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Wingsuit/BattleRoyale/CH7S1
      (/Fortnite.com/Items/Wingsuit/BattleRoyale:)CH7S1<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Wingsuit_Epic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/WitchBroom
  WitchBroom<public> := module {
    # Module import path: /Fortnite.com/Items/WitchBroom/BattleRoyale
    (/Fortnite.com/Items/WitchBroom:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/WitchBroom/BattleRoyale/CH2S4
      (/Fortnite.com/Items/WitchBroom/BattleRoyale:)CH2S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        WitchBroom_Mythic<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/WolfTooth
  WolfTooth<public> := module {
    # Module import path: /Fortnite.com/Items/WolfTooth/Creative
    (/Fortnite.com/Items/WolfTooth:)Creative<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      WolfTooth_Uncommon<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/Wood
  Wood<public> := module {
    # Module import path: /Fortnite.com/Items/Wood/BattleRoyale
    (/Fortnite.com/Items/Wood:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/Wood/BattleRoyale/PreSeason
      (/Fortnite.com/Items/Wood/BattleRoyale:)PreSeason<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        Wood_Common<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/WoodStakeShotgun
  WoodStakeShotgun<public> := module {
    # Module import path: /Fortnite.com/Items/WoodStakeShotgun/BattleRoyale
    (/Fortnite.com/Items/WoodStakeShotgun:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/WoodStakeShotgun/BattleRoyale/CH4S4
      (/Fortnite.com/Items/WoodStakeShotgun/BattleRoyale:)CH4S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        HighStakesShotgun_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        WoodStakeShotgun_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        WoodStakeShotgun_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        WoodStakeShotgun_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/WreckerRevolver
  WreckerRevolver<public> := module {
    # Module import path: /Fortnite.com/Items/WreckerRevolver/BattleRoyale
    (/Fortnite.com/Items/WreckerRevolver:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/WreckerRevolver/BattleRoyale/CH6S4
      (/Fortnite.com/Items/WreckerRevolver/BattleRoyale:)CH6S4<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        EnhancedWreckerRevolver_Mythic<public> := class<final><concrete>(entity) {}

        @experimental
        EradicatorMarksmanWreckerRevolver_Exotic<public> := class<final><concrete>(entity) {}

        @experimental
        WreckerRevolver_Common<public> := class<final><concrete>(entity) {}

        @experimental
        WreckerRevolver_Epic<public> := class<final><concrete>(entity) {}

        @experimental
        WreckerRevolver_Legendary<public> := class<final><concrete>(entity) {}

        @experimental
        WreckerRevolver_Rare<public> := class<final><concrete>(entity) {}

        @experimental
        WreckerRevolver_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/Zapotron
  Zapotron<public> := module {
    # Module import path: /Fortnite.com/Items/Zapotron/OG
    (/Fortnite.com/Items/Zapotron:)OG<public> := module {
      using { /Verse.org/SceneGraph }
      @experimental
      Zapotron_Legendary<public> := class<final><concrete>(entity) {}
    }
  }

  # Module import path: /Fortnite.com/Items/ZeroPointFish
  ZeroPointFish<public> := module {
    # Module import path: /Fortnite.com/Items/ZeroPointFish/BattleRoyale
    (/Fortnite.com/Items/ZeroPointFish:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ZeroPointFish/BattleRoyale/CH2S5
      (/Fortnite.com/Items/ZeroPointFish/BattleRoyale:)CH2S5<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ZeroPointFish_Rare<public> := class<final><concrete>(entity) {}
      }
    }
  }

  # Module import path: /Fortnite.com/Items/ZeroPointPretzel
  ZeroPointPretzel<public> := module {
    # Module import path: /Fortnite.com/Items/ZeroPointPretzel/BattleRoyale
    (/Fortnite.com/Items/ZeroPointPretzel:)BattleRoyale<public> := module {
      # Module import path: /Fortnite.com/Items/ZeroPointPretzel/BattleRoyale/CH2S8
      (/Fortnite.com/Items/ZeroPointPretzel/BattleRoyale:)CH2S8<public> := module {
        using { /Verse.org/SceneGraph }
        @experimental
        ZeroPointPretzel_Uncommon<public> := class<final><concrete>(entity) {}
      }
    }
  }
}

Marketplace<public> := module {
  # Displays the Epic purchase UI to the player to purchase the `Offer`.
  # Returns true if an offer was purchased.
  BuyOffer<native><public>(Player: player, Offer: offer)<suspends>: logic

  @available { MinUploadedAtFNVersion := 3800 }
  # Consumes a consumable `entitlement`.
  # Fails if:
  #  * The `entitlement` is not consumable.
  #  * The `Player` does not own requested `Count` of `entitlement`.
  ConsumeEntitlement<native><public>(
    Player: player,
    entitlement_type: concrete_subtype(entitlement),
    ?Count: int = external {}
  )<suspends>: logic

  # Used to listen for entitlement change events during a game session.
  # Runtime error if `entitlement` is used directly.
  GetEntitlementsChangedEvent<native><public>(
    Player: player,
    entitlement_type: subtype(entitlement)
  ): listenable(tuple(player, []entitlement_change(entitlement_type)))

  GetPriceVBucks<native><public>(P: price_vbucks): float

  # Get all available `entitlement`s for `Player`, along with the number of those `entitlement`s.
  # This includes finding `entitlement`s of derived types.
  # Calling GetPurchasedEntitlements(Player, entitlement) will suspend forever.
  GetPurchasedEntitlements<native><public>(
    Player: player,
    entitlement_type: subtype(entitlement)
  )<suspends>: []tuple(entitlement_type, int)

  @available { MinUploadedAtFNVersion := 3800 }
  # Grant an entitlement directly to `Player`.
  # This function does not gate granting entitlements based on EntitlementDisclosures.
  # Entitlements are always granted assuming they match the MaxCount requirement.
  GrantEntitlement<native><public>(
    Player: player,
    entitlement_type: concrete_subtype(entitlement),
    ?Count: int = external {}
  )<suspends>: logic

  MakePriceVBucks<native><public>(Amount: float)<converges>: price_vbucks

  # Informs if usage of direct prompts to purchase is restricted for `Player`.
  RestrictDirectPromptsToPurchase<native><public>(Player: player)<reads><decides>: void

  # Informs if usage of paid random items is restricted for `Player`
  # due to platform, territory, age, or user configuration restrictions.
  RestrictPaidRandomItems<native><public>(Player: player)<reads><decides>: void

  # Shows the Epic provided store front contain the specified `Offers`.
  ShowOffersDialog<native><public>(Player: player, Offers: []offer, ?Title: message = external {})<suspends>: void

  # A `bundle_offer` allows you to bundle multiple other `offer`s into a single purchasable `offer`.
  bundle_offer<native><public> := class<castable>(offer) {
    Offers<native><public>: []tuple(offer, int) = external {}
  }

  # An entitlement that is tracked by the commerce system.
  #
  #  * A player may only have one `entitlement` if the entitlement is not consumable.
  #  * A player may have `MaxCount` of a consumable entitlement.
  #  * Your derived type must be <concrete> to be used by the purchase system.
  #  * If the entitlement you are selling gives players a meaningful advantage in your island, you must set ConsequentialToGameplay to true.
  entitlement<native><public> := class<castable>(has_icon, has_description) {
    ConsequentialToGameplay<native><public>: logic = external {}

    Consumable<native><public>: logic = external {}

    MaxCount<native><public>: int = external {}

    PaidArea<native><public>: logic = external {}

    PaidRandomItem<native><public>: logic = external {}
  }

  # Entitlements that have changed in quantity.
  # This will also include entitlement changes triggered by moderation, refunds and other commerce operations.
  entitlement_change<native><public>(t: type) := class<internal> {
    # Change to the original quantity of entitlement.
    Change<native><public>: int

    # Entitlement that has changed in quantity.
    Entitlement<native><public>: t

    (/Fortnite.com/Marketplace/entitlement_change:)Marketplace_entitlement_change_Variance<private>(): tuple(t) = external {}

    # Total quantity of the entitlement now owned.
    Quantity<native><public>: int
  }

  # An `entitlement_offer` allows an individual `entitlement` to be purchased.
  entitlement_offer<native><public> := class<castable>(offer) {
    @available { MinUploadedAtFNVersion := 3800 }
    @editable
    EntitlementType<native><public>: concrete_subtype(entitlement)
  }

  # Offers are used to sell entitlements to players. See `entitlement_offer` and `bundle_offer` classes for more information.
  offer<native><public> := class<abstract><castable><internal>(has_icon, has_description) {
    # Override this method to restrict availability of an offer in certain regions and minimum ages.
    #
    # Parameters:
    #     CountryCode: ISO-3166-1 A-2 code for the country, dependent territories, or special
    #                  area of geographical interest
    #     SubdivisionCode: ISO-3166-2 code (excluding Country Code portion) for the subdivision
    #                  within a country, dependent territory, or special area of geographical interest.
    #                  If subdivision information is unavailable for players in a region SubdivisionCode
    #                  will be an empty string.
    #     PlatformFamily: Android, iOS, macOS, Nintendo, PlayStation, Windows, Xbox, Luna, GeForceNow
    #
    # Returns:
    #     Fails if sale of this offer should not be allowed in this (CountryCode, SubdivisionCode)
    #     Minimum age of purchase in this (CountryCode, SubdivisionCode).
    #     If minimum age is higher than the highest available age by region the offer will not be made
    GetMinPurchaseAge<native_callable><public>(
      CountryCode: string,
      SubdivisionCode: string,
      PlatformFamily: string
    )<computes><decides>: int = external {}

    @editable
    Price<native><public>: price_dimension
  }

  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  offer_interactable_component<native><public> := class(interactable_component) {
    CanInteract<native><native_callable><override>(Agent: agent)<reads><decides>: void

    InteractMessage<override>(Agent: agent)<reads><decides>: message = external {}

    OnBeginSimulation<override>(): void = external {}

    OnSucceed<protected>(Agent: agent): void = external {}

    @editable
    var Offer<public>: offer

    var SucceededEventHandle<public>: ?cancelable = external {}
  }

  using { /Verse.org/Assets }
  using { /Verse.org/Native }
  using { /Verse.org/Presentation }
  price_dimension<native><public> := class<computes><abstract><epic_internal> {}

  price_vbucks<native><public> := class<final><computes><internal>(price_dimension) {}
}

# Module import path: /Fortnite.com/Playspaces
Playspaces<public> := module {
  # Returns an associated `fort_playspace` for this entity.  * Fails if this entity is not in the scene, and therefore not associated with a playspace.
  (InEntity: entity).GetPlayspaceForEntity<native><public>()<transacts><decides>: fort_playspace

  using { /Fortnite.com/Teams }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  # A nested container that scopes objects, style, gameplay rules, visuals, etc. All objects and players in an experience will belong to a fort_playspace. There is typically one `fort_playspace` for an entire experience, though this may change in the future as the platform evolves.
  #
  # To access the `fort_playspace` for a `creative_device` use `creative_device.GetPlayspace`.
  fort_playspace<native><public> := interface<epic_internal> {
    # Get all `agent`s that are participating in the current `fort_playspace` experience. Participants might be human players (of `player` type) or AI-controlled characters (of `agent` type) that are registered and affecting the participant's count.
    GetParticipants<public>()<transacts>: []agent

    # Get all human `player`s that are in the current `fort_playspace`.
    GetPlayers<public>()<transacts>: []player

    # Get the `fort_team_collection` for the current `fort_playspace`.
    GetTeamCollection<public>()<transacts>: fort_team_collection

    # Signaled when a participant `agent` joins the `fort_playspace`. Returns a subscribable with a payload of the`agent` that entered the `fort_playspace`.
    ParticipantAddedEvent<public>(): listenable(agent)

    # Signaled when a participant `agent` leaves the `fort_playspace`. Returns a subscribable with a payload of the`agent` that left the `fort_playspace`.
    ParticipantRemovedEvent<public>(): listenable(agent)

    # Signaled when a human `player` joins the `fort_playspace`. Returns a subscribable with a payload of the`player` that entered the `fort_playspace`.
    PlayerAddedEvent<public>(): listenable(player)

    # Signaled when a human `player` leaves the `fort_playspace`. Returns a subscribable with a payload of the`player` that left the `fort_playspace`.
    PlayerRemovedEvent<public>(): listenable(player)
  }
}

StarWars<public> := module {
  @experimental
  # Represents an item that gives its holder the Force Awareness power.
  force_power_awareness_component<native><public> := class<epic_internal>(force_power_item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}

    var Cooldown<public>: float = external {}

    var Duration<public>: float = external {}
  }

  @experimental
  # Represents an item that gives its holder the Force Distraction power.
  force_power_distraction_component<native><public> := class<epic_internal>(force_power_item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}

    var Duration<public>: float = external {}

    var Health<public>: float = external {}
  }

  @experimental
  # Represents an item that gives its holder the Force Heal power.
  force_power_heal_component<native><public> := class<epic_internal>(force_power_item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}

    var Cooldown<public>: float = external {}

    var DrainRate<public>: float = external {}

    var HealStrength<public>: float = external {}

    var RechargeDelay<public>: float = external {}

    var RechargeRate<public>: float = external {}
  }

  using { /UnrealEngine.com/Itemization }
  using { /Verse.org/Colors }
  using { /Verse.org/SceneGraph }
  @experimental
  force_power_item_component<native><public> := class<abstract><epic_internal>(item_component) {}

  @experimental
  # Represents an item that gives its holder the Force Lightning power.
  force_power_lightning_component<native><public> := class<epic_internal>(force_power_item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}

    var BuildingDamage<public>: float = external {}

    var Cooldown<public>: float = external {}

    var Damage<public>: float = external {}

    var Duration<public>: float = external {}
  }

  @experimental
  # Represents an item that gives its holder the Force Pull power.
  force_power_pull_component<native><public> := class<epic_internal>(force_power_item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}

    var Cooldown<public>: float = external {}
  }

  @experimental
  # Represents an item that gives its holder the Force Push power.
  force_power_push_component<native><public> := class<epic_internal>(force_power_item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}

    var Cooldown<public>: float = external {}

    var PushForce<public>: float = external {}
  }

  @experimental
  # Represents an item that gives its holder the Force Saber Throw power.
  force_power_saber_throw_component<native><public> := class<epic_internal>(force_power_item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}

    var BuildingDamage<public>: float = external {}

    var Cooldown<public>: float = external {}

    var Damage<public>: float = external {}
  }

  @experimental
  # Represents an item that gives its holder the Force Shield power.
  force_power_shield_component<native><public> := class<epic_internal>(force_power_item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}

    var Cooldown<public>: float = external {}

    var DrainRate<public>: float = external {}

    var Energy<public>: float = external {}

    var KnockbackForce<public>: float = external {}

    var RechargeDelay<public>: float = external {}

    var RechargeRate<public>: float = external {}
  }

  @experimental
  # Represents an item that gives its holder the Force Throw power.
  force_power_throw_component<native><public> := class<epic_internal>(force_power_item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}

    var BuildingDamage<public>: float = external {}

    var Cooldown<public>: float = external {}

    var Damage<public>: float = external {}
  }

  @experimental
  # Represents an item that gives its holder the Force Training power (Jump and Sprint).
  force_power_training_component<native><public> := class<epic_internal>(force_power_item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}

    var JumpStaminaCost<public>: float = external {}

    var StaminaCost<public>: float = external {}
  }

  @experimental
  # Represents an item that gives its holder the Force Mind Trick power.
  force_power_trick_component<native><public> := class<epic_internal>(force_power_item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}

    var Cooldown<public>: float = external {}

    var Duration<public>: float = external {}
  }

  @experimental
  kyber_crystal_blue_component<public> := class(kyber_crystal_component) {}

  @experimental
  kyber_crystal_component<native><public> := class<abstract><final_super><internal>(component) {
    var ArcIntensity<public>: float = external {}

    var Stability<public>: float = external {}

    var<private> Color<public>: color = external {}

    var<private> EmissiveIntensity<public>: float = external {}
  }

  @experimental
  kyber_crystal_green_component<public> := class(kyber_crystal_component) {}

  @experimental
  kyber_crystal_orange_component<public> := class(kyber_crystal_component) {}

  @experimental
  kyber_crystal_purple_component<public> := class(kyber_crystal_component) {}

  @experimental
  kyber_crystal_red_component<public> := class(kyber_crystal_component) {}

  @experimental
  kyber_crystal_red_damaged_component<public> := class(kyber_crystal_red_component) {}

  @experimental
  kyber_crystal_red_unstable_component<public> := class(kyber_crystal_red_component) {}

  @experimental
  kyber_crystal_white_component<public> := class(kyber_crystal_component) {}

  @experimental
  kyber_crystal_yellow_component<public> := class(kyber_crystal_component) {}

  @experimental
  lightsaber_item_component<native><public> := class<abstract><epic_internal>(item_component) {}

  @experimental
  lightsaber_item_crossguard<native><public> := class<abstract><epic_internal>(lightsaber_item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}
  }

  @experimental
  lightsaber_item_jedi_padawan_a<public> := class<final><epic_internal>(lightsaber_item_single) {}

  @experimental
  lightsaber_item_jedi_padawan_b<public> := class<final><epic_internal>(lightsaber_item_single) {}

  @experimental
  lightsaber_item_jedi_training<public> := class<final><epic_internal>(lightsaber_item_single) {}

  @experimental
  lightsaber_item_kenobi<public> := class<final><epic_internal>(lightsaber_item_single) {}

  @experimental
  lightsaber_item_ren<public> := class<final><epic_internal>(lightsaber_item_crossguard) {}

  @experimental
  lightsaber_item_rey<public> := class<final><epic_internal>(lightsaber_item_single) {}

  @experimental
  lightsaber_item_single<native><public> := class<abstract><epic_internal>(lightsaber_item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}
  }

  @experimental
  lightsaber_item_sith_apprentice<public> := class<final><epic_internal>(lightsaber_item_single) {}

  @experimental
  lightsaber_item_skywalker<public> := class<final><epic_internal>(lightsaber_item_single) {}

  @experimental
  lightsaber_item_vader<public> := class<final><epic_internal>(lightsaber_item_single) {}

  @experimental
  lightsaber_item_windu<public> := class<final><epic_internal>(lightsaber_item_single) {}
}

# Module import path: /Fortnite.com/Teams
Teams<public> := module {
  # Collection used to manage `team`s and `agent`s on those teams.
  # Use `fort_playspace.GetTeamCollection()` to get the `team_collection` for the active experience.
  fort_team_collection<native><public> := interface<epic_internal> {
    # Adds `InAgent` to `InTeam`.
    # Fails if `InTeam` is not part of the `fort_team_collection`.
    AddToTeam<public>(InAgent: agent, InTeam: team)<transacts><decides>: void

    # Returns an array of all `agent`s on `InTeam`.
    # Fails if `InTeam` is not part of the `fort_team_collection`.
    GetAgents<public>(InTeam: team)<transacts><decides>: []agent

    # Get the `team` that `InAgent` is on.
    # Fails if `InAgent` is not on a team in this `fort_team_collection`.
    GetTeam<public>(InAgent: agent)<transacts><decides>: team

    # Returns the `team_attitude` between `Agent1` and `Agent2`.
    # Fails if:
    #  * `Agent1` is not on a team in this `fort_team_collection`.
    #  * `Agent2` is not on a team in this `fort_team_collection`.
    GetTeamAttitude<public>(Agent1: agent, Agent2: agent)<transacts><decides>: team_attitude

    # Returns the `team_attitude` between `Team1` and `Team2`.
    # Fails if:
    #  * `Team1` is not in this `fort_team_collection`.
    #  * `Team2` is not in this `fort_team_collection`.
    GetTeamAttitude<public>(Team1: team, Team2: team)<transacts><decides>: team_attitude

    # Returns an array of all the `team`s known to this `fort_team_collection`
    GetTeams<public>()<transacts>: []team

    # Succeeds if `InAgent` is on `InTeam`.
    # Fails if:
    #  * `InAgent` is not on `InTeam`.
    #  * `InTeam` is not part of the `fort_team_collection`.
    IsOnTeam<public>(InAgent: agent, InTeam: team)<transacts><decides>: void
  }

  using { /Verse.org/Simulation }
  # A generic set of team attitudes. Use this enum to model relationship behavior between your experience's agents/teams.
  team_attitude<native><public> := enum {
    # Agents/teams are friends. In Fortnite games two `agent`s on the same `team` are `friendly`.
    Friendly

    # Agents/teams are hostile. In fortnite games two `agent`s on opposing `team`s are `hostile`.
    Hostile

    # Agents/teams are neutral. In Fortnite games items and AI not belonging to a `friendly` or `hostile` team are `neutral`.
    Neutral
  }
}

# Module import path: /Fortnite.com/UI
(/Fortnite.com:)UI<public> := module {
  @deprecated
  # Deprecated. This function affects all players. Please use `fort_playspace.GetHUDController().HideElements()`.
  # Hides a set of HUD elements.
  (PlayerUI: player_ui).HideHUDElements<native><public>(HUDElements: []hud_element_identifier): void

  @deprecated
  # Deprecated. This function affects all players. Please use `fort_playspace.GetHUDController().ResetElementVisibility()`.
  # Resets the visibility for a set of HUD elements.
  (PlayerUI: player_ui).ResetHUDElementVisibility<native><public>(HUDElements: []hud_element_identifier): void

  @deprecated
  # Deprecated. This function affects all players. Please use `fort_playspace.GetHUDController().ShowElements()`.
  # Shows a set of HUD elements.
  (PlayerUI: player_ui).ShowHUDElements<native><public>(HUDElements: []hud_element_identifier): void

  # Get the `fort_hud_controller` for the current `fort_playspace`.
  (Playspace: fort_playspace).GetHUDController<native><public>(): fort_hud_controller

  # Text button with big and loud styling applied.
  button_loud<native><public> := class<final>(text_button_base) {}

  # Text button with quiet styling applied.
  button_quiet<native><public> := class<final>(text_button_base) {}

  # Text button with normal styling applied.
  button_regular<native><public> := class<final>(text_button_base) {}

  creative_hud_identifier_all<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_build_menu<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_crafting_resources<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_elimination_counter<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_equipped_item<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_experience_level<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_experience_supercharged<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_experience_ui<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_health<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_health_numbers<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_hud_info<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_interaction_prompts<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_map_prompts<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_mimimap<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_minimap<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_pickup_stream<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_player_count<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_player_inventory<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_round_info<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_round_timer<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_shield_numbers<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_shields<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_shileds<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_storm_notifications<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_storm_timer<public> := class<final>(hud_element_identifier) {}

  creative_hud_identifier_team_info<public> := class<final>(hud_element_identifier) {}

  # A HUD controller that allows for showing and hiding of HUD elements.
  fort_hud_controller<native><public> := interface<epic_internal> {
    # Hides a set of HUD elements for every player. Note: This can be overridden by rules set by 'ForPlayer' functions since player specific rules are prioritized over general rules.
    HideElements<public>(HUDElements: []hud_element_identifier): void

    # Hides a set of HUD elements for a single player. Note: This overrides general rules set by non-player functions for the given elements. Call 'ResetElementsForPlayer' in order to return the player to general behavior
    HideElementsForPlayer<public>(Player: player, HUDElements: []hud_element_identifier): void

    # Resets the visibility for a set of HUD elements for every player. Note: This will not clear player specific rules set by the 'ForPlayer' functions which can only be reset by calling 'ResetElementsForPlayer'.
    ResetElementVisibility<public>(HUDElements: []hud_element_identifier): void

    # Resets the player-specific visibility rules of a set of HUD elements for a single player. Note: This will not reset rules that have been set by means other than the 'PerPlayer' functions.
    ResetElementsForPlayer<public>(Player: player, HUDElements: []hud_element_identifier): void

    # Shows a set of HUD elements for every player. Note: This can be overridden by rules set by 'ForPlayer' functions since player specific rules are prioritized over general rules.
    ShowElements<public>(HUDElements: []hud_element_identifier): void

    # Shows a set of HUD elements for a single player. Note: This overrides general rules set by non-player functions for the given elements. Call 'ResetElementsForPlayer' in order to return the player to general behavior
    ShowElementsForPlayer<public>(Player: player, HUDElements: []hud_element_identifier): void
  }

  # Used to identify a HUD element.
  hud_element_identifier<native><public> := class<abstract><epic_internal> {}

  hud_identifier_visual_sound_effect_all<public> := class<final>(hud_element_identifier) {}

  hud_identifier_visual_sound_effect_healing<public> := class<final>(hud_element_identifier) {}

  hud_identifier_visual_sound_effect_loot<public> := class<final>(hud_element_identifier) {}

  hud_identifier_visual_sound_effect_movement<public> := class<final>(hud_element_identifier) {}

  hud_identifier_visual_sound_effect_vehicle<public> := class<final>(hud_element_identifier) {}

  hud_identifier_visual_sound_effect_weapons<public> := class<final>(hud_element_identifier) {}

  hud_identifier_world_resource_gold_currency<public> := class<final>(hud_element_identifier) {}

  hud_identifier_world_resource_ingredient<public> := class<final>(hud_element_identifier) {}

  hud_identifier_world_resource_metal<public> := class<final>(hud_element_identifier) {}

  hud_identifier_world_resource_permanite<public> := class<final>(hud_element_identifier) {}

  hud_identifier_world_resource_stone<public> := class<final>(hud_element_identifier) {}

  hud_identifier_world_resource_wood<public> := class<final>(hud_element_identifier) {}

  player_hud_identifier_all<public> := class<final>(hud_element_identifier) {}

  # Slider with a text value. Displays a slider, its progress bar and value.
  slider_regular<native><public> := class<final>((/UnrealEngine.com/Temporary/UI:)widget) {
    # The maximum value that the slider can haver. Used only during initialization of the widget and not modified by SetMaxValue.
    DefaultMaxValue<native><public>: float = external {}

    # The minimum value that the slider can haver. Used only during initialization of the widget and not modified by SetMinValue.
    DefaultMinValue<native><public>: float = external {}

    # The amount to adjust the value by, when using a controller or keyboard. Used only during initialization of the widget and not modified by SetStepSize.
    DefaultStepSize<native><public>: float = external {}

    # The value to display to the user. Used only during initialization of the widget and not modified by SetValue.
    DefaultValue<native><public>: float = external {}

    # Gets the maximum value of the slider.
    GetMaxValue<native><public>(): float

    # Gets the minimum value of the slider.
    GetMinValue<native><public>(): float

    # Gets the amount to adjust the value by.
    GetStepSize<native><public>(): float

    # Gets the value of the slider.
    GetValue<native><public>(): float

    # Subscribable event that fires when the value of the slider has changed.
    OnValueChanged<public>(): listenable(widget_message) = external {}

    # Sets the maximum value of the slider, will enforce that the sliders maximum value is always larger than or equal to the minimum value.
    SetMaxValue<native><public>(InMaxValue: float): void

    # Sets the minimum value of the slider, will enforce that the sliders maximum value is always larger than or equal to the minimum value.
    SetMinValue<native><public>(InMinValue: float): void

    # Sets the amount to adjust the value by, when using a controller or keyboard.
    SetStepSize<native><public>(InValue: float): void

    # Sets the value of the slider, will clamp the value to be within the sliders minimum and maximum value.
    SetValue<native><public>(InValue: float): void
  }

  # Text block widget. Displays text to the user.
  text_block<native><public> := class<final>(text_base) {
    # The color of the shadow. Used only during initialization of the widget and not modified by SetShadowColor.
    DefaultShadowColor<native><public>: color = external {}

    # The direction the shadow is cast. Used only during initialization of the widget and not modified by SetShadowOffset.
    DefaultShadowOffset<native><public>: ?vector2 = external {}

    # The opacity of the shadow. Used only during initialization of the widget and not modified by SetShadowOpacity.
    DefaultShadowOpacity<native><public>: type { _X: float where 0.000000 <= _X, _X <= 1.000000 } = external {}

    # Gets the color of the shadow.
    GetShadowColor<native><public>(): color

    # Gets the direction the shadow is cast.
    GetShadowOffset<native><public>(): ?vector2

    # Gets the opacity of the shadow.
    GetShadowOpacity<native><public>(): type { _X: float where 0.000000 <= _X, _X <= 1.000000 }

    # Sets the color of the shadow.
    SetShadowColor<native><public>(InColor: color): void

    # Sets the direction the shadow is cast.
    SetShadowOffset<native><public>(InShadowOffset: ?vector2): void

    # Sets the opacity of the shadow.
    SetShadowOpacity<native><public>(InOpacity: type { _X: float where 0.000000 <= _X, _X <= 1.000000 }): void
  }

  using { /Fortnite.com/Playspaces }
  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /UnrealEngine.com/Temporary/UI }
  using { /Verse.org/Assets }
  using { /Verse.org/Colors }
  using { /Verse.org/Simulation }
  # Button with text message common base class. Displays a button with a custom message string.
  text_button_base<native><public> := class<abstract><epic_internal>((/UnrealEngine.com/Temporary/UI:)widget) {
    # The text to display to the user. Used only during initialization of the widget and not modified by SetText.
    DefaultText<localizes><native><public>: message = external {}

    # Gets the text currently in the widget.
    GetText<native><public>(): string

    # Subscribable event that fires when the button is clicked.
    OnClick<public>(): listenable(widget_message) = external {}

    # Sets the text displayed in the widget.
    SetText<native><public>(InText: message): void

    # The UI input action that will trigger the Click event of this button.
    var TriggeringInputAction<public>: ?input_action(logic) = external {}
  }
}

# Module import path: /Fortnite.com/Vehicles
Vehicles<public> := module {
  using { /Fortnite.com/Characters }
  using { /Fortnite.com/Game }
  using { /UnrealEngine.com/Temporary/SpatialMath }
  # Returns the `fort_vehicle` for `InCharacter`.
  # Fails if `InCharacter` is not associated with a `fort_vehicle`.
  (InCharacter: fort_character).GetVehicle<native><public>()<transacts><decides>: fort_vehicle

  # Main API implemented by Fortnite vehicles.
  fort_vehicle<native><public> := interface<unique><epic_internal>(positional, healthful, damageable, game_action_causer) {
    # Returns the maximum fuel capacity of the vehicle. If the vehicle uses fuel, this value will be between 1.0 and Inf. Otherwise, this value will be -1.0.
    GetFuelCapacity<public>()<transacts>: float

    # Returns the fuel state of the vehicle. If the vehicle uses fuel, this value will be between 0.0 and `GetFuelCapacity`. Otherwise, this value will be -1.0.
    GetFuelRemaining<public>()<transacts>: float

    # Returns an array with all the passengers of the vehicle.
    GetPassengers<public>()<transacts>: []fort_character

    # Succeeds if this `fort_vehicle` is standing in air.
    IsInAir<public>()<transacts><decides>: void

    # Succeeds if this `fort_vehicle` is standing in water.
    IsInWater<public>()<transacts><decides>: void

    # Succeeds if this `fort_vehicle` is standing on ground.
    IsOnGround<public>()<transacts><decides>: void

    # Teleports the `fort_vehicle` to the specified `Position` and `Rotation`.
    TeleportTo<public>(
      Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<transacts><decides>: void

    # The maximum boost capacity of the vehicle. If the vehicle uses boost, this value will be between 1.0 and Inf. Otherwise, this value will be false.
    var<private> BoostCapacity<public>: ?float

    # The boost state of the vehicle. If the vehicle uses boost, this value will be between 0.0 and `BoostCapacity`. Otherwise, this value will be false.
    var<private> BoostRemaining<public>: ?float

    # The current speed of the vehicle in m/s.
    var<private> Speed<public>: float
  }
}