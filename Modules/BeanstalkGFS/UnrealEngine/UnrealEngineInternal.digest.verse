# Copyright Epic Games, Inc. All Rights Reserved.
#################################################
# Generated Digest of Verse API
# DO NOT modify this manually!
# Generated from build: ++Fortnite+Release-41.10-CL-55335788
#################################################

AINavigation<public> := module {
  @experimental
  # Finds and returns the path between this entity's location and the target location.
  (InEntity: entity).FindPath<native><epic_internal>(Destination: (/UnrealEngine.com/Temporary/SpatialMath:)vector3)<suspends>: navigation_path

  @experimental
  # Finds and returns the path between this entity's location and the target location, filtering the path using supplied Query
  (InEntity: entity).FindPath<native><epic_internal>(
    Destination: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
    Query: navigation_query
  )<suspends>: navigation_path

  # Result of a navigation request
  navigation_find_path_result<native><epic_internal> := enum {
    # The destination cannot be associated to the query's navigation_layer.
    DestinationNonNavigable

    # There is no path that connect the start and end location using the query parameters.
    DestinationUnreachable

    # The request contains invalid or missing data.
    InvalidRequest

    # Search limit was reached before a path could be found. The path leads to the closest location to the destination that the search had time to visit.
    PartialReachedLimit

    # The destination is unreachable. The path leads to the reachable location closest to the destination.
    PartialUnreachable

    # A valid navigation path was found.
    PathFound

    # The origin location cannot be associated to the query's navigation_layer.
    StartLocationNonNavigable
  }

  # Navigation layers are various representations of the world that can be used by agents of different shapes and abilities
  navigation_layer<native><epic_internal> := class<abstract>(asset) {}

  # Use the most granular air field available
  navigation_layer_air_auto<native><epic_internal> := class<concrete><final>(navigation_layer) {}

  # Auto select a ground layer based on the user's collision component
  navigation_layer_ground_auto<native><epic_internal> := class<concrete><final>(navigation_layer) {}

  # Contains the resulting path and status from a find path query.
  navigation_path<native><epic_internal> := class<final><epic_internal> {
    # Returns the points that form the path. Fails if the path is invalid.
    GetPathPoints<native><public>()<transacts><decides>: []navigation_path_point

    # Whether this path completed successfully or encountered a problem.
    Result<native><public>: navigation_find_path_result
  }

  # Describes the location and characteristics of a point along a navigation path.
  navigation_path_point<native><epic_internal> := struct<concrete> {
    @editable
    # Position of the point in the world.
    Location<native><public>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}
  }

  @import_as("/Script/AINavigation.UCompositeNavigationQuery")
  # Defines the parameters of a navigation query such as finding a path or projecting a point.
  navigation_query<native><epic_internal> := class<concrete><final> {}

  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /Verse.org/Assets }
  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  @experimental
  @hide_in_editor
  # This class adds the navigation system to the world simulation entity.
  # This class adds the navigation system to the world simulation entity.
  navigation_system_component<native><epic_internal> := class<final_super>(component) {}

  @experimental
  # Component that describes the navigation preferences of this entity and offers helpers to find paths using those preferences.
  navigation_user_component<native><epic_internal> := class<final><final_super>(component) {
    @editable
    # Default navigation query parameters for this entity.
    DefaultNavigationQuery<native><public>: navigation_query

    OnAddedToScene<native><override>(): void

    OnRemovingFromScene<native><override>(): void
  }
}

Abilities<public> := module {
  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Lives in the scene graph and is the high level description of an ability.
  #  Knows if an ability can run, cooldowns, distance and targeting requirements etc...
  ability<native><epic_internal>(
    context_type: subtype(ability_context),
    ability_effect_type: subtype(ability_effect)
  ) := class<abstract>(has_icon) {
    (/UnrealEngine.com/Abilities/ability:)Abilities_ability_Variance<private>(
      : context_type,
      : ability_effect_type,
      : context_type,
      : context_type
    ): tuple(ability_effect_type, context_type, ability_effect_type) = external {}

    BeginUseEvent<native><public>: listenable(entity) = external {}

    CanUse<epic_internal>(AbilityEffectParent: entity, AbilityContext: context_type)<reads><decides>: void = external {}

    EndUseEvent<native><public>: listenable(entity) = external {}

    MakeAbility<epic_internal>()<transacts>: ability_effect_type

    MakeContext<epic_internal>()<transacts>: context_type

    Use<final><public>(AbilityEffectParent: entity, AbilityContext: context_type): ?ability_effect_type = external {}

    var (/UnrealEngine.com/Abilities/ability:)Abilities_ability_VarVariance<private>: ?tuple(ability_effect_type) = external {}

    var<private> ActiveEffects<native><public>: []ability_effect_type
  }

  using { /Verse.org/Assets }
  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Data passed on activation of an ability. Holds who fired, who helped, and what got hit.
  #  Subclass to provide specific context for custom ability effects
  ability_context<native><public> := class<concrete> {
    var Instigator<native><public>: ?agent = external {}

    var Participants<native><public>: []entity = external {}

    var Targets<native><public>: []entity = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Prefab to provide a central location for handling desired ability and gameplay logic.
  ability_effect<native><epic_internal> := class<concrete>(entity) {}

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Guaranteed Ability component on Ability prefab entities. Handles Ability lifecycle.
  ability_effect_component<native><epic_internal> := class<final_super>(component) {
    CanCancel<native_callable><protected>(Reason: cancel_reason)<transacts><decides>: void = external {}

    Cancel<final><public>(Reason: cancel_reason)<transacts><decides>: void = external {}

    EndUse<final><protected>()<transacts>: void = external {}

    OnBeginUse<native_callable><protected>()<transacts>: void = external {}

    OnEndUse<native><protected>(Reason: ?cancel_reason)<transacts>: void

    var<protected> Ability<native><public>: ?ability(ability_context, ability_effect) = external {}

    var<protected> Context<native><public>: ?ability_context = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  ability_ended<public> := class<castable>(cancel_reason) {}

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Lightweight tag explaining why an effect ended.
  cancel_reason<native><public> := class<abstract><castable> {}
}

# Module import path: /UnrealEngine.com/Assets
(/UnrealEngine.com:)Assets<public> := module {
  PlaySound<native><epic_internal>(Asset: sound, ?StartDelay: float = external {})<transacts>: cancelable

  PlaySoundAtLocation<native><epic_internal>(
    Asset: sound,
    Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
    ?Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {},
    ?StartDelay: float = external {}
  )<transacts>: cancelable

  SpawnParticleSystem<native><public>(
    Asset: particle_system,
    Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
    ?Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {},
    ?StartDelay: float = external {}
  )<transacts>: cancelable

  SpawnParticleSystem<native><public>(
    Asset: particle_system,
    Position: (/Verse.org/SpatialMath:)vector3,
    ?Rotation: (/Verse.org/SpatialMath:)rotation = external {},
    ?StartDelay: float = external {}
  )<transacts>: cancelable

  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /Verse.org/Assets }
  using { /Verse.org/SpatialMath }
  play_sound_subscription<native><epic_internal> := class(cancelable) {
    Cancel<native><override>()<transacts>: void
  }

  spawn_particle_system_subscription<native><epic_internal> := class(cancelable) {
    Cancel<native><override>()<transacts>: void
  }
}

# Module import path: /UnrealEngine.com/BasicShapes
BasicShapes<public> := module {
  cone<public> := class<final><public>(mesh_component) {
    Mesh<override>: mesh = external {}
  }

  using { /Verse.org/Assets }
  using { /Verse.org/SceneGraph }
  cube<public> := class<final><public>(mesh_component) {
    Mesh<override>: mesh = external {}
  }

  cylinder<public> := class<final><public>(mesh_component) {
    Mesh<override>: mesh = external {}
  }

  plane<public> := class<final><public>(mesh_component) {
    Mesh<override>: mesh = external {}
  }

  sphere<public> := class<final><public>(mesh_component) {
    Mesh<override>: mesh = external {}
  }
}

# Module import path: /UnrealEngine.com/ControlInput
ControlInput<public> := module {
  @available { MinUploadedAtFNVersion := 3630 }
  # Access input-related data and settings for a player.
  (/UnrealEngine.com/ControlInput:)GetPlayerInput<native><public>(Player: player)<transacts><decides>: (/UnrealEngine.com/ControlInput:)player_input

  MakeInputAsset<native><epic_internal>((
    InputAction: input_action(t),
    Path: string
  ) where t: type)<converges>: input_action(t)

  @available { MinUploadedAtFNVersion := 3630 }
  @cpp_name("input_events_vni_alt")
  # Input_events is a container for user input events which can be subscribed to.
  #   * Use the 'GetPlayerInput' and 'GetInputEvents' functions to retrieve an input_events object for a given player.
  #   * Low-level notifications of current user input: DetectionBeginEvent, DetectionOngoingEvent, and DetectionEndEvent.
  #   * High-level notifications of triggered events: ActivationTriggeredEvent and ActivationCanceledEvent.
  #
  #                         /—----------<-------\
  #  DetectionBeginEvent -> DetectionOngoingEvent -> ActivationTriggeredEvent -> DetectionEndEvent
  #            /\                         /\                                            /
  #              \---------------------> ActivationCanceledEvent ----------------------/
  (/UnrealEngine.com/ControlInput:)input_events<native><public>(t: type) := class((/UnrealEngine.com/ControlInput:)input_events_base) {
    # This input has been canceled before activation. For example, if the key is released before a “Press and Hold” time threshold.
    #  Tuple payload: 0: the player generating this event
    #                 1: the value generated by the physical input
    #                 2: elapsed seconds since detection began
    ActivationCanceledEvent<native><public>: listenable(tuple(player, t, float)) = external {}

    # This input has met all required conditions and has successfully fired. Most of the time, you should bind to this event.
    #  Tuple payload: 0: the player generating this event
    #                 1: the value generated by the physical input
    ActivationTriggeredEvent<native><public>: listenable(tuple(player, t)) = external {}

    # Detection has started for this input e.g. a required key is now held down. Note: ActivationTriggeredEvent may also occur this frame,
    #  but this event will always be fired first. DetectionBegin and DetectionEnd will always fire, regardless of whether the input is
    #  successful or canceled.
    #  Tuple payload: 0: the player generating this event
    #                 1: the value generated by the physical input
    DetectionBeginEvent<native><public>: listenable(tuple(player, t)) = external {}

    # Detection has finished e.g. no required keys are now down. Will always fire as a pair with DetectionBegin.
    #  Tuple payload: 0: the player generating this event
    #                 1: elapsed seconds since detection began
    DetectionEndEvent<native><public>: listenable(tuple(player, float)) = external {}

    # Detection for this input is still being processed. For example, a time threshold may not be met.
    #  Tuple payload: 0: the player generating this event
    #                 1: the value generated by the physical input
    #                 2: elapsed seconds since detection began
    DetectionOngoingEvent<native><public>: listenable(tuple(player, t, float)) = external {}
  }

  using { /Verse.org/Assets }
  using { /Verse.org/Native }
  using { /Verse.org/Simulation }
  using { /Verse.org/SpatialMath }
  @import_as("/Script/VerseInput.UVerseInputEventsBase")
  (/UnrealEngine.com/ControlInput:)input_events_base<native><epic_internal> := class<abstract> {}

  @available { MinUploadedAtFNVersion := 3630 }
  @cpp_name("player_input_vni_alt")
  # This is the main manager class for input-related settings and functions for a player.
  (/UnrealEngine.com/ControlInput:)player_input<native><public> := class {
    AddInputMapping<native><public>(InputMapping: input_mapping): void

    GetInputEvents<native><public>(ActionToBind: input_action(t) where t: type): (/UnrealEngine.com/ControlInput:)input_events(t)

    MakeFloatInputEvents<native_callable><epic_internal>(): (/UnrealEngine.com/ControlInput:)input_events(float) = external {}

    MakeLogicInputEvents<native_callable><epic_internal>(): (/UnrealEngine.com/ControlInput:)input_events(logic) = external {}

    MakeVector3InputEvents<native_callable><epic_internal>(): (/UnrealEngine.com/ControlInput:)input_events((/Verse.org/SpatialMath:)vector3) = external {}

    RemoveInputMapping<native><public>(InputMapping: input_mapping): void
  }
}

Conversations<public> := module {
  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Removes any persona assignment for a participant.
  (Participant: agent).ClearConversationTargetForAgent<native><epic_internal>()<transacts>: void

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Returns the persona a participant is assigned to, fails if unassigned.
  (Participant: agent).GetConversationTargetForAgent<native><epic_internal>()<reads><decides>: conversation_target

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # A participant can only speak to one conversation target at a time.
  #  A conversation target can be spoken to by many participants at a time.
  #  Fails if the conversation target refuses the addition, or if the participant is assigned to a different conversation target.
  (Participant: agent).SetConversationTargetForAgent<native><epic_internal>(ConversationTarget: conversation_target)<transacts><decides>: void

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Sets the persona the player will attempt to prompt when they use the relevant hotkey.
  #  The persona must be in the voice channel with the player in order for the player to be able to successfully prompt.
  (Player: player where member_info: subtype(has_voice_member_info)).SetConversationTarget<native><public>(
    (local:)Persona: persona_component,
    Channel: voice_channel(member_info)
  )<transacts>: void

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Unbind player from prompting personas
  (Player: player).ClearConversationTarget<native><public>()<transacts>: void

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Retrieve the persona and channel the player is currently bound to prompt.
  (Player: player).GetConversationTarget<native><public>()<reads><decides>: tuple(
    persona_component,
    voice_channel(has_voice_member_info)
  )

  MakeLLMString<native_callable><epic_internal>(String: string): llm_string = external {}

  MakeLLMStringMessage<localizes><native_callable><epic_internal>(LLMString: llm_string): message = external {}

  (/UnrealEngine.com/Conversations:)MakeLocalizableValue<epic_internal>(V: llm_string): localizable_llm_string = external {}

  @available { MinUploadedAtFNVersion := 4000 }
  MakePersonaErrorResult<native_callable><epic_internal>(Result: error_type where error_type: type): result(
    false,
    error_type
  ) = external {}

  @available { MinUploadedAtFNVersion := 4000 }
  MakePersonaSuccessResult<native_callable><epic_internal>(Result: success_type where success_type: type): result(
    success_type,
    false
  ) = external {}

  ai_prompt_device<epic_internal> := class {}

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Narrator, Med, Warm
  alaina_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  alice_voice<final><epic_internal> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Whimsical, Med, Natural
  aria_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Cinematic, Med, Warm
  arthur_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  # A basic prompt for carrying out instructions
  basic_prompt<native><public> := class<final>(prompt) {
    # What the llm should do
    var Instructions<native><public>: message
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Tough, High, Warm
  brenna_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Comic, Med, Natural
  caleb_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Whimsical, Med, Warm
  chloe_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Cinematic, Med, Natural
  clara_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  conversation_target<native><epic_internal> := interface<unique><epic_internal> {
    # When agent targets Self for conversation.
    AddConversationTargeterEvent<final><public>: listenable(agent) = external {}

    # Allow player to to talk to this persona.
    AddPlayer<native_callable><epic_internal>(Player: agent)<transacts><decides>: void = external {}

    # Succeeds if the agent can target Self for conversation.
    CanConversationTargeterBeAdded<native_callable><epic_internal>(ConversationTargeter: agent)<reads><decides>: void = external {}

    # When agent untargets Self for conversation.
    RemoveConversationTargeterEvent<final><public>: listenable(agent) = external {}

    # Stop player from being able to talk to this persona.
    RemovePlayer<native_callable><epic_internal>(Player: agent)<transacts><decides>: void = external {}

    # Signals the AddConversationTargeterEvent.
    SignalAddConversationTargeterEvent<native_callable><epic_internal>(Agent: agent): void = external {}

    # Signals the RemoveConversationTargeterEvent.
    SignalRemoveConversationTargeterEvent<native_callable><epic_internal>(Agent: agent): void = external {}

    # All the agents currently targeting Self for conversation.
    var<private> ConversationTargeters<public>: []agent
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Comic, Med, Natural
  dante_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Whimsical, High, Warm
  ethan_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Comic, High, Natural
  felix_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Glamorous, Med, Natural
  graham_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Refined, Med, Natural
  grant_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Glamorous, Low, Natural
  helen_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @experimental
  internal_response_data<native><epic_internal> := struct {
    @llm_description("Use this to output the name of the targeted conversation participant")
    TargetAgent<native>: ?agent
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Refined, Med, Warm
  julienne_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Comic, High, Warm
  lily_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  llm_description<constructor><public>(Description: string)<computes>: llm_description_attribute = external {}

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  @attribscope_data
  @customattribhandler
  llm_description_attribute<public> := class<computes><internal>(attribute) {
    Description<public>: string
  }

  llm_fact<native><epic_internal> := class(cancelable) {
    Cancel<native><override>()<transacts>: void
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  llm_prompt_character_limit_error<native><public> := class(llm_prompt_error) {}

  using { /Fortnite.com/Devices }
  using { /Verse.org/Chat }
  using { /Verse.org/Colors }
  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  llm_prompt_error<native><public> := class {
    Message<native><public>: message
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  llm_prompt_moderated_error<native><public> := class(llm_prompt_error) {}

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  llm_prompt_throttled_error<native><public> := class(llm_prompt_error) {}

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  llm_prompt_timeout_error<native><public> := class(llm_prompt_error) {}

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # An abstraction around a recorded history of events and sending prompts with that history context included.
  llm_session<native><public> := class<unique> {
    CancelAllVoiceChannelSubscriptions<native_callable><epic_internal>()<transacts>: void = external {}

    # Removes all the history events from the session. Including conversation history.
    ClearHistory<native><public>()<transacts>: void

    OnAddMemberEvent<native><epic_internal>((
      Agent: agent,
      MemberInfo: member_info
    ) where member_info: subtype(has_voice_member_info))<transacts>: void

    OnLLMSessionConstructed<native><epic_internal>()<transacts>: void

    OnRemoveMemberEvent<native><epic_internal>((
      Agent: agent,
      MemberInfo: member_info
    ) where member_info: subtype(has_voice_member_info))<transacts>: void

    @available { MinUploadedAtFNVersion := 4100 }
    # The result will conform to the result type. The result type must be a struct which can contain.
    #  - numeric types, message, bools and enums, as well as structs or arrays which only contain those types, anything else results in an error.
    #  Use the names of the fields and name of the type of the struct to direct the prompt or facts on how to fill out the data structure.
    Prompt<native><public>((local:)Prompt: prompt, response_type: type)<suspends>: result(response_type, llm_prompt_error)

    SubscribeToVoiceChannelMemberAdded<native_callable><epic_internal>(VoiceChannel: voice_channel(member_info) where member_info: subtype(has_voice_member_info))<transacts>: cancelable = external {}

    SubscribeToVoiceChannelMemberRemoved<native_callable><epic_internal>(VoiceChannel: voice_channel(member_info) where member_info: subtype(has_voice_member_info))<transacts>: cancelable = external {}

    var VoiceChannelSubscriptions<epic_internal>: []cancelable = external {}
  }

  llm_string<native><epic_internal> := class {
    Value<native><epic_internal>: string
  }

  localizable_llm_string<native><epic_internal> := class(localizable_value) {
    Value<native><epic_internal>: string
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Whimsical, High, Warm
  luna_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Narrator, Low, Warm
  maisie_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Cinematic, High, Natural
  marcus_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Tough, High, Natural
  marina_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Narrator, Med, Natural
  milo_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  non_parametric_agent_subscribable_persona_event<epic_internal> := class(subscribable_event_intrnl(agent)) {}

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # NPC Persona component
  persona_component<native><public> := class<final_super>(component) {
    # Listenable which is signaled when the spoken message is finalized (after moderation).
    #  Contains the actual message delivered — either the original or the canned replacement.
    #  1/ The agent (if involved) that prompted the response.
    #  2/ The final message that was said.
    CommitSayEvent<native><public>: listenable(tuple(?agent, message)) = external {}

    OnInitialized<override>(): void = external {}

    OnPersonaComponentConstructed<native><epic_internal>()<transacts>: void

    @available { MinUploadedAtFNVersion := 4000 }
    OnReceive<override>(SceneEvent: scene_event): logic = external {}

    # Listenable which is signaled when the persona was requested to talk, either by a player or prompt and failed.
    #  Callback receives:
    #    1) The persona which had the failure
    #    2) The error
    PromptFailureEvent<native><public>: listenable(llm_prompt_error) = external {}

    # Requests the Persona to talk on the topic provided, requires the persona to be on a channel
    RequestToTalk<native><public>(Instructions: message)<transacts><decides>: void

    # Listenable which is signaled when the player starts prompting the persona.
    StartHearEvent<native><public>: listenable(agent) = external {}

    # Listenable which is signaled when the persona begins speaking (before moderation resolves).
    #  1/ The agent (if involved) that prompted the response.
    #  2/ Cancelable to stop the persona from talking.
    StartSayEvent<native><public>: listenable(tuple(?agent, cancelable)) = external {}

    # Listenable which is signaled when the player finishes prompting the persona.
    StopHearEvent<native><public>: listenable(agent) = external {}

    # Listenable which is signaled when the target stops talking.
    #  1/ logic that is true when interrupted
    StopSayEvent<native><public>: listenable(logic) = external {}

    # Registers a callback for when the persona receives structured data in the format of response_type.
    #  Required forces this be filled out every time the persona is prompted.
    #  The returned cancelable unregisters this callback and stops the llm from attempting to send this kind of structured data.
    #  The result type must be a struct which can contain.
    #  - numeric types, message, bools and enums, as well as structs or arrays which only contain those types, anything else results in an error.
    #  Use the names of the fields and name of the type of the struct to direct the prompt or facts on how to fill out the data structure.
    SubscribeToResponseType<native><public>(response_type: type, Required: logic, Callback: type { _(: ?agent, : response_type): void })<transacts>: cancelable

    UpdateDetails<native><epic_internal>()<transacts>: void

    UpdateIcon<native><epic_internal>()<transacts>: void

    # How the persona will handle overlapping prompts.
    var InterruptionRule<public>: persona_interruption_rule = external {}

    # What the persona knows
    var Knowledge<public>: message = external {}

    # The personality of the persona
    var Personality<public>: message = external {}

    # The session which will process all this persona's prompts
    # When the persona is in a voice channel, every session in that channel will automatically
    # propagate conversation history entries to all sessions found in the channel.
    # All and only conversation directly to or from a persona will be automatically recorded.
    var Session<public>: llm_session = external {}

    # The voice assigned to this persona.
    var Voice<public>: voice_model = external {}

    var<epic_internal> Color<native><epic_internal>: color = external {}

    var<epic_internal> HearingRange<native><epic_internal>: float = external {}

    var<epic_internal> Volume<native><epic_internal>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  persona_conversation_target<native><epic_internal> := class(conversation_target) {
    # Adds a fact which is assessed at when a persona is prompted. The fact is generated by calling the FactFunc.
    AddDynamicFact<native><public>(FactFunc: type { _()<reads>: string })<transacts>: cancelable

    # Add information about, or known by, the persona. Cancelable is used to remove the fact.
    # # The persona knows these facts, and device facts.
    AddFact<native><public>(Fact: string)<transacts>: cancelable

    # Allow player to to talk to this persona.
    AddPlayer<native><override>(Player: agent)<transacts><decides>: void

    # Fails if the participant is not in the list of participants
    CanConversationTargeterBeAdded<override><native>(ConversationTargeter: agent)<reads><decides>: void

    # Returns a diagnostic of the Persona facts, both static and dynamic.
    DiagnoseFacts<native><public>()<reads>: diagnostic

    # Requests the Persona to talk on the topic provided.
    PromptToTalk<native><public>(Topic: message): void

    # Requests the Persona to talk on the topic provided.
    PromptToTalk<native><public>(Topic: string): void

    # Stop player from being able to talk to this persona.
    RemovePlayer<native><override>(Player: agent)<transacts><decides>: void

    # The result will conform to the result type. The result type must be a struct or a concrete class with no private fields which can contain
    # numeric types, messages, bools and enums, as well as structs, concrete classes with no private fields or arrays which only contain those types, anything else results in an error.
    # Use the names of the fields and name of the type of the struct to direct the prompt or facts on how to fill out the data structure.
    # The result will conform to the result type. The result type must be a struct or a concrete class with no private fields which can contain
    # numeric types, messages, bools and enums, as well as structs, concrete classes with no private fields or arrays which only contain those types, anything else results in an error.
    # Use the names of the fields and name of the type of the struct to direct the prompt or facts on how to fill out the data structure.
    SubscribeToResponseType<native><public>(response_type: type, Callback: type { _(: ?agent, : response_type): void }, Required: logic)<transacts>: cancelable

    # All the agents currently targeting Self for conversation.
    var ConversationTargeters<override>: []agent = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # A persona device manages conversations involving one or multiple persona objects
  # that are either standalone (announcer) or in the future attachable to NPCs,
  # behind the scenes using a single LLM session.
  # The persona device sees all conversations by all personas and participants.
  # The persona device only sees facts added to the device.
  # A persona also sees all conversations among all of its device's personas and participants.
  # A persona sees all facts added to its device and itself.
  persona_device<native><epic_internal> := class<concrete><final>(creative_device_base) {
    # Adds a fact which is assessed at when the device, or a persona is prompted. The fact is generated by calling the FactFunc.
    AddDynamicFact<native><epic_internal>(FactFunc: type { _()<reads>: string })<transacts>: cancelable

    # Add general information to the device. Cancelable is used to remove the fact.
    # The persona knows these facts, and their persona facts.
    AddFact<native><epic_internal>(Fact: string)<transacts>: cancelable

    # Attempts to add a player to the list of participants on this device.
    # Does nothing if the agent does not meet the criteria of participation configured on the device.
    AddParticipant<public>(Agent: agent): void = external {}

    # Attempts to add a persona on this device.
    AddPersona<native><public>((local:)Persona: agent)<transacts><decides>: persona_conversation_target

    # Removes all conversation history from the device.
    ClearHistory<native><public>()<transacts>: void

    GetBPFunctionNamesForValidation<override>(): []string = external {}

    # Returns the ID for the player.
    GetPlayerParticipantId<native><public>(Player: player)<reads>: string

    @available { MinUploadedAtFNVersion := 3810 }
    # The result will conform to the result type. The result type must be a struct or a concrete class with no private fields which can contain
    # numeric types, messages, bools and enums, as well as structs, concrete classes with no private fields or arrays which only contain those types, anything else results in an error.
    # Use the names of the fields and name of the type of the struct to direct the prompt or facts on how to fill out the data structure.
    Prompt<native><epic_internal>(
      UserPrompt: string,
      response_type: type
    )<suspends>: result(response_type, llm_prompt_error)

    # Removes an agent from the participants.
    RemoveParticipant<public>(Agent: agent): void = external {}

    # Attempts to remove a persona on this device.
    RemovePersona<native><public>((local:)Persona: agent)<transacts>: void

    # Fired when one of the response event criteria are met.
    # 1/ the agent, if any, which prompted the persona to trigger the event
    # 2/ the ID of the response event criteria which was met
    ResponseEvent<public>: listenable(tuple(?agent, int)) = external {}

    # All the players in the channel with the personas managed by this device.
    var<private> Participants<public>: []agent = external {}

    # Direct access to all personas configured on this device.
    var<private> Personas<public>: []persona_conversation_target = external {}

    # Different criteria, which if the LLM evaluates to be true, will fire the corresponding event
    var<private> ResponseEventCriteria<public>: [int][]string = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @import_as("/Script/AIPrompt.UPersonaPrompt")
  @experimental
  persona_editor_prompt<native><epic_internal> := class<concrete><final><epic_internal> {}

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Defines the way the persona will handle attempts to prompt it while it is processing.
  persona_interruption_rule<native><public> := enum<open> {
    # Cannot be interrupted, will ignore any input until the finished.
    IgnoreUntilFinished

    # Will be interrupted immediately when spoken to.
    InterruptOnPromptStart

    # Will interrupt when the response for the interrupting prompt is ready.
    InterruptOnResponseStart
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  # A prompt which defines a persona and tells it to do something
  persona_prompt<native><public> := class<final>(prompt) {
    # What the persona should do
    var Instructions<native><public>: message

    # What the persona knows
    var Knowledge<native><public>: message

    # The personality of the persona
    var Personality<native><public>: message
  }

  @available { MinUploadedAtFNVersion := 4000 }
  persona_type_subscription<native><epic_internal> := class(cancelable) {
    Cancel<native><override>()<transacts>: void
  }

  @available { MinUploadedAtFNVersion := 4000 }
  persona_utterance<native><epic_internal> := class(cancelable) {
    Cancel<native><override>()<transacts>: void
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  # Base class for all prompts sent to an llm session
  prompt<native><public> := class<abstract><castable><epic_internal> {}

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Narrator, Low, Warm
  rex_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Tough, Med, Natural
  roxy_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Refined, Med, Warm
  simon_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Whimsical, High, Warm
  troy_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Tough, Med, Natural
  vera_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Comic, High, Natural
  victor_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Glamorous, Animated, warm
  victoria_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Tough, Low, Natural
  vivienne_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # The persona voice used when converting text-to-voice
  voice_model<native><public> := class<abstract><epic_internal> {
    VoiceName<native><epic_internal>: string
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Cinematic, Med, Natural
  walter_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  # Tough, Low, Gravelly
  wyatt_voice<final><public> := class(voice_model) {
    VoiceName<override>: string = external {}
  }
}

Itemization<public> := module {
  @available { MinUploadedAtFNVersion := 3800 }
  # Returns a failure reason (such as being full) if the provided item entity cannot be added. Does not consider sub-inventories.
  (Inventory: inventory_component).CanAddItem<native><public>(
    Item: entity,
    ?AllowMergeItems: logic = external {}
  )<transacts>: result(false, []add_item_error)

  @available { MinUploadedAtFNVersion := 3800 }
  # Returns a failure reason (such as being full) if the provided item entity cannot be added. AddItemDistribute allows the item to enter sub-inventories.
  (Inventory: inventory_component).CanAddItemDistribute<native><public>(
    Item: entity,
    ?AllowMergeItems: logic = external {}
  )<transacts>: result(false, []add_item_error)

  @available { MinUploadedAtFNVersion := 3800 }
  # Returns a failure reason if the provided item is not present or cannot be removed.
  (Inventory: inventory_component).CanRemoveItem<native><public>(Item: entity)<transacts>: result(
    false,
    []remove_item_error
  )

  @available { MinUploadedAtFNVersion := 3800 }
  (Item: item_component).CanEquip<native><public>()<transacts>: result(false, []equip_item_error)

  @available { MinUploadedAtFNVersion := 3800 }
  (Item: item_component).CanUnequip<native><public>()<transacts>: result(false, []unequip_item_error)

  add_inventory_result<native><epic_internal> := class<epic_internal> {
    Inventory<native><public>: inventory_component

    ParentInventory<native><public>: inventory_component
  }

  add_item_error<native><public> := class<computes> {}

  # When adding an item, 'find_inventory_event' is used as a first pass to find the best inventory for an item. It is sent downwards.
  # 'add_item_query_event' can be used to veto inventory choices. It is sent upwards.
  add_item_query_event<native><public> := class<epic_internal>(scene_event) {
    AddError<public>(Error: add_item_error): void = external {}

    Inventory<native><public>: inventory_component

    Item<native><public>: item_component

    var<private> Errors<native><public>: []add_item_error = external {}
  }

  add_item_result<native><public> := class<epic_internal> {
    # Items that were newly added to this inventory as a result of the transaction.
    AddedItems<native><public>: []entity

    # Items whose stack size changed as a result of the transaction, and the previous stack size value.
    ModifiedItems<native><public>: []tuple(entity, int)
  }

  @editor_type
  @experimental
  basic_inventory_setup_data<native><epic_internal> := class<concrete>(inventory_setup_data) {
    ApplyTo<native><override>(Target: inventory_component)<decides>: inventory_setup_data_result

    @editable
    InventoryList<native><public>: []inventory_properties = external {}

    @editable
    StartingItemList<native><public>: []inventory_starting_item = external {}
  }

  @experimental
  calculate_count_info<native><epic_internal> := struct {
    Instigators<native>: []agent = external {}

    Owner<native>: entity = external {}
  }

  change_equipped_result<native><public> := class<epic_internal> {
    IsItemEquipped<native><public>: logic

    ItemComponent<native><public>: item_component
  }

  change_inventory_result<native><public> := class<epic_internal> {
    CurrentInventory<native><public>: ?inventory_component

    ItemComponent<native><public>: item_component

    PreviousInventory<native><public>: ?inventory_component
  }

  change_item_component_event<epic_internal> := class(scene_event) {
    Entity<public>: entity

    ItemComponent<public>: ?item_component = external {}
  }

  change_items_slot_result<native><epic_internal> := struct<epic_internal> {
    Inventory<native><public>: inventory_component

    SlotChangedItems<native><public>: []item_slot_change
  }

  using { /Verse.org/Assets }
  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  using { /Verse.org/Temporary/EpicGamesRestricted/Network }
  @experimental
  copy_from_item<native><epic_internal> := interface<epic_internal> {
    CopyFromItem<native_callable><epic_internal>(SourceItem: entity)<transacts>: void
  }

  equip_item_error<native><public> := class<computes> {}

  equip_item_query_event<native><public> := class(scene_event) {
    AddError<public>(Error: equip_item_error): void = external {}

    Item<native><public>: item_component

    var<private> Errors<native><public>: []equip_item_error = external {}
  }

  equip_item_result<native><public> := class<epic_internal> {
    Item<native><public>: entity
  }

  # When adding an item, 'find_inventory_event' is used as a first pass to find the best inventory for an item. It is sent downwards.
  # 'add_item_query_event' can be used to veto inventory choices. It is sent upwards.
  find_inventory_event<native><public> := class<epic_internal>(scene_event) {
    ItemComponent<native><public>: item_component

    var ChosenInventory<native><public>: ?inventory_component = external {}

    var ChosenInventoryPriority<native><public>: float = external {}
  }

  @class_and_subclass_group_names("inventory")
  # Inventory components hold items. An entity with an inventory component can be considered to have an inventory.
  # The inventory component controls which items can enter or exit.
  # They also determine whether an item can be equipped.
  inventory_component<native><public> := class<final_super>(component) {
    AddInventory<native><final><epic_internal>(Inventory: inventory_component)<transacts><decides>: void

    @available { MinUploadedAtFNVersion := 3800 }
    # Adds the item to this inventory only, ignoring sub-inventories. Fails if no items could be added.
    AddItem<native><final><public>(
      Item: entity,
      ?AllowMergeItems: logic = external {}
    )<transacts>: result(add_item_result, []add_item_error)

    @available { MinUploadedAtFNVersion := 3800 }
    # Adds the item to this inventory, including sub-inventories. Fails if no items could be added.
    AddItemDistribute<native><final><public>(
      Item: entity,
      ?AllowMergeItems: logic = external {}
    )<transacts>: result(add_item_result, []add_item_error)

    AddItemEvent<native><final><public>: listenable(add_item_result) = external {}

    EquipItemEvent<native><final><public>: listenable(equip_item_result) = external {}

    @available { MinUploadedAtFNVersion := 2930 }
    # Returns a list of all sub-inventories within this inventory and its descendant inventories.
    FindInventories<native><final><public>()<reads>: generator(inventory_component)

    @available { MinUploadedAtFNVersion := 2930 }
    # Returns a list of all items within this inventory and its descendant inventories.
    FindItems<native><final><public>()<reads>: generator(entity)

    @available { MinUploadedAtFNVersion := 3200 }
    # Returns a list of all items (of a specific type) within this inventory and its descendant inventories.
    FindItems<native><final><public>(Type: castable_subtype(item_component))<reads>: []entity

    GetEquippedItems<final><native><public>(): []entity

    # Returns a list of sub-inventories of this inventory only.
    GetInventories<native><final><public>()<reads>: []inventory_component

    GetItemSlot<native><epic_internal>(Item: entity)<reads>: int

    # Returns a list of items within this inventory only.
    GetItems<native><final><public>()<reads>: []entity

    @available { MinUploadedAtFNVersion := 3200 }
    # Returns a list of items (of a specific type) within this inventory only.
    GetItems<native><final><public>(Type: castable_subtype(item_component))<reads>: []entity

    InventoryAddedEvent<native><final><epic_internal>: listenable(add_inventory_result) = external {}

    InventoryPropertyChangedEvent<native><final><epic_internal>: listenable(inventory_property_change_result) = external {}

    InventoryRemovedEvent<native><final><epic_internal>: listenable(remove_inventory_result) = external {}

    ItemsSlotChangedEvent<native><final><epic_internal>: listenable(change_items_slot_result) = external {}

    @available { MinUploadedAtFNVersion := 3800 }
    MakeAddItemResultInternal<final><native_callable><epic_internal>(
      IsSuccess: logic,
      AddItemResult: add_item_result
    ): result(add_item_result, []add_item_error) = external {}

    @available { MinUploadedAtFNVersion := 3800 }
    MakeCanAddItemResultInternal<final><native_callable><epic_internal>(IsSuccess: logic): result(
      comparable,
      []add_item_error
    ) = external {}

    @available { MinUploadedAtFNVersion := 3800 }
    MakeCanRemoveItemResultInternal<final><native_callable><epic_internal>(IsSuccess: logic): result(
      comparable,
      []remove_item_error
    ) = external {}

    @available { MinUploadedAtFNVersion := 3800 }
    MakeRemoveItemResultInternal<final><native_callable><epic_internal>(
      IsSuccess: logic,
      RemoveItemResult: remove_item_result
    ): result(remove_item_result, []remove_item_error) = external {}

    OnInitializedInternal<native><override>(): void

    @available { MinUploadedAtFNVersion := 4000 }
    OnReceive<override><native>(SceneEvent: scene_event): logic

    OnUninitializingInternal<native><override>(): void

    RemoveInventory<native><final><epic_internal>(Inventory: inventory_component)<transacts><decides>: void

    @available { MinUploadedAtFNVersion := 3800 }
    # Removes an item from this inventory or its descendent inventories. Fails if the item could not be removed.
    RemoveItem<native><final><public>(Item: entity)<transacts>: result(remove_item_result, []remove_item_error)

    RemoveItemEvent<native><final><public>: listenable(remove_item_result) = external {}

    UnequipItemEvent<native><final><public>: listenable(unequip_item_result) = external {}

    var<private> InventoryDescription<native><epic_internal>: message = external {}

    var<private> InventoryDisplayName<native><epic_internal>: message = external {}

    var<private> InventoryName<native><epic_internal>: string = external {}

    var<private> PickupPriority<native><epic_internal>: int = external {}
  }

  @class_and_subclass_group_names("inventory")
  @experimental
  @hide_in_editor
  inventory_initialization_component<native><epic_internal> := class<final_super>(component) {}

  @experimental
  inventory_properties<native><epic_internal> := class<epic_internal> {
    @editable
    InventoryClass<native><public>: subtype(inventory_component)

    @editable
    InventoryDescription<native><localizes><public>: message = external {}

    @editable
    InventoryDisplayName<native><localizes><public>: message = external {}

    @editable
    InventoryName<native><public>: string = external {}

    @editable
    PickupPriority<native><public>: int = external {}

    @editable
    SlotBindings<native><public>: []inventory_slot_binding_definition

    @editable_number(int) { MinValue := option { 0 } }
    TotalSlotsOverride<native><public>: int = external {}
  }

  inventory_property_change_result<native><epic_internal> := struct<epic_internal> {
    Inventory<native><public>: inventory_component
  }

  @experimental
  inventory_setup_data<native><epic_internal> := class<abstract> {
    ApplyTo<public>(Target: inventory_component)<decides>: inventory_setup_data_result
  }

  @experimental
  inventory_setup_data_result<native><epic_internal> := struct<epic_internal> {
    AddedInventoryMap<native><public>: []tuple(inventory_component, []entity)

    Inventory<native><public>: inventory_component
  }

  @experimental
  inventory_slot_binding_definition<native><epic_internal> := struct<concrete><epic_internal> {
    @editable
    InputAction<native><public>: input_action(type) = external {}

    @editable_number(int) { MinValue := option { 0 } }
    Slot<native><public>: int = external {}
  }

  @experimental
  inventory_starting_item<native><epic_internal> := struct<concrete><epic_internal> {
    @editable_number(int) { MinValue := option { 1 } }
    Amount<native>: int = external {}

    @editable
    ItemDefinition<native>: ?item_definition_base = external {}

    @editable
    ItemEntityClass<native>: ?subtype(entity) = external {}
  }

  @experimental
  item_ability_binding<native><final><epic_internal> := class<concrete> {
    @editable
    var<private> ActiveWhenItemEquipped<native><public>: logic = external {}

    @editable
    var<private> ActiveWhenItemNotEquipped<native><public>: logic = external {}

    @editable
    var<private> Cooldowns<native><public>: []item_ability_cooldown = external {}

    @editable
    var<private> Costs<native><public>: []item_ability_cost = external {}

    @editable
    var<private> InputAction<native><public>: ?input_action(type) = external {}
  }

  @class_and_subclass_group_names("item")
  @experimental
  @hide_in_editor
  item_ability_component<native><final><epic_internal> := class<final_super>(component) {
    @editable
    var<private> ItemAbilities<native><public>: []item_ability_binding
  }

  @experimental
  @import_as("/Script/ItemizationCoreRuntime.UItemAbilityCooldown")
  item_ability_cooldown<native><epic_internal> := class<unique><abstract> {}

  @experimental
  item_ability_cooldown_time<native><epic_internal> := class(item_ability_cooldown) {}

  @experimental
  item_ability_cooldown_velocity_based<native><epic_internal> := class(item_ability_cooldown) {}

  @experimental
  @import_as("/Script/ItemizationCoreRuntime.UItemAbilityCost")
  item_ability_cost<native><epic_internal> := class<unique><abstract> {}

  @experimental
  item_ability_cost_item<native><epic_internal> := class(item_ability_cost) {}

  @class_and_subclass_group_names("item")
  @experimental
  item_attach_component<native><final><epic_internal> := class<final_super>(component) {
    @editable
    Attachments<native><public>: []item_attachment_definition = external {}
  }

  @experimental
  item_attachment_definition<native><epic_internal> := class<unique><concrete> {
    @editable
    var VisibleWhenEquipped<native><public>: logic = external {}

    @editable
    var VisibleWhenUnequipped<native><public>: logic = external {}
  }

  # item_category is used to classify items.
  item_category<native><public> := class<castable><concrete><unique><allocates> {}

  @class_and_subclass_group_names("item")
  # Anything using this component should be considered an item. Required to interact with inventories.
  item_component<native><public> := class<final_super>(component) {
    @replicated("")
    @editable
    # Add one or more category instances to help define and organize this item.
    Categories<native><public>: []item_category = external {}

    # Broadcast when this item is equipped or unequipped.
    ChangeEquippedEvent<native><final><public>: listenable(change_equipped_result) = external {}

    # Broadcast when this item changes inventory.
    ChangeInventoryEvent<native><final><public>: listenable(change_inventory_result) = external {}

    # Removes the item from its inventory and places it in the simulation world. Works on orphaned items i.e. outside the world or any inventory.
    #  Fails if the item is already a pickup. The transform of the item will not be altered except to unparent it from any inventory.
    (/UnrealEngine.com/Itemization/item_component:)Drop<native><public>()<transacts><decides>: void

    @available { MinUploadedAtFNVersion := 3800 }
    # Attempts to equip this item within the inventory it is currently in.
    # Fails if not in an inventory or if equip_item_query_event contains any errors after querying.
    Equip<final><native><public>()<transacts>: result(false, []equip_item_error)

    # Returns the inventory_component this item currently resides in. Fails if it cannot find a valid parent inventory.
    GetParentInventory<native><final><public>()<reads><decides>: inventory_component

    # Succeeds if this item is considered currently within an inventory and equipped.
    IsEquipped<native><final><public>()<reads><decides>: void

    ItemDefinitionAsset<native><epic_internal>: ?item_definition = external {}

    @available { MinUploadedAtFNVersion := 3800 }
    MakeEquipResultInternal<final><native_callable><epic_internal>(IsSuccess: logic): result(
      comparable,
      []equip_item_error
    ) = external {}

    @available { MinUploadedAtFNVersion := 3800 }
    MakeUnequipResultInternal<final><native_callable><epic_internal>(IsSuccess: logic): result(
      comparable,
      []unequip_item_error
    ) = external {}

    OnBeginSimulation<override>(): void = external {}

    OnEndSimulation<override>(): void = external {}

    OnInitializedInternal<native><override>(): void

    # Fails if this item is already in an inventory, or the inventory cannot accept the item.
    PickUp<native><public>(Inventory: inventory_component)<transacts><decides>: void

    @available { MinUploadedAtFNVersion := 3800 }
    # Attempts to unequip this item.
    # Fails if not in an inventory, not currently equipped or if unequip_item_query_event contains any errors after querying.
    Unequip<final><native><public>()<transacts>: result(false, []unequip_item_error)

    @replicated("")
    var<private> ItemDefinition<native><epic_internal>: ?item_definition_base = external {}
  }

  item_definition<native><epic_internal> := class<epic_internal>(asset) {}

  @import_as("/Script/ItemizationCoreRuntime.UItemDefinitionBase")
  item_definition_base<native><epic_internal> := class<epic_internal> {}

  @experimental
  item_mesh_attachment_definition<native><epic_internal> := class<concrete>(item_attachment_definition) {
    @editable
    EntityToAttach<native><public>: ?subtype(entity) = external {}

    @editable
    var AttachToSocketName<native><public>: string = external {}
  }

  @class_and_subclass_group_names("item")
  @experimental
  # Item component setting owner pose data for this item.
  item_owner_pose_modifier_component<native><final><epic_internal> := class<final_super>(component) {
    @editable
    EquippedPose<native><public>: ?pose_modifier = external {}

    @editable
    NotEquippedPose<native><public>: ?pose_modifier = external {}
  }

  item_slot_change<native><epic_internal> := struct<epic_internal> {
    CurrentSlot<native><public>: int

    Item<native><public>: entity

    PreviousSlot<native><public>: int
  }

  @class_and_subclass_group_names("item")
  @experimental
  @hide_in_editor
  # Component that allows setting the number of slots used by this item in an inventory.
  item_slot_size_component<native><epic_internal> := class<final_super>(component) {
    @editable
    SlotSize<native><public>: int = external {}
  }

  @experimental
  itemization_core_debug_library<native><epic_internal> := class {
    AddTestItem<native_callable><public>(InInventory: inventory_component): void = external {}

    # Adds an item which is also an inventory (let's call it a bag). There is an object inside the bag.
    AddTestItemWithInventory<native_callable><public>(InInventory: inventory_component): void = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    # Adds a mergeable item which can be stacked to the inventory.
    AddTestStackableItem<native_callable><public>(InInventory: inventory_component): void = external {}

    RemoveAllItems<native_callable><public>(InInventory: inventory_component): void = external {}
  }

  @experimental
  @hide_in_editor
  itemization_debug_item_component_mergeable<epic_internal> := class(item_component, has_merge_rules) {
    AllowMergeInto<override>(TargetEntity: entity)<reads><decides>: void = external {}
  }

  @experimental
  # Loot Data
  loot<native><epic_internal> := struct<concrete> {
    @editable
    Items<native>: []subtype(entity) = external {}

    @editable
    LootPools<native>: []loot_pool = external {}

    @editable
    MaxSelections<native>: ?int = external {}

    @editable
    Weight<native>: loot_weight_calculator = external {}
  }

  @experimental
  # Spawns loot to the world or award it to an agent inventory.
  loot_component<native><epic_internal> := class<final_super>(component, enableable) {
    AwardLoot<native><public>(Target: entity, Instigators: []agent, DestroyOverflow: logic): []entity

    Disable<native><override>(): void

    Enable<native><override>(): void

    IsEnabled<native><override>()<transacts><decides>: void

    @editable
    Items<native><public>: []subtype(entity) = external {}

    @editable
    LootPools<native><public>: []loot_pool = external {}

    SpawnPickups<native><public>(Instigators: []agent): []entity
  }

  @experimental
  # It can be overriden. It will return how many times the loot can be rolled
  loot_count_calculator<native><epic_internal> := class<concrete> {}

  @experimental
  # Fixed amount of rolls
  loot_count_calculator_fixed<native><epic_internal> := class<concrete>(loot_count_calculator) {}

  @experimental
  # Random range of rolls
  loot_count_calculator_range<native><epic_internal> := class<concrete>(loot_count_calculator) {}

  @experimental
  # Weighted amount of rolls
  loot_count_calculator_weighted<native><epic_internal> := class<concrete>(loot_count_calculator) {}

  @experimental
  loot_distribution<native><epic_internal> := struct<concrete> {
    @category("Values")
    @editable
    Count<native>: int = external {}

    @category("Values")
    @editable
    Weight<native>: float = external {}
  }

  @experimental
  # The Data for the loot component to work with
  loot_pool<native><epic_internal> := class<concrete> {}

  @experimental
  loot_weight_calculator<native><epic_internal> := class<concrete> {}

  @experimental
  loot_weight_calculator_fixed<epic_internal> := class<concrete>(loot_weight_calculator) {}

  @experimental
  loot_weight_calculator_info<native><epic_internal> := struct {
    Instigators<native>: []agent = external {}

    Items<native>: []subtype(entity) = external {}

    LootPools<native>: []loot_pool = external {}

    Owner<native>: ?entity = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  native_item_stackable_component<native><epic_internal> := class(stackable_component) {
    Split<override><native>(Amount: int)<transacts><decides>: entity
  }

  @experimental
  @import_as("/Script/ItemizationCoreRuntime.UItemOwnerPoseAsset")
  # Owner poses let an item affect their owner's default animation stance.
  #  For example, to make a character hold an item like a torch, or a 2-handed weapon.
  pose_modifier<native><epic_internal> := class<concrete><unique>(asset) {}

  remove_inventory_result<native><epic_internal> := class<epic_internal> {
    Inventory<native><public>: inventory_component

    ParentInventory<native><public>: inventory_component
  }

  remove_item_error<native><public> := class<computes> {}

  remove_item_query_event<native><public> := class<epic_internal>(scene_event) {
    AddError<public>(Error: remove_item_error): void = external {}

    Inventory<native><public>: inventory_component

    Item<native><public>: item_component

    var<private> Errors<native><public>: []remove_item_error = external {}
  }

  remove_item_result<native><public> := class<epic_internal> {
    # The inventory which the item was removed from.
    Inventory<native><public>: inventory_component

    # Item whose stack size changed as a result of the transaction.
    ModifiedItem<native><public>: ?tuple(entity, int)

    # Total stack count of items removed as a result of this transaction.
    RemovedAmount<native><public>: int

    # Items that were removed from this inventory as a result of the transaction.
    RemovedItems<native><public>: []entity
  }

  @hide_in_editor
  subscribable_inventory_event<native><epic_internal>(t: type) := class(subscribable_event_intrnl(t)) {
    Await<native><override>()<suspends>: t

    (/UnrealEngine.com/Itemization/subscribable_inventory_event:)Itemization_subscribable_inventory_event_Variance<private>(): tuple(t, t) = external {}

    Subscribe<native><override>(Callback: type { _(: t): void })<transacts>: cancelable
  }

  unequip_item_error<native><public> := class<computes> {}

  unequip_item_query_event<native><public> := class(scene_event) {
    AddError<public>(Error: unequip_item_error): void = external {}

    Item<native><public>: item_component

    var<private> Errors<native><public>: []unequip_item_error = external {}
  }

  unequip_item_result<native><public> := class<epic_internal> {
    Item<native><public>: entity
  }
}

JSON<public> := module {
  # Parse a JSON string returning a value with its contents
  Parse<native><public>(JSONString: string)<transacts><decides>: value

  value<native><public> := class {
    # Retrieve an array value or fail if value is not a json array
    AsArray<native><public>()<transacts><decides>: []value

    # Retrieve a float value or fail if value is not a json number
    AsFloat<native><public>()<transacts><decides>: float

    # Retrieve an integer value or fail if value is not a json number
    AsInt<native><public>()<transacts><decides>: int

    # Retrieve an object value or fail if value is not null
    AsNull<native><public>()<transacts><decides>: void

    # Retrieve an object value or fail if value is not a json object
    AsObject<native><public>()<transacts><decides>: [string]value

    # Retrieve an object value or fail if value is not a string
    AsString<native><public>()<transacts><decides>: string
  }
}

Progression<public> := module {
  BroadcastVerbMessage<native><epic_internal>(Author: entity, SceneEvent: scene_event): void

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  MakeGrantRewardErrorResult<native_callable><epic_internal>(): result(void, []grant_quest_reward_error) = external {}

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  MakeGrantRewardSuccessResult<native_callable><epic_internal>(): result(
    comparable,
    []grant_quest_reward_error
  ) = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  MakeRegisterGameplayConditionalErrorResult<native_callable><epic_internal>(): result(
    gameplay_conditional_listener_handle,
    []register_gameplay_conditional_error
  ) = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  MakeRegisterGameplayConditionalSuccessResult<native_callable><epic_internal>(ListenerHandle: gameplay_conditional_listener_handle): result(
    gameplay_conditional_listener_handle,
    []register_gameplay_conditional_error
  ) = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  MakeRegisterVerbErrorResult<native_callable><epic_internal>(): result(
    verb_listener_handle,
    []register_verb_error
  ) = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  MakeRegisterVerbSuccessResult<native_callable><epic_internal>(ListenerHandle: verb_listener_handle): result(
    verb_listener_handle,
    []register_verb_error
  ) = external {}

  @available { MinUploadedAtFNVersion := 4000 }
  RegisterGameplayConditional<native><epic_internal>(ContextAnchor: entity, GameplayConditional: subtype(gameplay_conditional), Callback: type { _(: gameplay_conditional_context): void })<transacts>: result(gameplay_conditional_listener_handle, []register_gameplay_conditional_error)

  @available { MinUploadedAtFNVersion := 4000 }
  RegisterInstancedGameplayConditional<native><epic_internal>(ContextAnchor: entity, GameplayConditional: gameplay_conditional, Callback: type { _(: gameplay_conditional_context): void })<transacts>: result(gameplay_conditional_listener_handle, []register_gameplay_conditional_error)

  @available { MinUploadedAtFNVersion := 4000 }
  RegisterInstancedVerbFilter<native><epic_internal>(VerbFilter: verb_filter, Callback: type { _(: entity, : scene_event, : float): void })<transacts>: result(verb_listener_handle, []register_verb_error)

  @available { MinUploadedAtFNVersion := 4000 }
  RegisterSharedVerbFilter<native><epic_internal>(VerbFilter: verb_filter, Callback: type { _(: entity, : scene_event, : float): void })<transacts>: result(verb_listener_handle, []register_verb_error)

  @available { MinUploadedAtFNVersion := 4000 }
  RegisterVerbFilter<native><epic_internal>(VerbFilterType: subtype(verb_filter), Callback: type { _(: entity, : scene_event, : float): void })<transacts>: result(verb_listener_handle, []register_verb_error)

  @available { MinUploadedAtFNVersion := 4000 }
  RegisterVerbMessage<native><epic_internal>(VerbMessageType: subtype(scene_event), Callback: type { _(: entity, : scene_event): void })<transacts>: result(verb_listener_handle, []register_verb_error)

  @experimental
  RestoreQuestData<native><epic_internal>(Data: quest_progress_data)<transacts><decides>: quest

  @experimental
  SnapshotQuestData<native><epic_internal>(Quest: quest)<reads>: quest_progress_data

  already_claimed_error<native><epic_internal> := class<epic_internal>(claim_reward_error) {}

  using { /Verse.org/Assets }
  using { /Verse.org/Presentation }
  @experimental
  # Standard quest that follows the "do x, get y" paradigm.
  # Auto-completion: when Objective.IsComplete() succeeds, calls Complete() automatically.
  # Auto-rewarding: on completion, rewards are granted to eligible participants
  # via GetRecipients() then GrantReward().
  basic_quest<native><public> := class<abstract>(quest, has_icon, has_description) {
    CanGrantRewards<native><native_callable><epic_internal>()<reads><decides>: void

    GrantRewardsToParticipants<native><native_callable><final><epic_internal>(): void

    OnAbandon<override><native><native_callable>(QuestParticipant: quest_participant): void

    OnActivate<override><native><native_callable>(): void

    OnDeactivate<override><native><native_callable>(): void

    OnJoin<override><native><native_callable>(QuestParticipant: quest_participant): void

    # Replaces the progression model on a live quest. Auto-completes if the new objective is
    # already completed.
    SetObjective<native><final><public>(InObjective: quest_objective)<transacts>: void

    # Rewards granted to eligible participants on completion.
    var Rewards<native><public>: []quest_reward = external {}

    # Progression model for the quest.
    var<private> Objective<native><public>: quest_objective
  }

  claim_reward_error<native><epic_internal> := class<epic_internal> {}

  @experimental
  composite_objective_snapshot<native><epic_internal> := class<final><persistable><epic_internal> {
    Children<native><epic_internal>: []objective_snapshot = external {}

    CompletedCount<native><epic_internal>: int = external {}

    ObjectiveId<native><epic_internal>: string = external {}

    ObjectiveVersePath<native><epic_internal>: string = external {}

    RequiredCount<native><epic_internal>: int = external {}
  }

  using { /Fortnite.com/Marketplace }
  using { /Verse.org/Native }
  using { /Verse.org/Progression }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/StateMachine }
  @experimental
  composite_quest_objective<native><epic_internal> := class<epic_internal>(quest_objective) {
    GetProgress<override><native><native_callable>()<reads>: message

    IsComplete<override><native><native_callable>()<reads><decides>: void

    OnAbandon<override><native><native_callable>(QuestParticipant: quest_participant): void

    OnActivate<override><native><native_callable>(): void

    OnDeactivate<override><native><native_callable>(): void

    OnJoin<override><native><native_callable>(QuestParticipant: quest_participant): void

    var Objectives<native><epic_internal>: []quest_objective = external {}

    var<private> RequiredCount<native><epic_internal>: int = external {}
  }

  @experimental
  conditional_quest_objective<native><epic_internal> := class<epic_internal>(
    progress_quest_objective,
    has_gameplay_conditionals
  ) {
    OnAbandon<override>(QuestParticipant: quest_participant): void = external {}

    OnActivate<override>(): void = external {}

    OnConditionalExecuted<override>(Context: gameplay_conditional_context): void = external {}

    OnDeactivate<override>(): void = external {}

    OnJoin<override>(QuestParticipant: quest_participant): void = external {}

    var RegisteredHandles<epic_internal>: []gameplay_conditional_listener_handle = external {}
  }

  contextual_reactions_cache<epic_internal> := class<unique><epic_internal> {
    Invalidate<epic_internal>(): void = external {}

    OnGameplayConditionalTriggered<epic_internal>(Context: gameplay_conditional_context): void = external {}

    OwningComponent<epic_internal>: contextual_reactions_component

    Reactions<epic_internal>: []gameplay_reaction

    var Handle<epic_internal>: ?gameplay_conditional_listener_handle = external {}
  }

  contextual_reactions_component<native><epic_internal> := class<final_super><epic_internal>(component) {
    Events<epic_internal>: []tuple(gameplay_conditional, []gameplay_reaction)

    OnBeginSimulation<override>(): void = external {}

    OnEndSimulation<override>(): void = external {}

    var Caches<epic_internal>: []contextual_reactions_cache = external {}
  }

  ecosystem_entitlement<native><epic_internal> := class(entitlement) {
    PaidArea<override><final>: logic = external {}

    PaidRandomItem<override><final>: logic = external {}
  }

  @experimental
  # Grants an entitlement to each eligible participant.
  entitlement_quest_reward<native><public> := class(quest_reward) {
    @available { MinUploadedAtFNVersion := 4000 }
    # Iterates EligibleParticipants, resolves each participant's agent as a player,
    # and grants the entitlement via the platform entitlement service.
    GrantReward<override><native><final>(EligibleParticipants: []quest_participant)<transacts>: result(
      void,
      []grant_quest_reward_error
    )

    @available { MinUploadedAtFNVersion := 4000 }
    # The entitlement type to grant.
    var Entitlement<native><public>: concrete_subtype(entitlement)

    # Quantity per participant.
    var Quantity<native><public>: int = external {}
  }

  execute_gameplay_reaction_error<native><public> := class<epic_internal> {}

  gameplay_conditional<native><epic_internal> := class<abstract> {
    Attributes<native><epic_internal>: []gameplay_conditional_attribute = external {}

    Execute<native><final><epic_internal>(ContextObject: gameplay_conditional_context): void

    OnInitialization<native_callable><epic_internal>(ContextAnchor: entity): void

    OnInvalidation<native_callable><epic_internal>(): void

    OnParticipantAdded<native_callable><epic_internal>(Participant: entity): void

    OnParticipantRemoved<native_callable><epic_internal>(Participant: entity): void
  }

  gameplay_conditional_attribute<native><epic_internal> := class<abstract> {
    Evaluate<native_callable><epic_internal>()<decides>: void

    OnInitialization<native_callable><epic_internal>(ContextAnchor: entity): void

    OnInvalidation<native_callable><epic_internal>(): void
  }

  gameplay_conditional_context<native><epic_internal> := class {
    Delta<native><epic_internal>: float

    Instigator<native><epic_internal>: entity
  }

  gameplay_conditional_listener_handle<native><final><epic_internal> := class {
    AddParticipant<native><epic_internal>(Participant: entity): void

    GetParticipants<native><epic_internal>()<reads>: []entity

    IsRegistered<native><epic_internal>()<transacts><decides>: void

    RemoveParticipant<native><epic_internal>(Participant: entity): void

    Unregister<native><epic_internal>(): void
  }

  gameplay_conditional_verbs<epic_internal> := class(gameplay_conditional) {
    OnInitialization<override>(ContextAnchor: entity): void = external {}

    OnInvalidation<override>(): void = external {}

    OnParticipantAdded<override>(Participant: entity): void = external {}

    OnParticipantRemoved<override>(Participant: entity): void = external {}

    OnVerbMessageReceived<protected>(Author: entity, SceneEvent: scene_event): void = external {}

    OnVerbMessageReceivedWithDelta<protected>(Author: entity, SceneEvent: scene_event, Delta: float): void = external {}

    VerbFilterTypes<epic_internal>: []subtype(verb_filter)

    VerbMessageTypes<epic_internal>: []subtype(scene_event)
  }

  gameplay_reaction<native><epic_internal> := class<abstract> {
    @available { MinUploadedAtFNVersion := 4000 }
    Execute<native_callable><epic_internal>(ContextObject: gameplay_reaction_context)<transacts>: result(
      void,
      []execute_gameplay_reaction_error
    )
  }

  gameplay_reaction_context<native><epic_internal> := class {
    Source<native><epic_internal>: entity

    Target<native><epic_internal>: entity
  }

  @experimental
  # Returned when a reward cannot be granted.
  grant_quest_reward_error<native><public> := class {}

  has_gameplay_conditionals<native><epic_internal> := interface<epic_internal> {
    Conditionals<epic_internal>: []subtype(gameplay_conditional) = external {}

    OnConditionalExecuted<native_callable><epic_internal>(Context: gameplay_conditional_context): void
  }

  has_gameplay_reactions<native><epic_internal> := interface<epic_internal> {
    Reactions<epic_internal>: []gameplay_reaction = external {}

    TriggerReactions<epic_internal>(Context: gameplay_reaction_context)<transacts>: void = external {}
  }

  locker_entitlement<native><epic_internal> := class(ecosystem_entitlement) {
    Consumable<override><final>: logic = external {}

    MaxCount<override><final>: int = external {}
  }

  @experimental
  modular_quest<native><epic_internal> := class<epic_internal>(basic_quest) {
    @available { MinUploadedAtFNVersion := 4000 }
    CanAbandon<override><native><native_callable>(QuestParticipant: quest_participant)<reads>: result(
      void,
      []abandon_quest_error
    )

    CanGrantRewards<override><native><native_callable>()<reads><decides>: void

    @available { MinUploadedAtFNVersion := 4000 }
    CanJoin<override><native><native_callable>(QuestParticipant: quest_participant)<reads>: result(void, []join_quest_error)

    Extensions<native><epic_internal>: []quest_extension

    OnAbandon<override><native><native_callable>(QuestParticipant: quest_participant): void

    OnActivate<override><native><native_callable>(): void

    OnComplete<override><native><native_callable>(): void

    OnDeactivate<override><native><native_callable>(): void

    OnJoin<override><native><native_callable>(QuestParticipant: quest_participant): void
  }

  not_ready_to_claim_error<native><epic_internal> := class<epic_internal>(claim_reward_error) {}

  @experimental
  objective_snapshot<native><epic_internal> := class<final><persistable><epic_internal> {
    Composite<native><epic_internal>: ?composite_objective_snapshot = external {}

    Progress<native><epic_internal>: ?progress_objective_snapshot = external {}

    Sequential<native><epic_internal>: ?sequential_objective_snapshot = external {}

    StateMachine<native><epic_internal>: ?state_machine_objective_snapshot = external {}

    Timed<native><epic_internal>: ?timed_objective_snapshot = external {}
  }

  @experimental
  progress_objective_snapshot<native><epic_internal> := class<final><persistable><epic_internal> {
    ObjectiveId<native><epic_internal>: string = external {}

    ObjectiveVersePath<native><epic_internal>: string = external {}

    Progress<native><epic_internal>: float = external {}

    RequiredCount<native><epic_internal>: float = external {}
  }

  @experimental
  # Tracks numeric progress toward a required count.
  # Complete when Progress >= RequiredCount.
  progress_quest_objective<native><public> := class(quest_objective) {
    AddProgress<native><final><epic_internal>(Amount: float)<transacts>: void

    # Returns progress in "X / Y" format.
    GetProgress<override><native><final>()<reads>: message

    # Succeeds if Progress >= RequiredCount.
    IsComplete<override><native><final>()<reads><decides>: void

    # Sets current progress. Clamped to [0, RequiredCount].
    SetProgress<native><final><public>(Amount: float)<transacts>: void

    # Sets the target count. Clamped to [1, MaxFloat].
    SetRequiredCount<native><final><public>(Amount: float)<transacts>: void

    # Current progress toward RequiredCount.
    var<private> Progress<native><public>: float = external {}

    # Target count for completion.
    var<private> RequiredCount<native><public>: float
  }

  @experimental
  quest_extension<native><epic_internal> := class<abstract><castable><epic_internal> {
    @available { MinUploadedAtFNVersion := 4000 }
    CanAbandon<native><native_callable><epic_internal>(QuestParticipant: quest_participant)<reads>: result(
      void,
      []abandon_quest_error
    )

    CanGrantRewards<native><native_callable><epic_internal>()<reads><decides>: void

    @available { MinUploadedAtFNVersion := 4000 }
    CanJoin<native><native_callable><epic_internal>(QuestParticipant: quest_participant)<reads>: result(
      void,
      []join_quest_error
    )

    GetOwningQuest<native><final><epic_internal>()<reads>: quest

    OnAbandon<native><native_callable><epic_internal>(QuestParticipant: quest_participant): void

    OnActivate<native><native_callable><epic_internal>(): void

    OnComplete<native><native_callable><epic_internal>(): void

    OnDeactivate<native><native_callable><epic_internal>(): void

    OnJoin<native><native_callable><epic_internal>(QuestParticipant: quest_participant): void
  }

  @experimental
  # Abstract base class for all quest objectives.
  quest_objective<native><public> := class<abstract>(has_icon, has_description) {
    AbandonEvent<native><final><epic_internal>: listenable(tuple(quest_objective, quest_membership)) = external {}

    ActivateEvent<native><final><epic_internal>: listenable(quest_objective) = external {}

    CanProgress<native><native_callable><epic_internal>()<reads><decides>: void

    # Signaled when this objective is considered complete.
    CompleteEvent<native><final><public>: listenable(quest_objective) = external {}

    DeactivateEvent<native><final><epic_internal>: listenable(quest_objective) = external {}

    # Determines which participants can contribute to this objective.
    # Override to customize contributor selection.
    # Default: all participants where Info.Contributes = true.
    GetContributors<native><native_callable><public>(Memberships: []quest_membership)<reads>: []quest_participant

    GetOwningQuest<native><final><epic_internal>()<reads>: quest

    # Returns a progress message (e.g. "3 / 10").
    GetProgress<native><native_callable><public>()<reads>: message

    # Succeeds if this objective is currently complete.
    IsComplete<native><native_callable><public>()<reads><decides>: void

    JoinEvent<native><final><epic_internal>: listenable(tuple(quest_objective, quest_membership)) = external {}

    OnAbandon<native><native_callable><epic_internal>(QuestParticipant: quest_participant): void

    OnActivate<native><native_callable><epic_internal>(): void

    OnComplete<native><native_callable><epic_internal>(): void

    OnDeactivate<native><native_callable><epic_internal>(): void

    OnJoin<native><native_callable><epic_internal>(QuestParticipant: quest_participant): void

    # Signaled when this objective's progress changes. Payload: this objective.
    ProgressEvent<native><final><public>: listenable(quest_objective) = external {}

    # Signals ProgressEvent. Call from a subclass to notify progress subscribers.
    SignalProgressEvent<native><final><protected>()<transacts>: void
  }

  @experimental
  quest_objective_state<native><epic_internal> := class<final_super><epic_internal>(state) {
    OnEnter<override><native><native_callable>(): void

    OnExit<override><native><native_callable>(): void

    var Objective<native><epic_internal>: quest_objective
  }

  @experimental
  quest_progress_data<native><epic_internal> := class<final><persistable><epic_internal> {
    Objective<native><epic_internal>: ?objective_snapshot = external {}

    QuestId<native><epic_internal>: string = external {}

    QuestVersePath<native><epic_internal>: string = external {}

    State<native><epic_internal>: quest_state = external {}
  }

  @experimental
  # Abstract base class for all quest rewards.
  quest_reward<native><public> := class<abstract>(has_icon, has_description) {
    # Determines which participants should receive this reward.
    # Override to customize recipient selection.
    # Default: all participants where Info.Receives = true.
    GetRecipients<native><native_callable><public>(Memberships: []quest_membership)<reads>: []quest_participant

    # Signaled after this reward has been granted to recipients.
    GrantEvent<native><final><public>: listenable(tuple(quest_reward, []quest_participant)) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    # Grants this reward to the eligible participants.
    GrantReward<native><native_callable><public>(EligibleParticipants: []quest_participant)<transacts>: result(
      void,
      []grant_quest_reward_error
    )
  }

  register_gameplay_conditional_error<native><public> := class<epic_internal> {}

  register_verb_error<native><public> := class<epic_internal> {}

  @experimental
  reward_claim_quest_extension<native><epic_internal> := class<epic_internal>(quest_extension) {
    CanGrantRewards<override><native><native_callable>()<reads><decides>: void

    @available { MinUploadedAtFNVersion := 4000 }
    ClaimRewards<native><native_callable><epic_internal>()<transacts>: result(void, []claim_reward_error)

    IsReadyToClaim<native><native_callable><epic_internal>()<reads><decides>: void

    RewardsClaimedEvent<native><final><epic_internal>: listenable(reward_claim_quest_extension) = external {}

    RewardsReadyEvent<native><final><epic_internal>: listenable(reward_claim_quest_extension) = external {}

    var<private> Claimed<native><epic_internal>: logic = external {}

    var<private> PendingClaim<native><epic_internal>: logic = external {}
  }

  @experimental
  sequential_objective_snapshot<native><epic_internal> := class<final><persistable><epic_internal> {
    Children<native><epic_internal>: []objective_snapshot = external {}

    CurrentIndex<native><epic_internal>: int = external {}

    ObjectiveId<native><epic_internal>: string = external {}

    ObjectiveVersePath<native><epic_internal>: string = external {}
  }

  @experimental
  sequential_quest_objective<native><epic_internal> := class<epic_internal>(quest_objective) {
    GetProgress<override><native><native_callable>()<reads>: message

    IsComplete<override><native><native_callable>()<reads><decides>: void

    OnAbandon<override><native><native_callable>(QuestParticipant: quest_participant): void

    OnActivate<override><native><native_callable>(): void

    OnDeactivate<override><native><native_callable>(): void

    OnJoin<override><native><native_callable>(QuestParticipant: quest_participant): void

    var Objectives<native><epic_internal>: []quest_objective

    var<private> CurrentStageIndex<native><epic_internal>: int = external {}
  }

  @experimental
  state_machine_objective_snapshot<native><epic_internal> := class<final><persistable><epic_internal> {
    CurrentStateId<native><epic_internal>: string = external {}

    ObjectiveId<native><epic_internal>: string = external {}

    ObjectiveVersePath<native><epic_internal>: string = external {}
  }

  @experimental
  state_machine_quest_objective<native><epic_internal> := class<epic_internal>(quest_objective) {
    GetProgress<override><native><native_callable>()<reads>: message

    IsComplete<override><native><native_callable>()<reads><decides>: void

    OnAbandon<override><native><native_callable>(QuestParticipant: quest_participant): void

    OnJoin<override><native><native_callable>(QuestParticipant: quest_participant): void

    UpdateCurrentState<native><final><epic_internal>(): void

    var (/UnrealEngine.com/Progression/state_machine_quest_objective:)StateMachine<native><epic_internal>: state_machine

    var CompletionStates<native><epic_internal>: []state

    var<private> CurrentState<native><epic_internal>: ?quest_objective_state = external {}
  }

  @experimental
  timed_objective_snapshot<native><epic_internal> := class<final><persistable><epic_internal> {
    Inner<native><epic_internal>: ?objective_snapshot = external {}

    ObjectiveId<native><epic_internal>: string = external {}

    ObjectiveVersePath<native><epic_internal>: string = external {}

    TimeRemainingMs<native><epic_internal>: int = external {}
  }

  @experimental
  timed_quest_objective<native><epic_internal> := class<epic_internal>(quest_objective) {
    GetProgress<override><native><native_callable>()<reads>: message

    IsComplete<override><native><native_callable>()<reads><decides>: void

    OnAbandon<override><native><native_callable>(QuestParticipant: quest_participant): void

    OnJoin<override><native><native_callable>(QuestParticipant: quest_participant): void

    TimeExpiredEvent<native><final><epic_internal>: listenable(timed_quest_objective) = external {}

    UpdateTimeRemaining<native><final><epic_internal>(DeltaSeconds: float)<transacts>: void

    var Objective<native><epic_internal>: quest_objective

    var TimeLimit<native><epic_internal>: float

    var<private> TimeRemaining<native><epic_internal>: float
  }

  verb_filter<native><public> := class<abstract><epic_internal> {
    Evaluate<native_callable><epic_internal>(SceneEvent: scene_event)<decides>: void

    GetDelta<native_callable><epic_internal>(SceneEvent: scene_event): float
  }

  verb_listener_handle<native><final><public> := class<epic_internal> {
    AddParticipant<native><epic_internal>(Entity: entity)<transacts>: void

    GetParticipants<native><epic_internal>()<reads>: []entity

    IsRegistered<native><epic_internal>()<transacts><decides>: void

    RemoveParticipant<native><epic_internal>(Entity: entity)<transacts>: void

    Unregister<native><epic_internal>(): void
  }

  verb_router_component<native><public> := class<final_super><epic_internal>(component) {
    @available { MinUploadedAtFNVersion := 4000 }
    OnReceive<override>(SceneEvent: scene_event): logic = external {}
  }

  xp_entitlement<native><epic_internal> := class(ecosystem_entitlement) {
    Consumable<override><final>: logic = external {}
  }
}

# Module import path: /UnrealEngine.com/StateMachine
(/UnrealEngine.com:)StateMachine<public> := module {
  # Creates a new unique state handle. Each call returns a handle with a unique Id.
  MakeStateHandle<native><public>(): state_handle

  using { /Verse.org/StateMachine }
  # Module import path: /UnrealEngine.com/StateMachine/Patterns
  Patterns<public> := module {
    # Makes states from a list of factories.  Try each factory until one succeeds.  Returns the leaf states of the first factory that succeed.  Fails if no factory succeed.
    LinearSelector<epic_internal>(Factories: []type { _()<transacts><decides>: make_leaves_result })<transacts><decides>: select_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory until one succeeds.  Returns the leaf states of the first factory that succeed.  Fails if no factory succeed.  Used when the states can be injected or dynamic.
    LinearSelectorFrom<epic_internal>((Parent: t, Factories: []type { _(: t)<transacts><decides>: make_leaves_result }) where t: type)<transacts><decides>: select_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in order and compare the weighted score of each factory.  The factory with the biggest weighted score wins.  Returns the leaf states of the factory that succeed and has the biggest score.  Fails if no factory succeed.
    MaxWeightSelector<epic_internal>(Factories: []type { _()<transacts><decides>: scored_leaves_result })<transacts><decides>: select_scored_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in order and compare the weighted score of each factory.  The factory with the biggest weighted score wins.  Returns the leaf states of the factory that succeed  and has the biggest score.  Fails if no factory succeed.  Used when the states can be injected or dynamic.
    MaxWeightSelectorFrom<epic_internal>((Parent: t, Factories: []type { _(: t)<transacts><decides>: scored_leaves_result }) where t: type)<transacts><decides>: select_scored_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in a random order until one succeeds.  Returns the leaf states of the first random factory that succeed.  Fails if no factory succeed.
    RandomSelector<epic_internal>(Factories: []type { _()<transacts><decides>: make_leaves_result })<transacts><decides>: select_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in a random order until one succeeds.  Returns the leaf states of the first random factory that succeed.  Fails if no factory succeed.  Used when the states can be injected or dynamic.
    RandomSelectorFrom<epic_internal>((Parent: t, Factories: []type { _(: t)<transacts><decides>: make_leaves_result }) where t: type)<transacts><decides>: select_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in the sequence from the provided Index.  Returns the leaf states of the first factory that succeed from Index.  Fails if no factory succeed.
    TrySequencer<epic_internal>(Factories: []type { _()<transacts><decides>: make_leaves_result }, Index: int)<transacts><decides>: select_leaves_result = external {}

    # Makes states from a list of factories.  Try each factory in the sequence from the provided Index.  Returns the leaf states of the first factory that succeed from Index.  Fails if no factory succeed.  Used when the states can be injected or dynamic.
    TrySequencerFrom<epic_internal>((Parent: t, Factories: []type { _(: t)<transacts><decides>: make_leaves_result }, Index: int) where t: type)<transacts><decides>: select_leaves_result = external {}
  }

  # The result of a MakeLeaves function.  Contains the terminal states of the selection.  It can returns more than one leaf if it contains parallel states.
  make_leaves_result<epic_internal> := struct {
    Leaves: []state = external {}
  }

  make_state_result<epic_internal>(state_type: type) := struct {
    Leaves: []state

    State: state_type
  }

  # The result of a MakeLeaves with an heuristic function.  Contains the terminal states of the selection and the index of the selected factory.
  scored_leaves_result<epic_internal> := struct {
    Leaves: []state = external {}

    Score: float
  }

  # The result of a selector pattern such as LinearSelector or RandomSelector.  Contains the terminal states of the selection and the index of the selected factory.
  select_leaves_result<epic_internal> := struct {
    Index: int

    Leaves: []state = external {}
  }

  # The result of a heuristic selector pattern such as UtilitiesWeightedSelector. .  Contains the terminal states of the selection and the index of the selected factory.
  select_scored_leaves_result<epic_internal> := struct {
    Index: int

    Leaves: []state = external {}

    Score: float
  }

  # Event sent via SendUp when a final state completes.  Propagates up the parent chain until a parent handles it in OnReceive.
  state_completed_event<epic_internal> := class(state_event) {
    Result<public>: state_completed_result
  }

  # The result of a state's completion.  Used by final states to signal whether they completed successfully or failed.
  state_completed_result<epic_internal> := enum {
    Failure

    Success
  }

  # A comparable, hashable handle that uniquely identifies a state factory.  Created via MakeStateHandle. Cannot be constructed directly by external code.  Use this to register, unregister, and identify factories.
  state_handle<native><public> := struct<concrete><computes> {
    Id<native>: int = external {}
  }

  # State that starts a suspends task and ends the task when it exits
  suspended_state<epic_internal> := class<abstract><unique><final_super>(state) {
    OnEnter<override>(): void = external {}

    OnExit<override>(): void = external {}

    OnSimulate<public>()<suspends>: void = external {}
  }
}

Temporary<public> := module {
  # Module import path: /UnrealEngine.com/Temporary/Curves
  Curves<public> := module {
    editable_curve<native><public> := class<final><concrete> {
      # Evaluates this float curve at the specified time and returns the result as a float
      Evaluate<native><public>(Time: float): float
    }
  }

  # Module import path: /UnrealEngine.com/Temporary/Diagnostics
  Diagnostics<public> := module {
    # debug draw class to draw debug shapes on screen.
    debug_draw<native><public> := class {
      # Channel will be used to clear specific debug draw.
      Channel<native><public>: subtype(debug_draw_channel) = external {}

      # Clears all debug draw from this debug_draw instance.
      Clear<native><public>()<transacts>: void

      # Clears all debug draw for the channel.
      ClearChannel<native><public>()<transacts>: void

      # Draws an arrow pointing from Start to End locations, and using the provided draw parameters.
      DrawArrow<native><public>(
        Start: (/Verse.org/SpatialMath:)vector3,
        End: (/Verse.org/SpatialMath:)vector3,
        ?ArrowSize: float = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws an arrow pointing from Start to End locations, and using the provided draw parameters.
      DrawArrow<public>(
        Start: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        End: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        ?ArrowSize: float = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void = external {}

      # Draws a box at the named location, and using the provided draw parameters
      DrawBox<native><public>(
        Center: (/Verse.org/SpatialMath:)vector3,
        Rotation: (/Verse.org/SpatialMath:)rotation,
        ?Extent: (/Verse.org/SpatialMath:)vector3 = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws a box at the named location, and using the provided draw parameters
      DrawBox<public>(
        Center: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
        ?Extent: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void = external {}

      # Draws a capsule at the named location, and using the provided draw parameters.
      DrawCapsule<native><public>(
        Center: (/Verse.org/SpatialMath:)vector3,
        Rotation: (/Verse.org/SpatialMath:)rotation,
        ?Height: float = external {},
        ?Radius: float = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws a capsule at the named location, and using the provided draw parameters.
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

      # Draws a cone at the named location, and using the provided draw parameters.
      DrawCone<native><public>(
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

      # Draws a cone at the named location, and using the provided draw parameters.
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

      # Draws a cylinder at the named location, and using the provided draw parameters.
      DrawCylinder<native><public>(
        Start: (/Verse.org/SpatialMath:)vector3,
        End: (/Verse.org/SpatialMath:)vector3,
        ?NumSegments: int = external {},
        ?Radius: float = external {},
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws a cylinder at the named location, and using the provided draw parameters.
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

      # Draws a line from Start to End locations, and using the provided draw parameters.
      DrawLine<native><public>(
        Start: (/Verse.org/SpatialMath:)vector3,
        End: (/Verse.org/SpatialMath:)vector3,
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws a line from Start to End locations, and using the provided draw parameters.
      DrawLine<public>(
        Start: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        End: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void = external {}

      # Draws a point at the named location, and using the provided draw parameters.
      DrawPoint<native><public>(
        Position: (/Verse.org/SpatialMath:)vector3,
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws a point at the named location, and using the provided draw parameters.
      DrawPoint<public>(
        Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        ?Color: color = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void = external {}

      # Draws a sphere at the named location, and using the provided draw parameters.
      DrawSphere<native><public>(
        Center: (/Verse.org/SpatialMath:)vector3,
        ?Radius: float = external {},
        ?Color: color = external {},
        ?NumSegments: int = external {},
        ?Thickness: float = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {}
      )<transacts>: void

      # Draws a sphere at the named location, and using the provided draw parameters.
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
      DrawText<native><public>(
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
      HideChannel<native><public>()<transacts>: void

      # Show Debug Draw for the channel for all users.
      ShowChannel<native><public>()<transacts>: void
    }

    # debug_draw_channel is the base class used to define debug draw channels.
    debug_draw_channel<native><public> := class<abstract> {}

    using { /UnrealEngine.com/Temporary/SpatialMath }
    using { /Verse.org/Colors }
    using { /Verse.org/Native }
    using { /Verse.org/SpatialMath }
    # Enumerated presets for policies describing a desired draw duration.
    debug_draw_duration_policy<native><public> := enum {
      FiniteDuration

      Persistent

      SingleFrame
    }

    # log class to send messages to the default log
    log<native><public> := class {
      # Channel class name will be added as a prefix used when printing the message e.g. '[log_channel]: #Message
      Channel<native><public>: subtype(log_channel)

      @available { MinUploadedAtFNVersion := 4000 }
      # Sets the current debug diagnostic display `Color` that will be applied to all future Print calls. By default, `Color` is `NamedColors.White`, Only used if Duration is greater than `0.0`.
      Color<native><epic_internal>: color = external {}

      # Sets the default log level of the displayed message. See log_level enum for more info on log levels. Defaults to log_level.Normal.
      DefaultLevel<native><public>: log_level = external {}

      @available { MinUploadedAtFNVersion := 4000 }
      # If set to greater than 0.0, displays the log on the screen in debug environments.
      Duration<native><epic_internal>: float = external {}

      # Print `Message` using the given log level.
      (/UnrealEngine.com/Temporary/Diagnostics/log:)Print<epic_internal>(Message: message, ?Level: log_level = external {})<reads>: void = external {}

      # Print `Message` diagnostic using the given log level.
      (/UnrealEngine.com/Temporary/Diagnostics/log:)Print<public>(Message: diagnostic, ?Level: log_level = external {})<computes>: void = external {}

      # Print `Message` using the given log level.
      (/UnrealEngine.com/Temporary/Diagnostics/log:)Print<public>(Message: string, ?Level: log_level = external {})<computes>: void = external {}

      # Prints the current script call stack using the given log level.
      PrintCallStack<native><public>(?Level: log_level = external {})<computes>: void
    }

    # log_channel is the base class used to define log channels. When printing a message to a log, the log channel class name will be prefixed to the output message.
    log_channel<native><public> := class<abstract> {}

    # log levels available for various log commands
    log_level<native><public> := enum {
      Debug

      Error

      Normal

      Verbose

      Warning
    }
  }

  # Stably sort `Array` using `Less` where `Less` succeeding indicates `Left` should precede `Right`
  SortBy<native><public>((Array: []t, Less: type { _(: t, : t)<computes><decides>: void }) where t: type)<computes>: []t

  # Module import path: /UnrealEngine.com/Temporary/SpatialMath
  (/UnrealEngine.com/Temporary:)SpatialMath<public> := module {
    # Makes a `rotation` by applying `AngleRadians` of left-handed rotation around the local +Y axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyLocalRotationY<public>(AngleRadians: float)<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {}

    # Makes a `rotation` by applying `AngleRadians` of left-handed rotation around the local +Z axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyLocalRotationZ<public>(AngleRadians: float)<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {}

    # Makes a `rotation` by applying `PitchUpRadians` of right-handed rotation around the local +Y axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyPitch<native><public>(PitchUpRadians: float)<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by applying `RollClockwiseRadians` of right-handed rotation around the local +X axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyRoll<native><public>(RollClockwiseRadians: float)<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by applying `AngleRadians` of left-handed rotation around the world +X axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyWorldRotationX<native><public>(AngleRadians: float)<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by applying `AngleRadians` of left-handed rotation around the world +Y axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyWorldRotationY<native><public>(AngleRadians: float)<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by applying `AngleRadians` of left-handed rotation around the world +Z axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyWorldRotationZ<native><public>(AngleRadians: float)<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by applying `YawRightRadians` of left-handed rotation around the local +Z axis to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).ApplyYaw<native><public>(YawRightRadians: float)<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by composing `AdditionalRotation` to `InitialRotation`.
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).RotateBy<native><public>(AdditionalRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation)<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `rotation` by composing the inverse of `RotationToRemove` from `InitialRotation`. such that InitialRotation = RotateBy(UnrotateBy(InitialRotation, RotationToRemove), RotationToRemove). This is equivalent to RotateBy(InitialRotation, InvertRotation(RotationToRemove))
    (InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).UnrotateBy<native><public>(RotationToRemove: (/UnrealEngine.com/Temporary/SpatialMath:)rotation)<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    @vm_no_effect_token
    # Makes a `vector3` from the axis of `rotation`.
    # If `rotation` is nearly identity, this will return the +X axis. See also `GetAngle`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).(/UnrealEngine.com/Temporary/SpatialMath:)GetAxis<native><public>()<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3

    @vm_no_effect_token
    # Makes an `[]float` with three elements:
    #  * *yaw* degrees of `rotation`
    #  * *pitch* degrees of `rotation`
    #  * *roll* degrees of `rotation`
    # using the conventions of `MakeRotationFromYawPitchRollDegrees`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).(/UnrealEngine.com/Temporary/SpatialMath:)GetYawPitchRollDegrees<native><public>()<reads>: []float

    # Makes a `rotation` by inverting `Rotation` such that `ApplyRotation(Rotation, Rotation.Invert())) = IdentityRotation`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).(/UnrealEngine.com/Temporary/SpatialMath:)Invert<native><public>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Returns `Rotation` if it does not contain `NaN`, `Inf` or `-Inf`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).(/UnrealEngine.com/Temporary/SpatialMath:)IsFinite<native><public>()<decides><converges>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    @vm_no_effect_token
    # Returns the radians of `rotation` around the axis of `rotation`. See also `GetAxis`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).GetAngle<native><public>()<reads>: float

    # Makes a unit `vector3` pointing in the local space *forward* direction in world space coordinates.
    # This is equivalent to: `RotateVector(Rotation, vector3{X:=1.0, Y:=0.0, Z:=0.0})`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).GetLocalForward<public>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a unit `vector3` pointing in the the local space *right* direction in world space coordinates.
    # This is equivalent to: `RotateVector(Rotation, vector3{X:=0.0, Y:=1.0, Z:=0.0})`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).GetLocalRight<public>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a unit `vector3` pointing in the local space *up* direction in world space coordinates.
    # This is equivalent to: `RotateVector(Rotation, vector3{X:=0.0, Y:=0.0, Z:=1.0})`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).GetLocalUp<public>()<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    @vm_no_effect_token
    # Makes a `vector3` by applying `Rotation` to `Vector`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).RotateVector<native><public>(Vector: (/UnrealEngine.com/Temporary/SpatialMath:)vector3)<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3

    @vm_no_effect_token
    # Makes a `vector3` by applying the inverse of `Rotation` to `Vector`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).UnrotateVector<native><public>(Vector: (/UnrealEngine.com/Temporary/SpatialMath:)vector3)<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3

    # Succeeds when each component of `V` is within `AbsoluteTolerance` of `0.0`.
    (V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3).(/UnrealEngine.com/Temporary/SpatialMath:)IsAlmostZero<public>(AbsoluteTolerance: float)<computes><decides>: void = external {}

    # Returns `V` if all components are finite.
    # Fails if any of the components are not finite.
    (V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3).(/UnrealEngine.com/Temporary/SpatialMath:)IsFinite<public>()<computes><decides>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Returns the length of `V`.
    (V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3).(/UnrealEngine.com/Temporary/SpatialMath:)Length<public>()<reads>: float = external {}

    # Returns the squared length of `V`.
    (V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3).(/UnrealEngine.com/Temporary/SpatialMath:)LengthSquared<public>()<computes>: float = external {}

    # Makes a unit length `vector3` pointing in the same direction of `V`.
    # Fails if `V.IsAlmostZero[] or not V.IsFinite[]`.
    (V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3).(/UnrealEngine.com/Temporary/SpatialMath:)MakeUnitVector<public>()<reads><decides>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Returns the squared length of `V` as if `V.Z = 0.0`.
    (V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3).LengthSquaredXY<public>()<reads>: float = external {}

    # Returns the length of `V` as if `V.Z = 0.0`.
    (V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3).LengthXY<public>()<reads>: float = external {}

    # Succeeds when each component of `V` is within `AbsoluteTolerance` of `0.0`.
    (V: vector2).(/UnrealEngine.com/Temporary/SpatialMath:)IsAlmostZero<public>(AbsoluteTolerance: float)<computes><decides>: void = external {}

    # Returns `V` if all components are finite.
    # Fails if any of the components are not finite.
    (V: vector2).(/UnrealEngine.com/Temporary/SpatialMath:)IsFinite<public>()<computes><decides>: vector2 = external {}

    # Returns the length of `V`.
    (V: vector2).(/UnrealEngine.com/Temporary/SpatialMath:)Length<public>()<reads>: float = external {}

    # Returns the squared length of `V`.
    (V: vector2).(/UnrealEngine.com/Temporary/SpatialMath:)LengthSquared<public>()<reads>: float = external {}

    # Makes a unit length `vector2` pointing in the same direction of `V`.
    # Fails if `V.IsAlmostZero[] or not V.IsFinite[]`.
    (V: vector2).(/UnrealEngine.com/Temporary/SpatialMath:)MakeUnitVector<public>()<reads><decides>: vector2 = external {}

    @vm_no_effect_token
    # Returns the 'smallest angular distance' between `Rotation1` and `Rotation2` in radians.
    AngularDistance<native><public>(
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
    # Returns the 'distance' between `Rotation1` and `Rotation2`. The result will be between:
    #  * `0.0`, representing equivalent rotations and
    #  * `1.0` representing rotations which are 180 degrees apart (i.e., the shortest rotation between them is 180 degrees around some axis).
    (/UnrealEngine.com/Temporary/SpatialMath:)Distance<native><public>(
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
    (/UnrealEngine.com/Temporary/SpatialMath:)DistanceSquared<public>(V1: vector2, V2: vector2)<reads>: float = external {}

    # Returns the squared 2-D Euclidean distance between `V1` and `V2` by ignoring their difference in `Z`.
    DistanceSquaredXY<public>(
      V1: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      V2: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: float = external {}

    # Returns the 2-D Euclidean distance between `V1` and `V2` by ignoring the difference in `Z`.
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
    (/UnrealEngine.com/Temporary/SpatialMath:)DotProduct<public>(V1: vector2i, V2: vector2i)<computes>: int = external {}

    # Makes a `vector2i` that is component-wise equal to `V1` and `V2`.
    # Fails if any component of `V1` does not equal the corresponding component of `V2`.
    Equals<public>(V1: vector2i, V2: vector2i)<computes><decides>: vector2i = external {}

    @available { MinUploadedAtFNVersion := 3400 }
    # Util function for converting a `rotation` from /UnrealEngine.com/Temporary/SpatialMath to a `rotation` from /Verse.org/SpatialMath.
    FromRotation<public>(InRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation)<reads>: (/Verse.org/SpatialMath:)rotation = external {}

    @available { MinUploadedAtFNVersion := 3400 }
    # Util function for converting a `rotation` from /Verse.org/SpatialMath to a `rotation` from /UnrealEngine.com/Temporary/SpatialMath.
    FromRotation<public>(InRotation: (/Verse.org/SpatialMath:)rotation)<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {}

    @available { MinUploadedAtFNVersion := 3600 }
    # Util function for converting a scalar `vector3` from /UnrealEngine.com/Temporary/SpatialMath to a `vector3` from /Verse.org/SpatialMath.
    # Use this function when your vector indicates a magnitude on each axis but not a direction, such as when you convert a scale measurement rather than a translation or position.
    FromScalarVector3<public>(InVector3: (/UnrealEngine.com/Temporary/SpatialMath:)vector3)<reads>: (/Verse.org/SpatialMath:)vector3 = external {}

    @available { MinUploadedAtFNVersion := 3600 }
    # Util function for converting a scalar `vector3` from /Verse.org/SpatialMath to a `vector3` from /UnrealEngine.com/Temporary/SpatialMath.
    # Use this function when your vector indicates a magnitude on each axis but not a direction, such as when you convert a scale measurement rather than a translation or position.
    FromScalarVector3<public>(InVector3: (/Verse.org/SpatialMath:)vector3)<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    @available { MinUploadedAtFNVersion := 3400 }
    # Util function for converting a `transform` from /UnrealEngine.com/Temporary/SpatialMath to a `transform` from /Verse.org/SpatialMath.
    FromTransform<public>(InTransform: (/UnrealEngine.com/Temporary/SpatialMath:)transform)<reads>: (/Verse.org/SpatialMath:)transform = external {}

    @available { MinUploadedAtFNVersion := 3400 }
    # Util function for converting a `transform` from /Verse.org/SpatialMath to a `transform` from /UnrealEngine.com/Temporary/SpatialMath.
    FromTransform<public>(InTransform: (/Verse.org/SpatialMath:)transform)<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)transform = external {}

    @available { MinUploadedAtFNVersion := 3400 }
    # Util function for converting a translation/position `vector3` from /UnrealEngine.com/Temporary/SpatialMath to a `vector3` from /Verse.org/SpatialMath.
    FromVector3<public>(InVector3: (/UnrealEngine.com/Temporary/SpatialMath:)vector3)<reads>: (/Verse.org/SpatialMath:)vector3 = external {}

    @available { MinUploadedAtFNVersion := 3400 }
    # Util function for converting a translation/position `vector3` from /Verse.org/SpatialMath to a `vector3` from /UnrealEngine.com/Temporary/SpatialMath.
    FromVector3<public>(InVector3: (/Verse.org/SpatialMath:)vector3)<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes the identity `rotation`.
    (/UnrealEngine.com/Temporary/SpatialMath:)IdentityRotation<native><public>()<converges>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Succeeds when each component of `V1` and `V2` are within `AbsoluteTolerance` of each other.
    (/UnrealEngine.com/Temporary/SpatialMath:)IsAlmostEqual<public>(
      V1: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      V2: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      AbsoluteTolerance: float
    )<computes><decides>: void = external {}

    # Succeeds when each component of `V1` and `V2` are within `AbsoluteTolerance` of each other.
    (/UnrealEngine.com/Temporary/SpatialMath:)IsAlmostEqual<public>(V1: vector2, V2: vector2, AbsoluteTolerance: float)<computes><decides>: void = external {}

    # Used to linearly interpolate/extrapolate between `From` (when `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that all arguments are finite.
    # Returns `From*(1 - Parameter) + To*Parameter`.
    (/UnrealEngine.com/Temporary/SpatialMath:)Lerp<public>(
      From: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      To: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      Parameter: float
    )<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Used to linearly interpolate/extrapolate between `From` (when `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that all arguments are finite.
    # Returns `From*(1 - Parameter) + To*Parameter`.
    (/UnrealEngine.com/Temporary/SpatialMath:)Lerp<public>(From: vector2, To: vector2, Parameter: float)<reads>: vector2 = external {}

    # Makes a new `rotation` from the component wise subtraction of the Euler angle components in `RotationA` by
    # the Euler angle components in `RotationB` and ensures the returned value is normalized.
    MakeComponentWiseDeltaRotation<native><public>(
      RotationA: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      RotationB: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    @vm_no_effect_token
    # Makes a `rotation` from `Axis` and `AngleRadians` using a left-handed sign convention (e.g. a positive rotation around +Z takes +X to +Y). If `Axis.IsAlmostZero[]`, make the identity rotation.
    MakeRotation<native><public>(
      Axis: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      AngleRadians: float
    )<reads><converges>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    @vm_no_effect_token
    # Makes a `rotation` by applying `YawRightDegrees`, `PitchUpDegrees`, and `RollClockwiseDegrees`, in that order:
    #  * first a *yaw* about the Z axis with a positive angle indicating a clockwise rotation when viewed from above,
    #  * then a *pitch* about the new Y axis with a positive angle indicating 'nose up',
    #  * followed by a *roll* about the new X axis axis with a positive angle indicating a clockwise rotation when viewed along +X.
    # Note that these conventions differ from `MakeRotation` but match `ApplyYaw`, `ApplyPitch`, and `ApplyRoll`.
    (/UnrealEngine.com/Temporary/SpatialMath:)MakeRotationFromYawPitchRollDegrees<native><public>(
      YawRightDegrees: float,
      PitchUpDegrees: float,
      RollClockwiseDegrees: float
    )<reads><converges>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes the smallest angular `rotation` from `InitialRotation` to `FinalRotation` such that:
    # `InitialRotation.RotateBy(MakeShortestRotationBetween(InitialRotation, FinalRotation)) = FinalRotation` and
    # `MakeShortestRotationBetween(InitialRotation, FinalRotation)?.GetAngle()` is as small as possible.
    (/UnrealEngine.com/Temporary/SpatialMath:)MakeShortestRotationBetween<native><public>(
      InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      FinalRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes the smallest angular `rotation` from `InitialVector` to `FinalVector` such that:
    # `InitialVector.RotateBy(MakeShortestRotationBetween(InitialVector, Vector)) = FinalVector` and
    # `MakeShortestRotationBetween(InitialVector, FinalVector)?.GetAngle()` is as small as possible.
    (/UnrealEngine.com/Temporary/SpatialMath:)MakeShortestRotationBetween<native><public>(
      InitialVector: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      FinalVector: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<transacts>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `vector2` with all components `1.0`.
    Ones2<epic_internal>()<computes>: vector2 = external {}

    # Makes a `vector3` with all components `1.0`.
    (/UnrealEngine.com/Temporary/SpatialMath:)Ones<epic_internal>()<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Returns degrees from `Radians`.
    (/UnrealEngine.com/Temporary/SpatialMath:)RadiansToDegrees<public>(Radians: float)<reads>: float = external {}

    # Makes a `vector3` by inverting the `SurfaceNormal` component of `Direction`.
    # Fails if `not SurfaceNormal.MakeUnitVector[]`.
    (/UnrealEngine.com/Temporary/SpatialMath:)ReflectVector<public>(
      Direction: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      SurfaceNormal: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads><decides>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector2` by inverting the `SurfaceNormal` component of `Direction`.
    # Fails if `not SurfaceNormal.MakeUnitVector[]`.
    (/UnrealEngine.com/Temporary/SpatialMath:)ReflectVector<public>(Direction: vector2, SurfaceNormal: vector2)<reads><decides>: vector2 = external {}

    # Used to perform spherical linear interpolation between `From` (when `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that `0.0 <= Parameter <= 1.0`.
    (/UnrealEngine.com/Temporary/SpatialMath:)Slerp<native><public>(
      InitialRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      FinalRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
      Parameter: float
    )<transacts><decides>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

    # Makes a `string` representation of `InTransform` where the result is on the form.
    # `"Scale: {ToString(`InTransform.Scale`)} Rotation: {ToString(`InTransform.Rotation`)} Translation: {ToString(`InTransform.Translation`)}.
    (/UnrealEngine.com/Temporary/SpatialMath:)ToString<epic_internal>(InTransform: (/UnrealEngine.com/Temporary/SpatialMath:)transform)<reads>: string = external {}

    # Makes a `string` representation of `rotation` in axis/degrees format with a left-handed sign convention.
    # `ToString(MakeRotation(vector3{X:=1.0, Y:=0.0, Z:=0.0}, PiFloat/2.0))` produces the string: `"Axis: {x=1.000000,y=0.000000,z=0.000000} Angle: 90.000000"`.
    (/UnrealEngine.com/Temporary/SpatialMath:)ToString<public>(Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation)<reads>: string = external {}

    # Makes a `string` representation of `V`.
    (/UnrealEngine.com/Temporary/SpatialMath:)ToString<public>(V: (/UnrealEngine.com/Temporary/SpatialMath:)vector3)<reads>: string = external {}

    # Makes a `string` representation of `V`.
    (/UnrealEngine.com/Temporary/SpatialMath:)ToString<public>(V: vector2)<reads>: string = external {}

    # Makes a `string` representation of `V`.
    (/UnrealEngine.com/Temporary/SpatialMath:)ToString<public>(V: vector2i)<computes>: string = external {}

    # Makes a `vector2` by converting the components of `V` to `float`s.
    ToVector2<public>(V: vector2i)<transacts>: vector2 = external {}

    # Makes a `vector2i` by component-wise truncation of `V` to `ints`s.
    ToVector2i<public>(V: vector2)<reads><decides>: vector2i = external {}

    # Makes a `vector3` by applying `InTransform` to `InVector`.
    TransformVector<public>(
      InTransform: (/UnrealEngine.com/Temporary/SpatialMath:)transform,
      InVector: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector3` by applying `InTransform` to `InVector` without applying `InTransform.Scale`.
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
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'*'<public>(Left: float, Right: vector2)<computes>: vector2 = external {}

    # Makes a `vector2i` by multiplying the components of `Right` by `Left`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'*'<public>(Left: int, Right: vector2i)<computes>: vector2i = external {}

    # Makes a `vector2` by component-wise multiplication of `Left` and `Right`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'*'<public>(Left: vector2, Right: float)<computes>: vector2 = external {}

    # Makes a `vector2i` by multiplying the components of `Left` by `Right`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'*'<public>(Left: vector2i, Right: int)<computes>: vector2i = external {}

    # Makes a `vector3` by component-wise addition of `L` and `R`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'+'<public>(
      L: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      R: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector2` by component-wise addition of `Left` and `Right`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'+'<public>(Left: vector2, Right: vector2)<computes>: vector2 = external {}

    # Makes a `vector2i` by component-wise addition of `Left` and `Right`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'+'<public>(Left: vector2i, Right: vector2i)<computes>: vector2i = external {}

    # Makes a `vector3` by component-wise subtraction of `R` from `L`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'-'<public>(
      L: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      R: (/UnrealEngine.com/Temporary/SpatialMath:)vector3
    )<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector2` by component-wise subtraction of `Right` from `Left`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'-'<public>(Left: vector2, Right: vector2)<computes>: vector2 = external {}

    # Makes a `vector2i` by component-wise subtraction of `Right` from `Left`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'-'<public>(Left: vector2i, Right: vector2i)<computes>: vector2i = external {}

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
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'/'<public>(Left: vector2, Right: float)<computes>: vector2 = external {}

    # Makes a `vector2` by component-wise division of `Left` by `Right`.
    (/UnrealEngine.com/Temporary/SpatialMath:)operator'/'<public>(Left: vector2, Right: vector2)<computes>: vector2 = external {}

    # Makes a `vector3` by inverting the signs of `Operand`.
    (/UnrealEngine.com/Temporary/SpatialMath:)prefix'-'<public>(Operand: (/UnrealEngine.com/Temporary/SpatialMath:)vector3)<computes>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

    # Makes a `vector2` by inverting the signs of `Operand`.
    (/UnrealEngine.com/Temporary/SpatialMath:)prefix'-'<public>(Operand: vector2)<computes>: vector2 = external {}

    # Makes a `vector2i` by inverting the signs of `Operand`.
    (/UnrealEngine.com/Temporary/SpatialMath:)prefix'-'<public>(Operand: vector2i)<computes>: vector2i = external {}

    using { /Verse.org/Native }
    using { /Verse.org/Simulation }
    using { /Verse.org/SpatialMath }
    @editable
    @import_as("/Script/EpicGamesTemporary.FVerseRotation_Deprecated")
    # An abstract representation of an orientation change in 3d-space.
    (/UnrealEngine.com/Temporary/SpatialMath:)rotation<native><public> := struct<concrete> {}

    # A combination of scale, rotation, and translation, applied in that order.
    (/UnrealEngine.com/Temporary/SpatialMath:)transform<native><public> := struct<concrete><computes> {
      @editable
      # The rotation of this `transform`.
      Rotation<native><public>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {}

      @editable
      # The scale of this `transform`.
      Scale<native><public>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

      @editable
      # The location of this `transform`.
      Translation<native><public>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}
    }

    # 2-dimensional vector with `float` components.
    vector2<native><public> := struct<concrete><computes><persistable> {
      @editable
      X<native><public>: float = external {}

      @editable
      Y<native><public>: float = external {}
    }

    # 2-dimensional vector with `int` components.
    vector2i<native><public> := struct<concrete><computes><persistable> {
      @editable
      X<native><public>: int = external {}

      @editable
      Y<native><public>: int = external {}
    }

    # 3-dimensional vector with `float` components.
    (/UnrealEngine.com/Temporary/SpatialMath:)vector3<native><public> := struct<concrete><computes><persistable> {
      @editable
      X<native><public>: float = external {}

      @editable
      Y<native><public>: float = external {}

      @editable
      Z<native><public>: float = external {}
    }
  }

  # Module import path: /UnrealEngine.com/Temporary/Testing
  Testing<public> := module {
    # test_reporter is a test result aggregator that writes test results to a log stream and can compile and print a summary of test results.
    test_reporter<native><epic_internal> := class {
      # Sets the default log level of the displayed message. See log_level enum for more info on log levels. Defaults to log_level.Normal.
      DefaultLevel<native><epic_internal>: log_level = external {}

      # Returns a string of the test results summary.
      GetSummaryStrings<native><epic_internal>(?Level: log_level = external {}): []string

      # Logs `Message` to the `test_reporter` log stream. This allows users to add context for results to the summary.
      (/UnrealEngine.com/Temporary/Testing/test_reporter:)Log<native><epic_internal>(Message: string, ?Level: log_level = external {}): void

      # The name of this `test_reporter`. Used when displaying results summary.
      Name<native><epic_internal>: string = external {}

      # Prints a summary of test results to the log stream.
      PrintSummary<native><epic_internal>(?Level: log_level = external {}): void

      # Prints a json summary of test results to the log stream.
      PrintSummaryJson<native><epic_internal>(): void

      # Report a test result of `Blocked`. `Category` and `SubCategory` are used to calculate test result stats as part of printing the summary.
      ReportTestBlocked<native><epic_internal>(
        Message: string,
        ?Category: string = external {},
        ?SubCategory: string = external {},
        ?StartTimeSec: float = external {},
        ?DurationSec: float = external {}
      ): void

      # Report a test result of `Failed`. `Category` and `SubCategory` are used to calculate test result stats as part of printing the summary.
      ReportTestFailed<native><epic_internal>(
        Message: string,
        ?Category: string = external {},
        ?SubCategory: string = external {},
        ?StartTimeSec: float = external {},
        ?DurationSec: float = external {}
      ): void

      # Report a test result of `Passed`. `Category` and `SubCategory` are used to calculate test result stats as part of printing the summary.
      ReportTestPassed<native><epic_internal>(
        Message: string,
        ?Category: string = external {},
        ?SubCategory: string = external {},
        ?StartTimeSec: float = external {},
        ?DurationSec: float = external {}
      ): void

      # Report a test result of `Result`. `Category` and `SubCategory` are used to calculate test result stats as part of printing the summary.
      ReportTestResult<native><epic_internal>(
        Message: string,
        Result: test_result,
        ?Category: string = external {},
        ?SubCategory: string = external {},
        ?StartTimeSec: float = external {},
        ?DurationSec: float = external {}
      ): void

      # Report a test result of `Skipped`. `Category` and `SubCategory` are used to calculate test result stats as part of printing the summary.
      ReportTestSkipped<native><epic_internal>(
        Message: string,
        ?Category: string = external {},
        ?SubCategory: string = external {},
        ?StartTimeSec: float = external {},
        ?DurationSec: float = external {}
      ): void

      # Resets test results.
      Reset<native><epic_internal>(): void
    }

    using { /UnrealEngine.com/Temporary/Diagnostics }
    # test result outcomes
    test_result<native><epic_internal> := enum {
      Blocked

      Failed

      Passed

      Skipped
    }
  }

  # Module import path: /UnrealEngine.com/Temporary/UI
  (/UnrealEngine.com/Temporary:)UI<public> := module {
    # Returns the `player_ui` associated with `Player`.
    # Fails if there is no `player_ui` associated with `Player`.
    GetPlayerUI<native><public>(Player: player)<transacts><decides>: player_ui

    # Make a canvas slot for fixed position widget.
    # If Size is set, then the Offsets is calculated and the SizeToContent is set to false.
    # If Size is not set, then Right and Bottom are set to zero and are not used. The widget size will be automatically calculated. The SizeToContent is set to true.
    # The widget is not anchored and will not move if the parent is resized.
    # The Anchors is set to zero.
    MakeCanvasSlot<native><public>(Widget: widget, Position: vector2, ?Size: vector2 = external {}, ?ZOrder: type { _X: int where 0 <= _X, _X <= 2147483647 } = external {}, ?Alignment: vector2 = external {})<computes>: canvas_slot

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

    ___DefaultEmptyString_Internal<localizes><epic_internal>: message = external {}

    # The anchors of a `widget` determine its the position and sizing relative to its parent.
    # `anchor`s range from `(0.0, 0.0)` (left, top) to `(1.0, 1.0)` (right, bottom).
    anchors<native><public> := struct {
      # Holds the maximum anchors, (right, bottom). The valid range is between `0.0` and `1.0`.
      Maximum<native><public>: vector2 = external {}

      # Holds the minimum anchors, (left, top). The valid range is between `0.0` and `1.0`.
      Minimum<native><public>: vector2 = external {}
    }

    # Button is a container of a single child widget slot and fires the OnClick event when the button is clicked.
    button<native><public> := class<final>(widget) {
      HighlightEvent<public>(): listenable(widget_message) = external {}

      # Subscribable event that fires when the button is clicked.
      OnClick<public>(): listenable(widget_message) = external {}

      # Sets the child widget slot.
      SetWidget<native><public>(InSlot: button_slot): void

      # The child widget of the button. Used only during initialization of the widget and not modified by SetSlot.
      Slot<native><public>: button_slot

      UnhighlightEvent<public>(): listenable(widget_message) = external {}

      # The UI input action that will trigger the Click event of this button.
      var TriggeringInputAction<public>: ?input_action(logic) = external {}
    }

    # Slot for button widget.
    button_slot<native><public> := struct {
      # Horizontal alignment of the widget inside the slot.
      HorizontalAlignment<native><public>: horizontal_alignment = external {}

      # Empty distance in pixels that surrounds the widget inside the slot. Assumes 1080p resolution.
      Padding<native><public>: margin = external {}

      # Vertical alignment of the widget inside the slot.
      VerticalAlignment<native><public>: vertical_alignment = external {}

      # The widget assigned to this slot.
      Widget<native><public>: widget
    }

    # Canvas is a container widget that allows for arbitrary positioning of widgets in the canvas' slots.
    canvas<native><public> := class<final>(widget) {
      # Adds a new child slot to the canvas.
      AddWidget<native><public>(Slot: canvas_slot): void

      # Removes a slot containing the given widget.
      RemoveWidget<native><public>(Widget: widget): void

      # The child widgets of the canvas. Used only during initialization of the widget and not modified by Add/RemoveWidget.
      Slots<native><public>: []canvas_slot = external {}
    }

    # Slot for a canvas widget.
    canvas_slot<native><public> := struct {
      # Alignment is the pivot/origin point of the widget.
      # Starting in the upper left at (0.0,0.0), ending in the lower right at (1.0,1.0).
      Alignment<native><public>: vector2 = external {}

      # The border for the margin and how the widget is resized with its parent.
      # Values are defined between 0.0 and 1.0.
      Anchors<native><public>: anchors = external {}

      # The offset that defined the size and position of the widget.
      # When the anchors are well defined, the Offsets.Left represent the distance in pixels from the Anchors Minimum.X, the Offsets.Bottom represent the distance in pixel from the Anchors Maximum.Y, effectively controlling the desired widget size. When the anchors are not well defined, the Offsets.Left and Offsets.Top represent the widget position and Offsets.Right and Offset.Bottom represent the widget size.
      Offsets<native><public>: margin = external {}

      # When true we use the widget's desired size. The size calculated by the Offsets is ignored.
      SizeToContent<native><public>: logic = external {}

      # The widget assigned to this slot.
      Widget<native><public>: widget

      # Z Order of this slot relative to other slots in this canvas panel.
      # Higher values are rendered last (and so they will appear to be on top)
      ZOrder<native><public>: type { _X: int where 0 <= _X, _X <= 2147483647 } = external {}
    }

    # A solid color widget.
    color_block<native><public> := class<final>(widget) {
      # The color of the widget. Used only during initialization of the widget and not modified by SetColor.
      DefaultColor<native><public>: color = external {}

      # The size this widget desired to be displayed in. Used only during initialization of the widget and not modified by SetDesiredSize.
      DefaultDesiredSize<native><public>: vector2 = external {}

      # The opacity of the widget. Used only during initialization of the widget and not modified by SetOpacity.
      DefaultOpacity<native><public>: type { _X: float where 0.000000 <= _X, _X <= 1.000000 } = external {}

      # Gets the widget's color.
      GetColor<native><public>(): color

      # Gets the size this widget desired to be displayed in.
      GetDesiredSize<native><public>(): vector2

      # Gets the widget's opacity.
      GetOpacity<native><public>(): type { _X: float where 0.000000 <= _X, _X <= 1.000000 }

      # Sets the widget's color.
      SetColor<native><public>(InColor: color): void

      # Sets the size this widget desired to be displayed in.
      SetDesiredSize<native><public>(InDesiredSize: vector2): void

      # Sets the widgets's opacity.
      SetOpacity<native><public>(InOpacity: type { _X: float where 0.000000 <= _X, _X <= 1.000000 }): void
    }

    # `widget` horizontal alignment mode.
    horizontal_alignment<native><public> := enum {
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
    image_tiling<native><public> := enum {
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

    # Specifies the gap outside each edge separating a `widget` from its neighbors.
    # Distance is measured in units where `1.0` unit is the width of a pixel at 1080p resolution.
    margin<native><public> := struct {
      # The bottom edge spacing.
      Bottom<native><public>: float = external {}

      # The left edge spacing.
      Left<native><public>: float = external {}

      # The right edge spacing.
      Right<native><public>: float = external {}

      # The top edge spacing.
      Top<native><public>: float = external {}
    }

    # A widget to display a material.
    material_block<native><public> := class(widget) {
      # The size this widget desired to be displayed in. Used only during initialization of the widget and not modified by SetDesiredSize.
      DefaultDesiredSize<native><public>: vector2 = external {}

      # The image to render. Used only during initialization of the widget and not modified by SetImage.
      DefaultImage<native><public>: material

      # Tinting applied to the image. Used only during initialization of the widget and not modified by SetTint.
      DefaultTint<native><public>: color = external {}

      # Gets the size this widget desired to be displayed in.
      GetDesiredSize<native><public>(): vector2

      # Gets the image to render.
      GetImage<native><public>(): material

      # Gets the tint applied to the image.
      GetTint<native><public>(): color

      # Sets the size this widget desired to be displayed in.
      SetDesiredSize<native><public>(InDesiredSize: vector2): void

      # Sets the image to render.
      SetImage<native><public>(InImage: material): void

      # Sets the tint applied to the image.
      SetTint<native><public>(InColor: color): void
    }

    # Used by`widget` orientation modes.
    orientation<native><public> := enum {
      # Orient `widget`s from left to right.
      Horizontal

      # Orient `widget`s from top to bottom.
      Vertical
    }

    # Overlay is a container consisting of widgets stacked on top of each other.
    overlay<native><public> := class<final>(widget) {
      # Add a new child slot to the overlay. Slots are added at the end.
      AddWidget<native><public>(Slot: overlay_slot): void

      # Removes a slot containing the given widget
      RemoveWidget<native><public>(Widget: widget): void

      # The child widgets of the overlay. Used only during initialization of the widget and not modified by Add/RemoveWidget.
      Slots<native><public>: []overlay_slot = external {}
    }

    # Slot for an overlay widget
    overlay_slot<native><public> := struct {
      # Horizontal alignment of the widget inside the slot.
      # This alignment is only applied after the layout space for the widget slot is created and determines the widget alignment within that space.
      HorizontalAlignment<native><public>: horizontal_alignment = external {}

      # Empty distance in pixels that surrounds the widget inside the slot. Assumes 1080p resolution.
      Padding<native><public>: margin = external {}

      # Vertical alignment of the widget inside the slot.
      # This alignment is only applied after the layout space for the widget slot is created and determines the widget alignment within that space.
      VerticalAlignment<native><public>: vertical_alignment = external {}

      # The widget assigned to this slot.
      Widget<native><public>: widget
    }

    # The main interface for adding and removing `widget`s to a player's UI.
    player_ui<native><public> := class<final><epic_internal> {
      # Adds `Widget` to this `player_ui` using default `player_ui_slot` configuration options.
      AddWidget<native><public>(Widget: widget): void

      # Adds `Widget` to this `player_ui` using `Slot` for configuration options.
      AddWidget<native><public>(Widget: widget, Slot: player_ui_slot): void

      # Removes `Widget` from this `player_ui`.
      RemoveWidget<native><public>(Widget: widget): void

      # Sets the user's focus on this `Widget`. The target `Widget`must be focusable, otherwise this has no effect.
      # If `SetFocus` is called before `AddWidget`, the `widget` will be focused after `AddWidget` is called,
      # unless a SetFocus is called on a different `widget` by the time `AddWidget` is called.
      SetFocus<native><public>(Widget: widget): void
    }

    # `widget` creation configuration options.
    player_ui_slot<native><public> := struct {
      # Controls `widget` input event consumption.
      InputMode<native><public>: ui_input_mode = external {}

      # Controls `widget` rendering order. Greater values will be draw in front of lesser values.
      ZOrder<native><public>: type { _X: int where 0 <= _X, _X <= 2147483647 } = external {}
    }

    # Safe zone box is a container of a single child widget slot that ensures its slot content stays out of unsafe zone across platforms.
    safezone_box<native><epic_internal> := class<final>(widget) {
      # Sets the child widget slot.
      SetWidget<native><public>(InSlot: safezone_box_slot): void

      # The child widget of the safe zone. Used only during initialization of the widget and not modified by SetWidget.
      Slot<native><public>: safezone_box_slot
    }

    # Slot for safe zone box widget.
    safezone_box_slot<native><epic_internal> := struct {
      # The widget assigned to this slot.
      Widget<native><public>: widget
    }

    # Stack box is a container of a list of widgets stacked either vertically or horizontally.
    stack_box<native><public> := class<final>(widget) {
      # Add a new child slot to the stack box. Slots are added at the end.
      AddWidget<native><public>(Slot: stack_box_slot): void

      # The orientation of the stack box. Either stack widgets horizontal or vertical.
      Orientation<native><public>: orientation

      # Removes a slot containing the given widget
      RemoveWidget<native><public>(Widget: widget): void

      # The child widgets of the stack box. Used only during initialization of the widget and not modified by Add/RemoveWidget.
      Slots<native><public>: []stack_box_slot = external {}
    }

    # Slot for a stack_box widget
    stack_box_slot<native><public> := struct {
      # The available space will be distributed proportionally.
      # If not set, the slot will use the desired size of the widget.
      Distribution<native><public>: ?float = external {}

      # Horizontal alignment of the widget inside the slot.
      # This alignment is only applied after the layout space for the widget slot is created and determines the widget alignment within that space.
      HorizontalAlignment<native><public>: horizontal_alignment = external {}

      # Empty distance in pixels that surrounds the widget inside the slot. Assumes 1080p resolution.
      Padding<native><public>: margin = external {}

      # Vertical alignment of the widget inside the slot.
      # This alignment is only applied after the layout space for the widget slot is created and determines the widget alignment within that space.
      VerticalAlignment<native><public>: vertical_alignment = external {}

      # The widget assigned to this slot.
      Widget<native><public>: widget
    }

    # Base widget for text widget.
    text_base<native><public> := class<abstract>(widget) {
      # The justification to display to the user. Used only during initialization of the widget and not modified by SetJustification.
      DefaultJustification<native><public>: text_justification = external {}

      # The policy that determine what happens when the text is longer than its allowed length.
      # Used only during initialization of the widget and not modified by SetOverflowPolicy.
      DefaultOverflowPolicy<native><public>: text_overflow_policy = external {}

      # The text to display to the user. Used only during initialization of the widget and not modified by SetText.
      DefaultText<native><localizes><public>: message = external {}

      # The color of the displayed text. Used only during initialization of the widget and not modified by SetTextColor.
      DefaultTextColor<native><public>: color = external {}

      # The opacity of the displayed text. Used only during initialization of the widget and not modified by SetTextOpacity.
      DefaultTextOpacity<native><public>: type { _X: float where 0.000000 <= _X, _X <= 1.000000 } = external {}

      # The size of the displayed text. Used only during initialization of the widget and not modified by SetTextSize.
      DefaultTextSize<native><public>: float = external {}

      # Gets the text justification in the widget.
      GetJustification<native><public>(): text_justification

      # Gets the policy that determine what happens when the text is longer than its allowed length.
      GetOverflowPolicy<native><public>(): text_overflow_policy

      # Gets the text currently in the widget.
      GetText<native><public>(): string

      # Gets the color of the displayed text.
      GetTextColor<native><public>(): color

      # Gets the opacity of the displayed text.
      GetTextOpacity<native><public>(): type { _X: float where 0.000000 <= _X, _X <= 1.000000 }

      # Gets the size of the displayed text.
      GetTextSize<native><public>(): float

      # Sets the text justification in the widget.
      SetJustification<native><public>(InJustification: text_justification): void

      # Sets the policy that determine what happens when the text is longer than its allowed length.
      SetOverflowPolicy<native><public>(InOverflowPolicy: text_overflow_policy): void

      # Sets the text displayed in the widget.
      SetText<native><public>(InText: message): void

      # Sets the color of the displayed text.
      SetTextColor<native><public>(InColor: color): void

      # Sets the opacity of the displayed text.
      SetTextOpacity<native><public>(InOpacity: type { _X: float where 0.000000 <= _X, _X <= 1.000000 }): void

      # Sets the size of the displayed text.
      SetTextSize<native><public>(InSize: float): void

      # Whether the text should be automatically wrapped.
      var AutoWrap<public>: logic = external {}

      # Whether text wraps onto a new line when it's length exceeds this width; if this value is zero or negative, no wrapping occurs.
      var WrapWidth<public>: float = external {}

      # The wrapping policy to determine where the line can be broken.
      var WrappingPolicy<public>: text_wrapping_policy = external {}
    }

    # Text block widget. Displays text to the user.
    text_block_internal<native><epic_internal> := class(text_base) {}

    # Text justification values:
    #   Left: Justify the text logically to the left based on current culture.
    #   Center: Justify the text in the center.
    #   Right: Justify the text logically to the right based on current culture.
    # The Left and Right value will flip when the local culture is right-to-left.
    text_justification<native><public> := enum {
      Center

      InvariantLeft

      InvariantRight

      Left

      Right
    }

    # Text overflow policy values:
    #   Clip: Overflowing text will be clipped.
    #   Ellipsis: Overflowing text will be replaced with an ellipsis.
    text_overflow_policy<native><public> := enum {
      Clip

      Ellipsis
    }

    # Text wrapping policy values:
    #   LineBreak: Allows breaking a line only at line-break iterator for wrapping.
    #   PerCharacter: Allows breaking a line after any character for wrapping.
    text_wrapping_policy<native><public> := enum {
      LineBreak

      PerCharacter
    }

    # A widget to display a texture.
    texture_block<native><public> := class(widget) {
      # The size this widget desired to be displayed in. Used only during initialization of the widget and not modified by SetDesiredSize.
      DefaultDesiredSize<native><public>: vector2 = external {}

      # The horizontal tiling option. Used only during initialization of the widget and not modified by SetTiling.
      DefaultHorizontalTiling<native><public>: image_tiling = external {}

      # The image to render. Used only during initialization of the widget and not modified by SetImage.
      DefaultImage<native><public>: texture

      # Tinting applied to the image. Used only during initialization of the widget and not modified by SetTint.
      DefaultTint<native><public>: color = external {}

      # The vertical tiling option. Used only during initialization of the widget and not modified by SetTiling.
      DefaultVerticalTiling<native><public>: image_tiling = external {}

      # Gets the size this widget desired to be displayed in.
      GetDesiredSize<native><public>(): vector2

      # Gets the image to render.
      GetImage<native><public>(): texture

      # Gets the tiling option.
      GetTiling<native><public>(): tuple(image_tiling, image_tiling)

      # Gets the tint applied to the image.
      GetTint<native><public>(): color

      # Sets the size this widget desired to be displayed in.
      SetDesiredSize<native><public>(InDesiredSize: vector2): void

      # Sets the image to render.
      SetImage<native><public>(InImage: texture): void

      # Sets the tiling option when the image is smaller than the allocated size.
      SetTiling<native><public>(InHorizontalTiling: image_tiling, InVerticalTiling: image_tiling): void

      # Sets the tint applied to the image.
      SetTint<native><public>(InColor: color): void
    }

    # `widget` input consumption mode.
    ui_input_mode<native><public> := enum {
      # `widget` consumes all inputs
      All

      # `widget` does not consume any input.
      None
    }

    # Widget created from a umg_widget_class_asset.
    umg_widget<native><epic_internal> := class<epic_internal>(widget) {
      # The widget_blueprint asset to create.
      Asset<native><epic_internal>: umg_widget_class_asset

      GetNamedSlotOptional_<native><epic_internal>(NamedSlotName: []char)<transacts>: ?widget

      GetNamedSlot_<native><epic_internal>(NamedSlotName: []char)<transacts>: widget

      GetViewmodelOptional_<native><epic_internal>(viewmodel_type: type, ViewmodelName: []char)<transacts>: viewmodel_type

      GetViewmodel_<native><epic_internal>(viewmodel_type: type, ViewmodelName: []char)<transacts>: viewmodel_type

      OnPropertyChanged<native><protected>(PropertyName: string)<transacts>: void

      SetNamedSlotOptional_<native><epic_internal>(NamedSlotName: []char, NamedSlotInstance: ?widget)<transacts>: void

      SetNamedSlot_<native><epic_internal>(NamedSlotName: []char, NamedSlotInstance: widget)<transacts>: void

      SetViewmodelOptional_<native><epic_internal>(
        viewmodel_type: type,
        ViewmodelName: []char,
        ViewmodelInstance: viewmodel_type
      )<transacts>: void

      SetViewmodel_<native><epic_internal>(
        viewmodel_type: type,
        ViewmodelName: []char,
        ViewmodelInstance: viewmodel_type
      )<transacts>: void

      SignalEvent<native_callable><epic_internal>(EventToSignal: signalable(tuple())): void = external {}
    }

    # Verse interface to native `umg asset`.
    umg_widget_class_asset<native><epic_internal> := class<computes><final>(client_asset) {}

    # `widget` vertical alignment mode.
    vertical_alignment<native><public> := enum {
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
    widget<native><public> := class<abstract><unique><epic_internal> {
      # Returns the `widget`'s parent `widget`.
      # Fails if no parent exists, such as if this `widget` is not in the `player_ui` or is itself the root `widget`.
      GetParentWidget<native><public>()<transacts><decides>: widget

      # Gets the render opacity of the widget.
      GetRenderOpacity<native><epic_internal>(): float

      # Returns the `widget` that added this `widget` to the `player_ui`. The root `widget` will return itself.
      # Fails if this `widget` is not in the `player_ui`.
      GetRootWidget<native><public>()<transacts><decides>: widget

      # Returns the current `widget_visibility` state.
      GetVisibility<native><public>(): widget_visibility

      # `true` if this `widget` can be modified interactively by the player.
      IsEnabled<native><public>(): logic

      # `true` if this `widget` consumes input when `widget_visibility` is Visible.
      IsHitTestVisible<native><epic_internal>(): logic

      # Enables or disables whether the `player` can interact with this `widget`.
      SetEnabled<native><public>(InIsEnabled: logic): void

      # Enables or disables whether this `widget` consumes input when `widget_visibility` is Visible.
      SetHitTestVisible<native><epic_internal>(InIsHitTestVisible: logic): void

      # Sets the render opacity of the widget.
      SetRenderOpacity<native><epic_internal>(InRenderOpacity: float): void

      # Shows or hides the `widget` without removing itself from the containing `player_ui`.
      # See `widget_visibility` for details.
      SetVisibility<native><public>(InVisibility: widget_visibility): void
    }

    # Parameters for `event`s signalled by a `widget`.
    widget_message<native><public> := struct {
      # The `player` that triggered the `event`.
      Player<native><public>: player

      # The `widget` that triggered the `event`.
      Source<native><public>: widget
    }

    # Used by `widget.SetVisibility` determine how a `widget` is shown in the user interface.
    widget_visibility<native><public> := enum {
      # The `widget` is invisible and does not occupy layout space.
      Collapsed

      # The `widget` is invisible and occupies layout space.
      Hidden

      # The `widget` is visible and occupies layout space.
      Visible
    }
  }

  WorldPartition<public> := module {
    # Module import path: /UnrealEngine.com/Temporary/WorldPartition/VerseWorldPartition
    VerseWorldPartition<public> := module {
      @deprecated
      # Deprecated, use GetWorldPartitionHelperForEntity instead which is a less ambiguous/future proof way to obtaining the helper
      GetWorldPartitionHelper<native><epic_internal>()<transacts>: ?world_partition_helper

      GetWorldPartitionHelperForEntity<native><epic_internal>(Entity: entity)<transacts>: ?world_partition_helper

      using { /UnrealEngine.com/Temporary/SpatialMath }
      using { /Verse.org/Assets }
      using { /Verse.org/SceneGraph }
      data_layer_asset<native><epic_internal> := class<concrete><computes><final><epic_internal>(asset) {}

      world_partition_helper<native><epic_internal> := class<concrete> {
        # Adds a static streaming source.
        AddStreamingSource<native><public>(StreamingSource: world_partition_streaming_source)<transacts>: cancelable

        # Adds a streaming source provider callback. The callback is responsible for filling and updating the streaming source when invoked.
        AddStreamingSourceProvider<native><public>(UpdateStreamingSourceCallback: type { _(: world_partition_streaming_source): void })<transacts>: cancelable

        # Returns data layer effective runtime state.
        GetDataLayerEffectiveRuntimeState<native><public>(DataLayerAsset: data_layer_asset)<transacts>: world_partition_streaming_runtime_state

        # Returns whether an array of streaming sources has finished streaming. If no array is passed, the state of all currently added streaming source is queryed.
        IsStreamingCompleted<native><public>(Sources: ?[]world_partition_streaming_source)<transacts>: logic

        # Returns whether an array of streaming query sources satisfies the passed state.
        IsStreamingCompleted<native><public>(
          Sources: []world_partition_streaming_query_source,
          QueryState: world_partition_streaming_runtime_state
        )<transacts>: logic

        # Sets data layer runtime state.
        SetDataLayerRuntimeState<native><public>(
          DataLayerAsset: data_layer_asset,
          State: world_partition_streaming_runtime_state,
          IsRecursive: logic
        )<transacts>: logic
      }

      world_partition_streaming_definition<native><epic_internal> := class<concrete><epic_internal> {
        SetAsCircle<public>(Range: float)<transacts>: void = external {}

        SetAsSphere<public>(Range: float)<transacts>: void = external {}

        # If true, this streaming source will force intersecting cells in 2D
        var Force2D<native><public>: logic = external {}

        # Source Location
        var Location<native><public>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

        # Source orientation (can impact streaming cell prioritization)
        var Rotation<native><public>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {}

        # Source internal shapes. When none are provided, a sphere is automatically used. It's radius is equal to grid's loading range and center equals source's location.
        var Shapes<native><public>: []world_partition_streaming_source_shape = external {}

        # Defines how TargetGrids/TargetHLODLayers will be applied to this streaming source.
        var TargetBehavior<native><public>: world_partition_streaming_source_target_behavior = external {}

        # When set, this will change how this streaming source is applied to the provided runtime streaming grids based on the TargetBehavior.
        var TargetGrids<native><public>: []string = external {}
      }

      world_partition_streaming_query_source<native><epic_internal> := class(world_partition_streaming_definition) {
        # The list of layers to consider for this query
        var DataLayers<native><public>: []data_layer_asset = external {}

        # If False, Location/Radius will not be used to find the cells. Only AlwaysLoaded cells will be returned by the query.
        var SpatialQuery<native><public>: logic = external {}
      }

      # Unloaded: Associated content is unloaded. Loaded: Associated content is loaded but not visible. Activated: Associated content is loaded and visible. Represents possible Streaming Sources runtime states.
      world_partition_streaming_runtime_state<native><epic_internal> := enum {
        # Activated (meaning loaded and visible)
        Activated

        # Loaded (meaning loaded but not visible)
        Loaded

        # Unloaded
        Unloaded
      }

      world_partition_streaming_source<native><epic_internal> := class(world_partition_streaming_definition) {
        # Whether this source will be considered when world partition detects slow loading and waits for cell streaming to complete
        var BlockOnSlowLoading<native><public>: logic = external {}

        # Source unique name
        var Name<native><public>: string = external {}

        # Streaming source priority
        var Priority<native><public>: world_partition_streaming_source_priority = external {}

        # Target streaming state
        var TargetState<native><public>: world_partition_streaming_runtime_state = external {}

        # Use velocity contribution to streaming cells priority streaming.
        var UseVelocityContributionToCellsSorting<native><public>: logic = external {}
      }

      world_partition_streaming_source_priority<native><epic_internal> := enum {
        High

        Highest

        Low

        Lowest

        Normal
      }

      world_partition_streaming_source_shape<native><epic_internal> := class<concrete> {
        # Whether the source shape is a spherical sector instead of a regular sphere source.
        var IsSector<native><public>: logic = external {}

        # Applies a scale to the grid's loading range (used if bUseGridLoadingRange is True)
        var LoadingRangeScale<native><public>: float = external {}

        # Streaming source shape location (local to streaming source).
        var Location<native><public>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3 = external {}

        # Custom streaming source shape radius (not used if bUseGridLoadingRange is True).
        var Radius<native><public>: float = external {}

        # Streaming source shape rotation (local to streaming source).
        var Rotation<native><public>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {}

        # Shape's spherical sector angle in degree (not used if bIsSector is False)
        var SectorAngle<native><public>: float = external {}

        # If True, streaming source shape radius is bound to loading range radius.
        var UseGridLoadingRange<native><public>: logic = external {}
      }

      world_partition_streaming_source_subscription<native><epic_internal> := class(cancelable) {
        Cancel<native><override>()<transacts>: void
      }

      world_partition_streaming_source_target_behavior<native><epic_internal> := enum {
        Exclude

        Include
      }
    }
  }

  @experimental
  playable<epic_internal> := interface<epic_internal> {
    @experimental
    GetDuration<public>()<decides>: float

    @experimental
    GetOnFinishedEvent<public>()<reads><decides>: listenable(tuple())

    @experimental
    GetOnPausedEvent<public>(): listenable(tuple())

    @experimental
    GetOnPlayedEvent<public>(): listenable(tuple())

    @experimental
    GetOnStoppedEvent<public>(): listenable(tuple())

    @experimental
    Pause<public>(): void

    @experimental
    Play<public>(): void

    @experimental
    Stop<public>(?BlendOutTime: float = external {}): void
  }
}

Tests<public> := module {
  # Module import path: /UnrealEngine.com/Tests/NexusUtils
  NexusUtils<public> := module {
    nexus_utils<native><epic_internal> := class {
      # Call a console command on all clients
      ExecuteConsoleCommandOnAllClients<native><epic_internal>(ConsoleCommand: string): void

      # Force a client garbage collection for all connected clients
      ForceGarbageCollectionOnAllClients<native><epic_internal>(): void

      GetSavedDir<native><epic_internal>(): string

      # Returns true when running on the new Verse VM (VVM); false on legacy Blueprint VM (BPVM). Build-time decision; never changes at runtime.
      IsVVM<native><epic_internal>()<computes>: logic

      PrintEpicAPIFunctionLog<native><public>(): void

      # Reads a file at a given path, returns a string array. Optionally prepends path to executables 'Saved' directory
      ReadFile<native><epic_internal>(FilePath: []string)<transacts><decides>: []string

      # Takes a screenshot on clients that are connected to the server this is called onPasses in the file name of the screenshot that gets saved to a fixed directory
      ScreenshotAllClients<native><epic_internal>(ScreenshotFileName: string): void

      # Writes a string array of lines to a file at a given path. Optionally prepends path to executables 'Saved' directory
      WriteFile<native><epic_internal>(FilePath: []string, Lines: []string)<transacts>: void
    }
  }
}

VerseTypeEditor<public> := module {
  using { /Verse.org/Assets }
  verse_type_editor_asset<native><epic_internal> := class(asset) {}
}

WebAPI<public> := module {
  MakeClient<native><public>(ClientId: client_id)<converges>: client

  body_response<native><public> := class<internal>(response) {
    GetBody<native><public>()<computes>: string
  }

  client<native><public> := class<final><computes><internal> {
    Get<native><public>(Path: string)<suspends>: response
  }

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
  client_id<native><public> := class<abstract><computes> {}

  response<native><public> := class<internal> {}
}