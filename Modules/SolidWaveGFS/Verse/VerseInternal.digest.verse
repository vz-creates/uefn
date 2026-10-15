<#
Copyright Epic Games, Inc. All Rights Reserved.
#################################################
Generated Digest of Verse API
DO NOT modify this manually!
Generated from build: ++Fortnite+Release-42.40-CL-59247843
#################################################
#>

AgentGroup<public> := module {
  @available { MinUploadedAtFNVersion := 4000 }
  # Base class for all errors returned from agent_group.AddMember.
  add_member_error<public><native> := class<computes> {}

  @available { MinUploadedAtFNVersion := 4000 }
  # An agent group is defined as a set of agents that share a common
  # ownership.This class stores agents and specific information about each
  # member via the member_info type provided.
  agent_group<public><native>(member_info: subtype(member_info_interface)) := class<unique>(
    agent_group_interface(member_info)
  ) {
    # Attempt to add the given agent to this agent group.This function returns a
    # result that will either succeed or return an error.
    AddMember<public>(
      Agent: agent,
      MemberInfo: member_info
    )<transacts>: result(comparable, add_member_error) = external {}

    # Signalled whenever an agent successfully joins this agent group.Passes in
    # the agent that joined along with their member_info.
    AddMemberEvent<final><override><native>: listenable(tuple(agent, member_info)) = external {}

    AddMemberInternal<epic_internal><final><native_callable>(
      Agent: agent,
      MemberInfo: member_info
    )<transacts>: result(comparable, add_member_error) = external {}

    (/Verse.org/AgentGroup/agent_group:)AgentGroup_agent_group_Variance<private>(
      : member_info,
      : member_info,
      : member_info,
      : member_info,
      : member_info
    ): tuple(member_info, member_info, member_info, member_info) = external {}

    @available { MinUploadedAtFNVersion := 4210 }
    (/Verse.org/AgentGroup/agent_group:)AgentGroup_agent_group_Variance_Inherited<private>(): tuple(
      member_info,
      member_info,
      member_info,
      member_info
    ) = external {}

    # Get the members of this agent group with their member info
    GetMemberMap<override><native_callable>()<reads>: [agent]member_info = external {}

    # Signalled whenever the MemberInfo class is re-instantiated for a given
    # agent.Passes in the agent that was updated along with their
    # new member_info.
    MemberInfoChangeEvent<final><override><native>: listenable(tuple(agent, member_info)) = external {}

    # Attempt to remove the given agent from this agent group.This function
    # returns a result that will either succeed or return an error.
    RemoveMember<public>(Agent: agent)<transacts>: result(comparable, remove_member_error) = external {}

    # Signalled whenever an agent successfully leaves this agent group.Passes in
    # the agent that left along with their member_info.
    RemoveMemberEvent<final><override><native>: listenable(tuple(agent, member_info)) = external {}

    RemoveMemberInternal<epic_internal><final><native_callable>(
      Agent: agent
    )<transacts>: result(comparable, remove_member_error) = external {}

    var (/Verse.org/AgentGroup/agent_group:)AgentGroup_agent_group_VarVariance<private>: ?tuple(
      member_info
    ) = external {}

    var<private> MemberMap<epic_internal><native>: [agent]member_info = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Interface that defines a class as providing an agent group.
  agent_group_interface<public><native>(member_info: subtype(member_info_interface)) := interface<unique> {
    # Signalled whenever an agent successfully joins this agent group.Passes in
    # the agent that joined along with their member_info.
    AddMemberEvent<public>: listenable(tuple(agent, member_info))

    (/Verse.org/AgentGroup/agent_group_interface:)AgentGroup_agent_group_interface_Variance<private>(): tuple(
      member_info,
      member_info,
      member_info,
      member_info
    ) = external {}

    # Get the members of this agent group with their member info
    GetMemberMap<public>()<reads>: [agent]member_info

    # Signalled whenever the MemberInfo class is re-instantiated for a given
    # agent.Passes in the agent that was updated along with their
    # new member_info.
    MemberInfoChangeEvent<public>: listenable(tuple(agent, member_info))

    # Signalled whenever an agent successfully leaves this agent group.Passes in
    # the agent that left along with their member_info.
    RemoveMemberEvent<public>: listenable(tuple(agent, member_info))
  }

  using { /Verse.org/Native }
  using { /Verse.org/Simulation }
  # Verse path: /Verse.org/AgentGroup
  @available { MinUploadedAtFNVersion := 4000 }
  # Interface that defines a class as being usable as member info in an
  # agent group
  member_info_interface<public><native> := interface {}

  @available { MinUploadedAtFNVersion := 4000 }
  # Base class for all errors returned from agent_group.RemoveMember.
  remove_member_error<public><native> := class<computes> {}
}

# Verse path: /Verse.org
# Module import path: /Verse.org/Assets
Assets<public> := module {
  # Create an asset reference to the given internal asset path
  MakeAsset<epic_internal><native>(asset_type: subtype(asset), AssetPath: string)<converges>: asset_type

  # Create a texture asset reference with dimensions sourced at
  # manifest-generation time
  MakeTextureAsset<epic_internal><native>(AssetPath: string, Width: float, Height: float)<converges>: texture

  WriteToDataChannelFromVerseInternal<epic_internal><native>((
    Asset: particle_data_channel,
    Payload: t
  ) where t: type)<transacts>: void

  animation_asset<epic_internal><native> := interface<epic_internal><computes> {}

  animation_sequence<public><native> := class<epic_internal><final><computes>(asset, animation_asset) {}

  asset<epic_internal><native> := class<epic_internal><computes> {
    Async_Load<epic_internal><native>(): sticky_event(void)

    GetAssetType<epic_internal><native>()<transacts><decides>: subtype(asset)

    GetAsyncLoadEvent<epic_internal><native>()<decides>: sticky_event(void)

    InitializeNetworkReplication<epic_internal><native>()<transacts>: void

    SetPath<epic_internal><native>(InPath: string)<transacts>: void

    SyncLoad<epic_internal><native>(): logic
  }

  @attribscope_class
  @attribscope_struct
  @attribscope_data
  asset_locus<epic_internal> := class<computes>(attribute) {
    Whence<epic_internal>: string
  }

  asset_proxy<epic_internal><constructor>(AssetProxy: string)<computes>: asset_proxy_attribute = external {}

  using { /Verse.org/Colors }
  using { /Verse.org/Native }
  using { /Verse.org/Restricted }
  using { /Verse.org/Simulation }
  @attribscope_class
  @customattribhandler
  asset_proxy_attribute<epic_internal> := class<internal><computes>(attribute) {}

  camera_rig_asset<epic_internal><native> := class<epic_internal><computes>(asset) {}

  client_asset<epic_internal><native> := class<epic_internal><abstract><computes>(asset) {}

  @available { MinUploadedAtFNVersion := 4100 }
  control_rig<epic_internal><native> := class<epic_internal><final>(asset, animation_asset) {}

  @available { MinUploadedAtFNVersion := 4100 }
  control_rig_blueprint<epic_internal><native> := class<epic_internal><final>(asset, animation_asset) {}

  font<epic_internal><native> := class<epic_internal><final><computes>(client_asset) {}

  # Interface that provides an icon.
  has_icon<public><native> := interface {
    @editable
    # A texture used as the 2D visual representation of this entity (e.g. an
    # icon or portrait).
    var Icon<public>: texture
  }

  image_dimensions<epic_internal><native> := interface<computes> {
    Height<epic_internal>: float

    Width<epic_internal>: float
  }

  input_action<public><native>(t: type) := class<epic_internal><allocates><unique><computes>(asset) {
    (/Verse.org/Assets/input_action:)Assets_input_action_Variance<private>(): tuple(t) = external {}

    Path<epic_internal><native>: string = external {}

    RequiredByCompiler<epic_internal>: ?t = external {}
  }

  input_mapping<public><native> := class<epic_internal><computes>(asset) {}

  landscape_mesh<epic_internal><native> := class<epic_internal><final><computes>(mesh) {}

  level<epic_internal><native> := class<epic_internal><final><computes>(asset) {}

  material<public><native> := class<epic_internal>(asset, property_changed_interface, material_like) {
    @transient
    MaterialPath<epic_internal><native>: string = external {}

    OnPropertyChangedFromVerse<native><override>(PropertyName: string)<transacts>: void

    SetColorProperty<epic_internal><native>(PropertyName: string, NewColor: color)<transacts>: void

    SetFloatProperty<epic_internal><native>(PropertyName: string, NewFloat: float)<transacts>: void

    SetTextureProperty<epic_internal><native>(PropertyName: string, NewTexture: texture)<transacts>: void

    bUsesGetSetters<epic_internal><native>: logic = external {}
  }

  material_like<epic_internal><native> := interface<epic_internal><computes> {}

  mesh<public><native> := class<epic_internal><computes>(asset) {}

  metasound<epic_internal><native> := class<epic_internal><final><computes>(client_asset) {}

  network_physics_settings_data<epic_internal><native> := class<epic_internal><computes>(asset) {}

  # property_interface that will be generated in the digest from the Editable
  parameterized_property_interface<epic_internal><native> := class<unique>(property_changed_interface) {
    OnPropertyChangedFromVerse<native><override>(PropertyName: string)<transacts>: void

    UE5Class<epic_internal><native>: property_interface_UE5_definition
  }

  particle_data_channel<epic_internal><native> := class<epic_internal><computes>(client_asset) {}

  particle_system<public><native> := class<epic_internal><final><computes>(client_asset) {}

  # The UClass generated by the PropertyInterface asset. It represents the
  # property_interface verse class but with UE5 properties.
  property_interface_UE5_definition<epic_internal><native> := class<final><computes>(asset) {}

  skeletal_mesh<epic_internal><native> := class<epic_internal><final><computes>(mesh) {}

  sound<epic_internal><native> := class<epic_internal><final><computes>(client_asset) {}

  sound_wave<public><native> := class<epic_internal><final><computes>(client_asset) {}

  texture<public><native> := class<epic_internal><final><computes>(texture_base, material_like, image_dimensions) {
    Height<native><override>: float = external {}

    Width<native><override>: float = external {}
  }

  texture_base<epic_internal><native> := class<epic_internal><computes>(asset) {}

  @available { MinUploadedAtFNVersion := 4240 }
  uaf_shared_variables<epic_internal><native> := class<epic_internal>(asset, animation_asset) {}

  @available { MinUploadedAtFNVersion := 4220 }
  uaf_system<epic_internal><native> := class<epic_internal><final>(asset, animation_asset) {}
}

Chat<public> := module {
  @available { MinUploadedAtFNVersion := 4000 }
  # Registers a `chat_channel` to the simulation this `entity` belongs to.
  # Fails if the channel's `agent_group` already has more members than the
  # channel type's limit.
  # * Voice Chat Max Size = 80 participants.
  # * Text Chat Max Size = 100 participants.
  (Entity: entity where MemberInfo: subtype(member_info_interface)).AddChatChannel<public><native>(
    Channel: chat_channel(MemberInfo)
  ): result(void, add_channel_error)

  @available { MinUploadedAtFNVersion := 4000 }
  # Deregisters a `chat_channel` from the simulation this `entity` belongs to.
  (Entity: entity where MemberInfo: subtype(member_info_interface)).RemoveChatChannel<public><native>(
    Channel: chat_channel(MemberInfo)
  ): result(void, remove_channel_error)

  @available { MinUploadedAtFNVersion := 4000 }
  # Unregisters and removes all members from all chat channels currently on
  # the simulation.
  (Entity: entity).ClearChatChannels<epic_internal><native>(): void

  @available { MinUploadedAtFNVersion := 4240 }
  # Returns the `text_channel`s registered on the simulation this `entity`
  # belongs to
  (Entity: entity).GetTextChannels<public><native>()<reads>: []text_channel(has_text_member_info)

  @available { MinUploadedAtFNVersion := 4000 }
  # Returns the `voice_channel`s registered on the simulation this `entity`
  # belongs to
  (Entity: entity).GetVoiceChannels<public><native>()<reads>: []voice_channel(has_voice_member_info)

  @available { MinUploadedAtFNVersion := 4000 }
  # Returns all the voice channels where the agent is part of the agent_group.
  (Entity: simulation_entity).GetVoiceChannelsForAgent<epic_internal><native>(
    Agent: agent
  ): []voice_channel(has_voice_member_info)

  @available { MinUploadedAtFNVersion := 4220 }
  GetDisplayableVoiceChannelName<epic_internal><native_callable>(
    VoiceChannel: voice_channel(has_voice_member_info)
  )<reads>: string = external {}

  @available { MinUploadedAtFNVersion := 4000 }
  # Used in native to create a channel result when registering a channel.
  MakeAddChannelResult<epic_internal><native_callable>(
    IsSuccess: logic
  ): result(comparable, add_channel_error) = external {}

  @available { MinUploadedAtFNVersion := 4000 }
  # Used in native to create a channel result when unregistering a channel.
  MakeRemoveChannelResult<epic_internal><native_callable>(
    IsSuccess: logic
  ): result(comparable, remove_channel_error) = external {}

  @available { MinUploadedAtFNVersion := 4000 }
  # Error returned when a channel cannot be added via the
  # `AddChatChannel` function.
  add_channel_error<public> := class<computes> {}

  using { /Verse.org/AgentGroup }
  using { /Verse.org/Colors }
  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  # Verse path: /Verse.org/Chat
  @available { MinUploadedAtFNVersion := 4000 }
  chat_channel<public><native>(member_info: subtype(member_info_interface)) := class<internal><unique><abstract>(
    enableable
  ) {
    (/Verse.org/Chat/chat_channel:)Chat_chat_channel_Variance<private>(): tuple(member_info) = external {}

    Disable<override>(): void = external {}

    Enable<override>(): void = external {}

    GetAllAgents<epic_internal><native_callable>()<reads>: []agent = external {}

    GetAllPlayerAgents<epic_internal><native_callable>()<reads>: []agent = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    Group<public>: agent_group_interface(member_info)

    IsAgentInChannel<epic_internal><native_callable>(Agent: agent)<decides><reads>: void = external {}

    IsEnabled<override>()<transacts><decides>: void = external {}

    Name<public>: message

    @available { MinUploadedAtFNVersion := 4220 }
    var<private> MaxSize<epic_internal>: int = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Internal agent group - used to create the default voice channels when
  # starting a game.
  default_agent_group<epic_internal> := class(agent_group(default_member_info)) {}

  @available { MinUploadedAtFNVersion := 4000 }
  # Internal member info - used to create the default voice channels when
  # starting a game.
  default_member_info<epic_internal> := class(has_voice_member_info) {}

  @available { MinUploadedAtFNVersion := 4240 }
  # Used to specify permissions and other settings for a `text_channel`.
  has_text_member_info<public><native> := interface(member_info_interface) {
    GetCanSendEpicInternal<epic_internal>()<reads>: logic = external {}

    GetMessageStyleEpicInternal<epic_internal>()<reads>: ?text_message_style = external {}

    # Determines if the participant can send text messages to the channel.
    # If false, the participant can still see users and messages in the text
    # chat widget.
    var CanSend<public>: logic = external {}

    # The text styling for this participant in the channel.
    # If false, `MessageStyle` as defined by the channel is used.
    var MessageStyle<public>: ?text_message_style = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Used to specify permissions and other settings for a voice_channel.
  has_voice_member_info<public><native> := interface(member_info_interface) {
    @available { MinUploadedAtFNVersion := 4220 }
    GetCanBroadcastEpicInternal<epic_internal>()<reads>: logic = external {}

    # Determines if the participant can send voice messages to the channel.
    # If false, the participant can still hear those who are broadcasting and
    # see users in the social overlay panel.
    var CanBroadcast<public>: logic = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Error returned when a channel cannot be removed via the
  # `RemoveChatChannel` function.
  remove_channel_error<public> := class<computes> {}

  @available { MinUploadedAtFNVersion := 4240 }
  # A `text_channel` defines a group of agents who can communicate via
  # text chat.
  # An agent can be a member of more than one `text_channel`.
  # Text channels can accommodate 100 members of the channel's `Group`. Agents
  # beyond this limit are not included in the chat.
  # A chat participant in a `text_channel` may be restricted from text chat
  # based on parental controls and/or user settings.
  text_channel<public><native>(member_info: subtype(has_text_member_info)) := class<final>(chat_channel(member_info)) {
    AddTextChannelSubscription<epic_internal>(NewSubscription: cancelable): void = external {}

    CancelSubscriptions<epic_internal><native_callable>(): void = external {}

    (/Verse.org/Chat/text_channel:)Chat_text_channel_Variance<private>(
      : member_info,
      : member_info,
      : member_info
    ): tuple() = external {}

    @available { MinUploadedAtFNVersion := 4210 }
    (/Verse.org/Chat/text_channel:)Chat_text_channel_Variance_Inherited<private>(): tuple(member_info) = external {}

    # Disables users from communicating on the channel.
    Disable<override><native>(): void

    # Allows users to communicate on the channel.
    Enable<override><native>(): void

    GetChannelName<epic_internal><native_callable>()<reads>: message = external {}

    GetMembersWithStyleOverride<epic_internal><native_callable>()<reads>: []agent = external {}

    GetMessageStyleOverrideForMember<epic_internal><native_callable>(
      Agent: agent
    )<reads>: ?text_message_style = external {}

    GetSendingAgents<epic_internal><native_callable>()<reads>: []agent = external {}

    # Returns if any user can communicate on the channel.
    IsEnabled<override><native>()<transacts><decides>: void

    OnAddMemberEvent<epic_internal><native>(Agent: agent, MemberInfo: member_info)<transacts>: void

    OnMemberInfoChangeEvent<epic_internal><native>(Agent: agent, MemberInfo: member_info)<transacts>: void

    OnRemoveMemberEvent<epic_internal><native>(Agent: agent, MemberInfo: member_info)<transacts>: void

    SetupSubscriptions<epic_internal>(): void = external {}

    # Message color and name presentation for the channel.
    # A member carrying their own `MessageStyle` overrides this one.
    var MessageStyle<public>: text_message_style = external {}

    # The color of system and platform messages sent to the chat feed.
    # For example, when a user starts writing to a chat channel, a system
    # message tells them so, "Now chatting in Team Red."
    var SystemMessageColor<public>: color = external {}

    var TextChannelSubscriptions<epic_internal>: []cancelable = external {}
  }

  @available { MinUploadedAtFNVersion := 4240 }
  text_manager_component<epic_internal><native> := class<final_super>(component) {
    AddTextChannel<epic_internal><native_callable>(
      TextChannel: text_channel(has_text_member_info)
    )<decides>: void = external {}

    RemoveTextChannel<epic_internal><native_callable>(
      TextChannel: text_channel(has_text_member_info)
    )<decides>: void = external {}

    var TextChannelsOnSimulation<epic_internal><native>: []text_channel(has_text_member_info) = external {}
  }

  @available { MinUploadedAtFNVersion := 4240 }
  # Defines text message styling for text messages in a `text_channel`.
  # Only affects new messages.
  text_message_style<public><native> := class<concrete> {
    # A message printed after a user's name in the chat feed.
    # This message is always wrapped in square brackets "[]".
    # If false, no extra message is added to the message.
    # For example, in the message "Jonesy [Tilted Towers]: gg", the text "Tilted
    # Towers" would be the message provided here.
    ContextMessage<public><native>: ?message = external {}

    # The text color of messages sent to the chat feed.
    TextColor<public><native>: color = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # A `voice_channel` defines a group of agents who can communicate via
  # voice chat.
  # An agent can be a member of more than one `voice_channel`.Voice channels can
  # accommodate 80 members of the channel's `Group`. Agents beyond this limit
  # are not included in the chat.A chat participant in a `voice_channel` may be
  # restricted from voice chat based on parental controls and/or user settings.
  voice_channel<public><native>(member_info: subtype(has_voice_member_info)) := class<final>(
    chat_channel(member_info)
  ) {
    AddVoiceChannelSubscription<epic_internal>(NewSubscription: cancelable): void = external {}

    @available { MinUploadedAtFNVersion := 4220 }
    # Signalled when a member of this channel starts speaking on it.
    # Returns a subscribable with a payload of the speaking `agent`.
    BeginBroadcastEvent<public>(): listenable(agent) = external {}

    @available { MinUploadedAtFNVersion := 4220 }
    BeginBroadcastEventInternal<epic_internal><native>: subscribable_event_intrnl(agent) = external {}

    @available { MinUploadedAtFNVersion := 4220 }
    # Signalled when a member's `CanBroadcast` changes while they hold one of
    # the channel's slots.
    # Returns a subscribable with a payload of the member and their new
    # `CanBroadcast` value.
    CanBroadcastChangeEvent<public>(): listenable(tuple(agent, logic)) = external {}

    @available { MinUploadedAtFNVersion := 4220 }
    CanBroadcastChangeEventInternal<epic_internal><native>: subscribable_event_intrnl(tuple(agent, logic)) = external {}

    CancelSubscriptions<epic_internal><native_callable>(): void = external {}

    (/Verse.org/Chat/voice_channel:)Chat_voice_channel_Variance<private>(
      : member_info,
      : member_info,
      : member_info
    ): tuple() = external {}

    @available { MinUploadedAtFNVersion := 4210 }
    (/Verse.org/Chat/voice_channel:)Chat_voice_channel_Variance_Inherited<private>(): tuple(member_info) = external {}

    # Disables users from communicating on the channel.
    Disable<override><native>(): void

    # Allows users to communicate on the channel.
    Enable<override><native>(): void

    @available { MinUploadedAtFNVersion := 4220 }
    # Signalled when a member of this channel stops speaking on it.
    # Returns a subscribable with a payload of the `agent` that
    # stopped speaking.
    EndBroadcastEvent<public>(): listenable(agent) = external {}

    @available { MinUploadedAtFNVersion := 4220 }
    EndBroadcastEventInternal<epic_internal><native>: subscribable_event_intrnl(agent) = external {}

    GetActiveAgents<epic_internal><native>()<reads>: []agent

    @available { MinUploadedAtFNVersion := 4220 }
    GetBroadcastingAgents<epic_internal><native_callable>()<reads>: []agent = external {}

    # Returns if any user can communicate on the channel.
    IsEnabled<override><native>()<transacts><decides>: void

    @available { MinUploadedAtFNVersion := 4220 }
    # Checks to see if a given member is speaking on the `voice_channel`.
    # Fails if the agent is not a member of the channel, or is not
    # currently speaking.
    IsMemberSpeaking<public><native>(Agent: agent)<decides><reads>: void

    OnAddMemberEvent<epic_internal><native>(Agent: agent, MemberInfo: member_info)<transacts>: void

    @available { MinUploadedAtFNVersion := 4220 }
    OnMemberInfoChangeEvent<epic_internal><native>(Agent: agent, MemberInfo: member_info)<transacts>: void

    OnRemoveMemberEvent<epic_internal><native>(Agent: agent, MemberInfo: member_info)<transacts>: void

    SetupSubscriptions<epic_internal>(): void = external {}

    @available { MinUploadedAtFNVersion := 4220 }
    # The priority assigned to the channel.
    # When a user could hear a speaker on more than one channel, they hear the
    # speaker on the channel with the highest priority.
    # Between channels of equal priority the most recently joined one wins.
    var HearingPriority<epic_internal>: float = external {}

    var VoiceChannelSubscriptions<epic_internal>: []cancelable = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  voice_manager_component<epic_internal><native> := class<final_super>(component) {
    AddToDefaultVoiceChannel<epic_internal><native_callable>(
      ChannelNameString: string,
      Agent: agent
    ): void = external {}

    AddVoiceChannel<epic_internal><native_callable>(
      VoiceChannel: voice_channel(has_voice_member_info)
    )<decides>: void = external {}

    RemoveAgentFromAllDefaultVoiceChannels<epic_internal><native_callable>(Agent: agent): void = external {}

    RemoveFromDefaultVoiceChannel<epic_internal><native_callable>(
      ChannelNameString: string,
      Agent: agent
    ): void = external {}

    RemoveVoiceChannel<epic_internal><native_callable>(
      VoiceChannel: voice_channel(has_voice_member_info)
    )<decides>: void = external {}

    ToMessage<epic_internal><localizes>(ChannelName: string): message = external {}

    @available { MinUploadedAtFNVersion := 4220 }
    UNDEFINED_PRIORITY<epic_internal>: float = external {}

    var VoiceChannelsOnSimulation<epic_internal><native>: []voice_channel(has_voice_member_info) = external {}
  }
}

# Verse path: /Verse.org
# Module import path: /Verse.org/Colors
Colors<public> := module {
  @available { MinUploadedAtFNVersion := 3800 }
  # Makes a new `color_alpha` from individual `R`, `G`, `B`, `A`
  # component values.
  MakeColorAlpha<public>(R: float, G: float, B: float, ?A: float = external {})<computes>: color_alpha = external {}

  # Makes an ACES 2065-1 `color` from `Hue`, `Saturation`, and
  # `Value` components.
  # Components use the HSV color model in the sRGB color space. Expected ranges:
  #  * `0.0 <= Hue <= 360.0`
  #  * `0.0 <= Saturation <= 1.0`
  #  * `0.0 <= Value <= 1.0`
  # Values out of expected ranges will undergo range reduction and conversion.
  MakeColorFromHSV<public><native>(Hue: float, Saturation: float, Value: float)<converges>: color

  # Makes an ACES 2065-1 `color` from a CSS-style sRGB `hexString`. Supported
  # formats are:
  #  * RGB
  #  * RRGGBB
  #  * RRGGBBAA
  #  * #RGB
  #  * #RRGGBB
  #  * #RRGGBBAA
  # An invalid hex string will return `Black`.
  MakeColorFromHex<public><native>(hexString: string)<converges>: color

  # Makes an ACES 2065-1 `color` from sRGB components `Red`, `Green`,
  # and `Blue`.
  # Normal sRGB component values are between `0.0` and `1.0`, but this can
  # handle larger values.
  MakeColorFromSRGB<public><native>((local:)Red: float, (local:)Green: float, (local:)Blue: float)<converges>: color

  # Makes an ACES 2065-1 `color` from the integer sRGB components `Red`,
  # `Green`, and `Blue`.
  # Valid sRGB component values are between '0' and '255', inclusive.
  MakeColorFromSRGBValues<public><native>((local:)Red: int, (local:)Green: int, (local:)Blue: int)<converges>: color

  # Makes an ACES 2065-1 `color` from the chromaticity of a blackbody radiator
  # at `Temperature` Kelvin.
  # `Temperature` is clamped such that `0 <= Temperature`.
  MakeColorFromTemperature<public><native>(Temperature: float)<converges>: color

  # Makes an HSV `tuple` by converting `InColor` from an ACES 2065-1 `color` to
  # sRGB and applying the HSV color model.
  MakeHSVFromColor<public><native>(InColor: color): tuple(float, float, float)

  # Makes an sRGB `tuple` by converting `InColor` from an ACES 2065-1 `color`
  # to sRGB.
  MakeSRGBFromColor<public><native>(InColor: color)<converges>: tuple(float, float, float)

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
  # Blend colors `CA1` and `CA2` with `CA1` over `CA2` using two
  # non-premultiplied `color_alpha` values.
  # Alpha components are clamped between `0.0` and `1.0`. Fails if the value of
  # both clamped Alpha components are `0.0`.
  Over<public>(CA1: color_alpha, CA2: color_alpha)<decides><reads>: color_alpha = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  # Makes a new `color_alpha` from a `tuple(float, float, float, float)`. Fails
  # if passed array is not of length 4.
  ToColorAlpha<epic_internal>(F: tuple(float, float, float, float))<computes>: color_alpha = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  # Makes a new `tuple(float, float, float, float)` from a `color_alpha`.
  ToFloat4<epic_internal>(CA: color_alpha)<computes>: tuple(float, float, float, float) = external {}

  using { /Verse.org/Native }
  using { /Verse.org/Simulation }
  using { /Verse.org/Temporary/EpicGamesRestricted/Network }
  @replicatable
  @import_as("/*.FVColor")
  # Represents colors as RGB triples in the ACES 2065-1 color space.
  # Component values are linear (i.e. `*gamma* = 1.0`).
  color<public><native> := struct<concrete><computes><persistable><uht_comparable> {
    @editable
    # Blue component of this `color`.
    B<public><native>: float = external {}

    @editable
    # Green component of this `color`.
    G<public><native>: float = external {}

    @editable
    # Red component of this `color`.
    R<public><native>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 3800 }
  @replicatable
  @import_as("/*.FVColorAlpha")
  # Represents colors as RGB triples in the ACES 2065-1 color space with an
  # additional alpha channel A.
  # This reasons about the `Color` and alpha (`A`) as separate concepts instead
  # of as a single concept.
  # All values are stored strictly as unopinionated floats but, when interpreted
  # as a color with alpha, ranges for `A` are `0.0` (transparent) to `1.0`
  # (opaque). Color values are not premultiplied.
  # Component values are linear (i.e. `*gamma* = 1.0`).
  color_alpha<public><native> := struct<concrete><computes><persistable><uht_comparable> {
    @editable
    # Alpha component of this `color_alpha`.
    A<public><native>: float = external {}

    @editable
    # `Color` component of this `color_alpha`.
    Color<public><native>: color = external {}
  }

  # Makes an ACES 2065-1 `color` from the component-wise product of `c0`
  # and `c1`.
  (/Verse.org/Colors:)operator'*'<public><native>(c0: color, c1: color)<converges>: color

  # Makes an ACES 2065-1 `color` from each component of `c` scaled by `factor`.
  (/Verse.org/Colors:)operator'*'<public><native>(c: color, factor: float)<converges>: color

  # Makes an ACES 2065-1 `color` from each component of `c` scaled by `factor`.
  (/Verse.org/Colors:)operator'*'<public><native>(c: color, factor: int)<converges>: color

  # Makes an ACES 2065-1 `color` from each component of `c` scaled by `factor`.
  (/Verse.org/Colors:)operator'*'<public><native>(factor: float, c: color)<converges>: color

  # Makes an ACES 2065-1 `color` from each component of `c` scaled by `factor`.
  (/Verse.org/Colors:)operator'*'<public><native>(factor: int, c: color)<converges>: color

  # Makes an ACES 2065-1 `color` from the component-wise sum of `c0` and `c1`.
  (/Verse.org/Colors:)operator'+'<public><native>(c0: color, c1: color)<converges>: color

  # Makes an ACES 2065-1 `color` from the component-wise difference of `c0`
  # and `c1`.
  (/Verse.org/Colors:)operator'-'<public><native>(c0: color, c1: color)<converges>: color

  # Makes an ACES 2065-1 `color` from each component of `c` divided by `factor`.
  (/Verse.org/Colors:)operator'/'<public><native>(c: color, factor: float)<decides><converges>: color

  # Makes an ACES 2065-1 `color` from each component of `c` divided by `factor`.
  (/Verse.org/Colors:)operator'/'<public><native>(c: color, factor: int)<decides><converges>: color
}

# Module import path: /Verse.org/Concurrency
Concurrency<public> := module {
  using { /Verse.org/Native }
  @cpp_name("verse::awaitable")
  # A parametric interface implemented by events with a `payload` that can be
  # waited on. Matched with `signalable.`
  awaitable<public><native>(payload: type) := interface {
    # Suspends the current task until resumed by a matching call to
    # `signalable.Signal`. Returns the event `payload`.
    Await<public>()<suspends>: payload

    (/Verse.org/Concurrency/awaitable:)Concurrency_awaitable_Variance<private>(): tuple(payload) = external {}
  }

  awaitable<public>() := awaitable(void)

  @cpp_name("verse::task")
  task<public><native>(t: type) := class<final><abstract>(awaitable(t)) {
    Active<epic_internal><native>()<transacts><decides>: void

    Await<native><override>()<suspends>: t

    Cancel<epic_internal><native>()<suspends>: void

    Canceled<epic_internal><native>()<transacts><decides>: void

    Canceling<epic_internal><native>()<transacts><decides>: void

    Completed<epic_internal><native>()<transacts><decides>: void

    (/Verse.org/Concurrency/task:)Concurrency_task_Variance<private>(): tuple(t) = external {}

    @available { MinUploadedAtFNVersion := 4210 }
    (/Verse.org/Concurrency/task:)Concurrency_task_Variance_Inherited<private>(): tuple(t) = external {}

    Interrupted<epic_internal><native>()<transacts><decides>: void

    Settled<epic_internal><native>()<transacts><decides>: void

    Uninterrupted<epic_internal><native>()<transacts><decides>: void

    Unsettled<epic_internal><native>()<transacts><decides>: void
  }
}

# Module import path: /Verse.org/Diagnostics
Diagnostics<public> := module {
  @attribscope_class
  @attribscope_struct
  @attribscope_data
  @attribscope_function
  @attribscope_interface
  export_metadata<epic_internal> := class<computes>(attribute) {
    Category<epic_internal>: string

    Key<epic_internal>: string

    Value<epic_internal>: string
  }
}

@available { MinUploadedAtFNVersion := 4000 }
# Module import path: /Verse.org/Input
Input<public> := module {
  @available { MinUploadedAtFNVersion := 4100 }
  # Transforms the given viewport space coordinates into 3D world origin and
  # direction vectors. ViewportPosition is in centimeters: `Left` is the
  # horizontal coordinate (positive rightward from the top-left corner) and `Up`
  # is the vertical coordinate (positive upward, negative for points below the
  # top of the screen). Only the `Left` and `Up` components are used; `Forward`
  # is intentionally ignored because depth is unknown at the point of screen
  # interaction — trace the returned ray against scene geometry to determine the
  # world-space hit point at the correct depth.
  (Player: player).DeprojectViewportToWorld<public><native>(
    ViewportPosition: (/Verse.org/SpatialMath:)vector3
  )<reads>: deproject_results

  @available { MinUploadedAtFNVersion := 4100 }
  # Transforms a 3D world position to viewport space coordinates in centimeters.
  # Returns a vector3 where `Left` is the horizontal viewport coordinate
  # (positive is rightward from the screen's top-left corner) and `Up` is the
  # vertical viewport coordinate (positive is upward, so a point below the top
  # of the screen has a negative `Up`). `Forward` is always 0 because viewport
  # coordinates are 2D. Fails if the world position is behind the camera.
  (Player: player).ProjectWorldToViewport<public><native>(
    WorldPosition: (/Verse.org/SpatialMath:)vector3
  )<decides><reads>: (/Verse.org/SpatialMath:)vector3

  using { /Verse.org/Assets }
  using { /Verse.org/Native }
  using { /Verse.org/Simulation }
  using { /Verse.org/SpatialMath }
  @available { MinUploadedAtFNVersion := 4110 }
  # Module import path: /Verse.org/Input/Gameplay
  # The module contains input mappings that are available during gameplay.
  Gameplay<public> := module {
    using { /Verse.org/Assets }
    using { /Verse.org/Native }
    @available { MinUploadedAtFNVersion := 4110 }
    HotbarMapping<public>: input_mapping = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Access input-related data and settings for a player.
  GetPlayerInput<public><native>(Player: player)<transacts><decides>: player_input

  @available { MinUploadedAtFNVersion := 4000 }
  # Module import path: /Verse.org/Input/UI
  # The module contains a set of Input Actions that are available in UI mode,
  # given that they're bound to an interactive UI element.
  UI<public> := module {
    @available { MinUploadedAtFNVersion := 4030 }
    Back<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    Craft<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    # CraftingMenuMapping includes the following actions with default
    # key bindings:
    #   * Craft: F/Gamepad Face Button Top
    #   * Inspect: I/Gamepad Face Button Left
    #   * Favorite: V/Gamepad Right Thumbstick Button
    #   * Scrap: X/Gamepad Left Thumbstick Button
    CraftingMenuMapping<public>: input_mapping = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    Drop<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    Favorite<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    Inspect<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    # InventoryMenuMapping includes the following actions with default
    # key bindings:
    #   * Use: F/Gamepad Face Button Top
    #   * Inspect: I/Gamepad Face Button Left
    #   * Sort: V/Gamepad Right Thumbstick Button
    #   * Drop: X/Gamepad Left Thumbstick Button
    InventoryMenuMapping<public>: input_mapping = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    # MapMenuMapping includes the following actions with default key bindings:
    #   * Track: F/Gamepad Face Button Top
    #   * PlaceMarker: P/Gamepad Face Button Left
    #   * Reset: R/Gamepad Left Thumbstick Button
    #   * ToggleView: V/Gamepad Right Thumbstick Button
    #   * ZoomIn: Z/Gamepad Left Trigger
    #   * ZoomOut: X/Gamepad Right Trigger
    MapMenuMapping<public>: input_mapping = external {}

    using { /Verse.org/Assets }
    using { /Verse.org/Native }
    using { /Verse.org/SpatialMath }
    @available { MinUploadedAtFNVersion := 4000 }
    # MenuNavigationMapping includes the following actions with default
    # key bindings:
    #   * NextTab: E/Gamepad Right Shoulder
    #   * PreviousTab: Q/Gamepad Left Shoulder
    #   * NextPage: C/Gamepad Right Trigger
    #   * PreviousPage: Z/Gamepad Left Trigger
    #   * Back: Escape/Gamepad Back Button
    MenuNavigationMapping<public>: input_mapping = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    NextPage<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    NextTab<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    PlaceMarker<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4100 }
    PointerSelect<public>: input_action((/Verse.org/SpatialMath:)vector3) = external {}

    @available { MinUploadedAtFNVersion := 4120 }
    @experimental
    PointerZoom<public>: input_action((/Verse.org/SpatialMath:)vector3) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    PreviousPage<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    PreviousTab<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    Reset<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    Scrap<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    Sort<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    ToggleView<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4100 }
    TouchMapping<public>: input_mapping = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    Track<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    Use<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    ZoomIn<public>: input_action(logic) = external {}

    @available { MinUploadedAtFNVersion := 4000 }
    ZoomOut<public>: input_action(logic) = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  # Logs the timestamp and current net mode to LogVerseInput.
  VerseInput_TestPredictsPing<epic_internal><native>()<transacts>: void

  # Flags for input devices currently available to the player. Updates at
  # runtime as devices connect or disconnect. `Touch` is a platform capability
  # and does not change during a session. Note that `Keyboard` and `Mouse`
  # always carry the same value because the engine groups them as a single
  # capability today.
  available_input_devices<public><native> := struct {
    Gamepad<public><native>: logic = external {}

    Keyboard<public><native>: logic = external {}

    Mouse<public><native>: logic = external {}

    Touch<public><native>: logic = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  # Holds the world-space ray produced by deprojecting a viewport coordinate.
  deproject_results<public><native> := struct {
    # Normalized world space direction vector of the ray, pointing from the
    # camera through the given viewport coordinate into the scene.
    Direction<native>: (/Verse.org/SpatialMath:)vector3

    # World space position of the camera (the ray's origin). This is the camera
    # eye point, not the near plane — a trace starting here may intersect
    # geometry between the camera and the near plane that is not visible on
    # screen. Use collision filtering to ignore the player pawn, or advance the
    # start point along Direction past the near clip distance.
    Origin<native>: (/Verse.org/SpatialMath:)vector3
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Input_events is a container for user input events which can be
  # subscribed to.
  #   * Use the 'GetPlayerInput' and 'GetInputEvents' functions to retrieve an
  #     input_events object for a given player.
  #   * Low-level notifications of current user input: BeginDetectEvent,
  #     DetectionOngoingEvent, and EndDetectEvent.
  #   * High-level notifications of triggered events: TriggerActivationEvent
  #     and CancelActivationEvent.
  #
  #                         /—----------<-------\
  #  BeginDetectEvent -> DetectionOngoingEvent -> TriggerActivationEvent -> EndDetectEvent
  #            /\                         /\                                            /
  #              \---------------------> CancelActivationEvent ----------------------/
  input_events<public><native>(t: type) := class(input_events_base) {
    # Detection has started for this input e.g. a required key is now held down.
    # Note: TriggerActivationEvent may also occur this frame,
    #  but this event will always be fired first. BeginDetectEvent and
    #  EndDetectEvent will always fire, regardless of whether the input is
    #  successful or canceled.
    #  Tuple payload: 0: the player generating this event
    #                 1: the value generated by the physical input
    BeginDetectEvent<public><native>: listenable(tuple(player, t)) = external {}

    # This input has been canceled before activation. For example, if the key is
    # released before a “Press and Hold” time threshold.
    #  Tuple payload: 0: the player generating this event
    #                 1: the value generated by the physical input
    #                 2: elapsed seconds since detection began
    CancelActivationEvent<public><native>: listenable(tuple(player, t, float)) = external {}

    # Detection for this input is still being processed. For example, a time
    # threshold may not be met.
    #  Tuple payload: 0: the player generating this event
    #                 1: the value generated by the physical input
    #                 2: elapsed seconds since detection began
    DetectionOngoingEvent<public><native>: listenable(tuple(player, t, float)) = external {}

    # Detection has finished e.g. no required keys are now down. Will always
    # fire as a pair with BeginDetectEvent.
    #  Tuple payload: 0: the player generating this event
    #                 1: elapsed seconds since detection began
    EndDetectEvent<public><native>: listenable(tuple(player, float)) = external {}

    (/Verse.org/Input/input_events:)Input_input_events_Variance<private>(): tuple(t, t, t, t) = external {}

    # This input has met all required conditions and has successfully fired.
    # Most of the time, you should bind to this event.
    #  Tuple payload: 0: the player generating this event
    #                 1: the value generated by the physical input
    TriggerActivationEvent<public><native>: listenable(tuple(player, t)) = external {}
  }

  @import_as("/Script/VerseInput.UVerseInputEventsBase")
  input_events_base<epic_internal><native> := class<abstract> {}

  # Represents the player's current preferred input method.
  input_method<public><native> := enum<open> {
    Gamepad

    KeyboardAndMouse

    Touch
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # The per-player input manager. Get one for a player with 'GetPlayerInput',
  # then use it to:   * Turn input mappings on or off for that player with
  # 'AddInputMapping' / 'RemoveInputMapping'.   * Get the 'input_events' object
  # for an 'input_action' with 'GetInputEvents', and subscribe to its events to
  # react to that input. An input_action only generates events for a player
  # while at least one input_mapping that references it is active on
  # that player.
  player_input<public><native> := class {
    # Adds the given input_mapping to the player, enabling the input_actions
    # within it to be processed and execute events.
    AddInputMapping<public><native>(InputMapping: input_mapping): void

    # Returns the input_events object for the given input_action, allowing you
    # to bind to events for this action.
    GetInputEvents<public><native>(ActionToBind: input_action(t) where t: type): input_events(t)

    @available { MinUploadedAtFNVersion := 4200 }
    @deprecated { Message := "Use GetInputEvents." }
    GetPredictsInputEvents<epic_internal>(
      ActionToBind: input_action(t) where t: type
    ): predicts_input_events(t) = external {}

    MakeFloatInputEvents<epic_internal><native_callable>(): input_events(float) = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @deprecated { Message := "Use GetInputEvents." }
    MakeFloatPredictsInputEvents<epic_internal>(): predicts_input_events(float) = external {}

    MakeLogicInputEvents<epic_internal><native_callable>(): input_events(logic) = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @deprecated { Message := "Use GetInputEvents." }
    MakeLogicPredictsInputEvents<epic_internal>(): predicts_input_events(logic) = external {}

    MakeVector3InputEvents<epic_internal><native_callable>(): input_events(
      (/Verse.org/SpatialMath:)vector3
    ) = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    @deprecated { Message := "Use GetInputEvents." }
    MakeVector3PredictsInputEvents<epic_internal>(): predicts_input_events(
      (/Verse.org/SpatialMath:)vector3
    ) = external {}

    # Removes the given input_mapping from the player, which will disable the
    # input_actions within it from being processed and prevent them from
    # executing events.
    RemoveInputMapping<public><native>(InputMapping: input_mapping): void

    # The set of input device capabilities currently available to the player,
    # updated at runtime as devices connect or disconnect.
    var<internal> AvailableInputDevices<public><native>: available_input_devices = external {}

    # The player's current preferred input method, updated when the player
    # switches between keyboard/mouse, gamepad, or touch.
    var<internal> PreferredInputMethod<public><native>: input_method = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @deprecated { Message := "Use the input_events returned by GetInputEvents." }
  predicts_input_events<epic_internal>(t: type) := class {
    BeginDetectEvent<epic_internal>: listenable(tuple(?player, t)) = external {}

    CancelActivationEvent<epic_internal>: listenable(tuple(?player, t, float)) = external {}

    DetectionOngoingEvent<epic_internal>: listenable(tuple(?player, t, float)) = external {}

    EndDetectEvent<epic_internal>: listenable(tuple(?player, float)) = external {}

    (/Verse.org/Input/predicts_input_events:)Input_predicts_input_events_Variance<private>(): tuple(
      t,
      t,
      t,
      t
    ) = external {}

    TriggerActivationEvent<epic_internal>: listenable(tuple(?player, t)) = external {}
  }
}

Leaderboards<public> := module {
  using { /Verse.org/Simulation }
  # Verse path: /Verse.org/Leaderboards
  # # Leaderboard that supports a `GetTop` implementation that only returns the
  # data needed to display the leaderboard.
  # # Leaderboard that supports a `GetTop` implementation that only returns the
  # data needed to display the leaderboard.
  player_leaderboard<epic_internal><native> := class<final><computes> {
    GetTop<public><native>(Limit: int): []tuple(int, message, float)

    VersePath<epic_internal><native>: string = external {}

    WriteStat<public><native>(Player: player, Value: float): void
  }
}

# Module import path: /Verse.org/Native
Native<public> := module {
  cpp_name<epic_internal><constructor>(CPPName: string)<computes>: cpp_name_attribute = external {}

  @attribscope_class
  @attribscope_struct
  @attribscope_enum
  @attribscope_interface
  @attribscope_module
  cpp_name_attribute<epic_internal> := class<internal><computes>(attribute) {}

  doc<epic_internal><constructor>(DocumentationString: string)<computes>: doc_attribute = external {}

  @attribscope_module
  @attribscope_class
  @attribscope_struct
  @attribscope_function
  @attribscope_data
  @attribscope_enum
  @attribscope_enumerator
  @attribscope_interface
  @attribscope_typedefinition
  doc_attribute<epic_internal> := class<internal><computes>(attribute) {}

  import_as<epic_internal><constructor>(ImportName: string)<computes>: import_as_attribute = external {}

  @attribscope_class
  @attribscope_struct
  @attribscope_enum
  @attribscope_interface
  @attribscope_module
  import_as_attribute<epic_internal> := class<internal><computes>(attribute) {}

  @attribscope_class
  preload<epic_internal> := class<computes>(attribute) {}

  @cpp_name("verse::property_changed_interface")
  property_changed_interface<epic_internal><native> := interface {
    OnPropertyChangedFromVerse<epic_internal>(PropertyName: string)<transacts>: void
  }

  validate_asset_path<epic_internal><constructor>(
    Modifiers: string
  )<computes>: validate_asset_path_attribute = external {}

  @attribscope_function
  @attribscope_data
  validate_asset_path_attribute<epic_internal> := class<internal><computes>(attribute) {}
}

@cpp_name("verse::VerseNative_Verse_org_Persona_module_impl")
# Module import path: /Verse.org/Persona
Persona<epic_internal> := module {
  Cast<epic_internal><native>(__dupe___unnamed_parameter_0: any, t: type)<decides><converges>: t

  # From a JSON string representing a sparse array where each element, if it
  # exists, conforms to the corresponding type element, produce array of
  # optional values.
  FromJson<epic_internal><native>((
    __dupe___unnamed_parameter_0: string,
    __dupe___unnamed_parameter_1: []subtype(t)
  ) where t: type)<decides><reads><converges>: []?t

  # From a JSON string conforming to the schema for a type, produce a value of
  # that type.
  FromJson<epic_internal><native>(__dupe___unnamed_parameter_0: string, t: type)<decides><reads><converges>: t

  # From an array of types produce a JSON schema corresponding to an object with
  # optional fields of name 0, 1, etc., i.e. a sparse array.
  ToJson<epic_internal><native>(__dupe___unnamed_parameter_0: []type)<decides><reads><converges>: string

  # From a type produce a JSON schema.
  ToJson<epic_internal><native>(__dupe___unnamed_parameter_0: type)<decides><reads><converges>: string
}

# Verse path: /Verse.org
# Module import path: /Verse.org/Predicts
Predicts<public> := module {
  PredictsDebugAddClientWithID<epic_internal><native>(ClientID: int)<transacts>: void

  PredictsDebugCallFunc<epic_internal><native>(__dupe___unnamed_parameter_0: int)<transacts>: void

  PredictsDebugCheckClientAbortedContentScopeAndReset<epic_internal><native>()<transacts><decides>: void

  PredictsDebugClientMode<epic_internal><native>(NodeID: int)<transacts><decides>: void

  PredictsDebugFindNamedID<epic_internal><native>(Name: string)<transacts><decides>: int

  PredictsDebugFindObject<epic_internal><native>(ObjectID: int)<transacts><decides>: any

  PredictsDebugFindObjectID<epic_internal><native>(Obj: any)<transacts><decides>: int

  PredictsDebugFindObjectNamed<epic_internal><native>(Name: string)<transacts><decides>: any

  PredictsDebugGCPinObject<epic_internal><native>(__dupe___unnamed_parameter_0: any)<transacts>: void

  PredictsDebugGCUnpinObject<epic_internal><native>(__dupe___unnamed_parameter_0: any)<transacts>: void

  PredictsDebugGetObjectGen<epic_internal><native>(Obj: any)<transacts><decides>: int

  PredictsDebugGetObjectSeq<epic_internal><native>(Obj: any)<transacts><decides>: int

  PredictsDebugIsFrankenClient<epic_internal><native>()<transacts><decides>: void

  PredictsDebugIsFrankenServer<epic_internal><native>()<transacts><decides>: void

  PredictsDebugIsFrankenTest<epic_internal><native>()<transacts><decides>: void

  PredictsDebugNameID<epic_internal><native>(ID: int, Name: string)<transacts>: void

  PredictsDebugNameObject<epic_internal><native>(Obj: any, Name: string)<transacts><decides>: void

  PredictsDebugRegisterFunc<epic_internal><native>(
    __dupe___unnamed_parameter_0: int,
    __dupe___unnamed_parameter_1: type { _(): void }
  )<transacts>: int

  PredictsDebugRemoveClientWithID<epic_internal><native>(ClientID: int)<transacts>: void

  PredictsDebugReplicateToClients<epic_internal><native>()<transacts>: void

  PredictsDebugResetAllDataAndCallbacks<epic_internal><native>()<transacts>: void

  PredictsDebugServerMode<epic_internal><native>()<transacts>: void

  PredictsDebugTryCallFunc<epic_internal><native>(__dupe___unnamed_parameter_0: int)<transacts>: logic

  PredictsDebugUnregisterFunc<epic_internal><native>(__dupe___unnamed_parameter_0: int)<transacts>: void

  PredictsDebugUseReachabilityBasedReplication<epic_internal><native>()<transacts>: void

  PredictsIsRunningOnServer<epic_internal><native>()<transacts><decides>: void

  PredictsServerMarkObjectField<epic_internal><native>(Obj: any, FieldName: string)<transacts>: void

  PredictsServerRegisterObject<epic_internal><native>(__dupe___unnamed_parameter_0: any)<transacts>: any
}

Presentation<public> := module {
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  # Verse path: /Verse.org/Presentation
  change_description_component_event<epic_internal> := class(scene_event) {
    DescriptionComponent<public>: ?description_component = external {}

    Entity<public>: entity
  }

  # Component that holds the details for an entity, such as name
  # and description.
  description_component<public><native> := class<final_super>(component, has_description) {
    OnBeginSimulation<override>(): void = external {}

    OnDescriptionChanged<epic_internal><native_callable>(): void = external {}

    OnEndSimulation<override>(): void = external {}

    var Description<override>: message = external {}

    var Name<override>: message = external {}

    var ShortDescription<override>: message = external {}
  }

  # Interface that provides descriptive names or text.
  has_description<public><native> := interface {
    @editable
    # The full description of this entity.
    var Description<public>: message

    @editable
    # The display name of this entity.
    var Name<public>: message

    @editable
    # A shortened description of this entity.
    var ShortDescription<public>: message
  }
}

using { /Verse.org/Native }
# Verse path: /Verse.org
@available { MinUploadedAtFNVersion := 4110 }
# Module import path: /Verse.org/Progression
Progression<public> := module {
  @experimental
  MakeAbandonQuestErrorResult<epic_internal><native_callable>(): result(void, []abandon_quest_error) = external {}

  @experimental
  MakeAbandonQuestSuccessResult<epic_internal><native_callable>(): result(
    comparable,
    []abandon_quest_error
  ) = external {}

  @experimental
  MakeJoinQuestErrorResult<epic_internal><native_callable>(): result(void, []join_quest_error) = external {}

  @experimental
  MakeJoinQuestSuccessResult<epic_internal><native_callable>(): result(comparable, []join_quest_error) = external {}

  @experimental
  MakeRevokeQuestErrorResult<epic_internal><native_callable>(): result(void, []remove_quest_error) = external {}

  @experimental
  MakeRevokeQuestSuccessResult<epic_internal><native_callable>(): result(comparable, []remove_quest_error) = external {}

  @experimental
  # Returned when a participant cannot abandon a quest.
  abandon_quest_error<public><native> := class {}

  @experimental
  abandon_quest_not_joined_error<epic_internal><native> := class<epic_internal>(abandon_quest_error) {}

  @experimental
  abandon_quest_vetoed_error<epic_internal><native> := class<epic_internal>(abandon_quest_error) {}

  @experimental
  add_quest_error<epic_internal><native> := class<epic_internal> {}

  @experimental
  add_quest_vetoed_error<epic_internal><native> := class<epic_internal>(add_quest_error) {}

  @experimental
  # A quest participant backed by an agent (player, NPC, AI, etc.).
  agent_quest_participant<public><native> := class<final>(quest_participant) {
    # The agent this participant represents.
    Agent<public><native>: agent
  }

  using { /Verse.org/AgentGroup }
  using { /Verse.org/Assets }
  using { /Verse.org/Presentation }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  @experimental
  epic_quest_participant_component<epic_internal><native> := class<epic_internal>(quest_participant_component) {
    ClearTrackedQuests<epic_internal><final><native>()<transacts>: void

    OnBeginSimulation<override>(): void = external {}

    TrackQuest<epic_internal><final><native>(Quest: quest)<transacts><decides>: void

    UntrackQuest<epic_internal><final><native>(Quest: quest)<transacts>: void

    var<private> ObservedQuests<epic_internal><native>: []quest = external {}

    var<private> TrackedQuests<epic_internal><native>: []quest = external {}
  }

  @experimental
  failed_quest_completion<epic_internal><native> := class(quest_completion_context) {}

  @experimental
  join_quest_already_joined_error<epic_internal><native> := class<epic_internal>(join_quest_error) {}

  @experimental
  # Returned when a participant cannot join a quest.
  join_quest_error<public><native> := class {}

  @experimental
  join_quest_invalid_state_error<epic_internal><native> := class<epic_internal>(join_quest_error) {}

  @experimental
  join_quest_vetoed_error<epic_internal><native> := class<epic_internal>(join_quest_error) {}

  @experimental
  # A completable goal.
  # Call Complete() to mark the quest as done and fire CompleteEvent.
  quest<public><native> := class<abstract><castable><unique> {
    # Signaled when a participant abandons this quest.
    AbandonEvent<public><final><native>: listenable(quest_membership) = external {}

    Activate<epic_internal><final><native>()<transacts>: void

    CanAbandon<epic_internal><native><native_callable>(
      QuestParticipant: quest_participant
    )<reads>: result(void, []abandon_quest_error)

    CanAdd<epic_internal><native><native_callable>(Manager: quest_manager_component)<decides><reads>: void

    CanJoin<epic_internal><native><native_callable>(
      QuestParticipant: quest_participant
    )<reads>: result(void, []join_quest_error)

    CanRemove<epic_internal><native><native_callable>(Manager: quest_manager_component)<decides><reads>: void

    # Marks this quest as completed. Fires CompleteEvent.
    # Idempotent — no-op if already completed.
    Complete<public><final><native>()<transacts>: void

    # Signaled when this quest completes.
    CompleteEvent<public><final><native>: listenable(quest) = external {}

    Deactivate<epic_internal><final><native>()<transacts>: void

    Fail<epic_internal><final><native>()<transacts>: void

    GetCompletionContext<epic_internal><final><native>()<reads>: ?quest_completion_context

    GetState<epic_internal><final><native>()<reads>: quest_state

    IsActive<epic_internal><final><native>()<decides><reads>: void

    # Succeeds if this quest is completed.
    IsComplete<public><final><native>()<decides><reads>: void

    # Signaled when a participant joins this quest.
    JoinEvent<public><final><native>: listenable(quest_membership) = external {}

    OnAbandon<epic_internal><native><native_callable>(QuestParticipant: quest_participant): void

    OnActivate<epic_internal><native><native_callable>(): void

    OnAdd<epic_internal><native><native_callable>(Manager: quest_manager_component): void

    OnComplete<epic_internal><native><native_callable>(): void

    OnDeactivate<epic_internal><native><native_callable>(): void

    OnJoin<epic_internal><native><native_callable>(QuestParticipant: quest_participant): void

    OnRemove<epic_internal><native><native_callable>(Manager: quest_manager_component): void

    StateChangedEvent<epic_internal><final><native>: listenable(tuple(quest, quest_state, quest_state)) = external {}

    var<private> OwningCollection<epic_internal><native>: ?quest_collection = external {}

    var<private> OwningManager<epic_internal><native>: ?quest_manager_component = external {}
  }

  @experimental
  quest_bundle<epic_internal><native> := class<epic_internal><unique>(has_icon, has_description) {
    GetCompletedCount<epic_internal><final><native>()<reads>: int

    GetProgress<epic_internal><final><native>()<reads>: message

    IsComplete<epic_internal><final><native>()<decides><reads>: void

    var Quests<epic_internal><native>: []quest
  }

  @experimental
  # The source of truth for quest participation.
  quest_collection<public><native> := class<unique> {
    # Signaled when a participant abandons any quest in this collection.
    AbandonEvent<public><final><native>: listenable(quest_membership) = external {}

    # Removes 'Participant' from 'Quest'.
    AbandonQuest<public><final><native>(
      Quest: quest,
      Participant: quest_participant
    )<transacts>: result(void, []abandon_quest_error)

    ActivateEvent<epic_internal><final><native>: listenable(quest) = external {}

    # Signaled when any quest in this collection completes.
    CompleteEvent<public><final><native>: listenable(quest) = external {}

    DeactivateEvent<epic_internal><final><native>: listenable(quest) = external {}

    # Signaled when a participant joins any quest in this collection.
    JoinEvent<public><final><native>: listenable(quest_membership) = external {}

    # Adds 'Participant' to 'Quest' with the given participation info.
    JoinQuest<public><final><native>(
      Quest: quest,
      Participant: quest_participant,
      Info: quest_participant_info
    )<transacts>: result(void, []join_quest_error)

    OnComplete<epic_internal><native><native_callable>(Quest: quest): void

    # All memberships indexed by participant.
    var<private> Participants<public><native>: [quest_participant][]quest_membership = external {}

    # All memberships indexed by quest.
    var<private> Quests<public><native>: [quest][]quest_membership = external {}
  }

  @experimental
  quest_completion_context<epic_internal><native> := class {}

  @experimental
  quest_granter_component<epic_internal><native> := class<epic_internal><final_super>(component) {
    CanGrant<epic_internal><native><native_callable>(Manager: quest_manager_component)<decides><reads>: void

    GrantEvent<epic_internal><final><native>: listenable(quest) = external {}

    GrantQuests<epic_internal><final><native>(Manager: quest_manager_component)<transacts>: []quest

    OnGrant<epic_internal><native><native_callable>(Manager: quest_manager_component, Quest: quest): void

    QuestsToGrant<epic_internal><native>: []subtype(quest)
  }

  @experimental
  quest_manager_component<epic_internal><native> := class<epic_internal><final_super>(component) {
    AbandonQuest<epic_internal><native><native_callable>(
      Quest: quest,
      Participant: quest_participant
    )<transacts>: result(void, []abandon_quest_error)

    AddQuest<epic_internal><native><native_callable>(Quest: quest): void

    CanAdd<epic_internal><native><native_callable>(Quest: quest)<decides><reads>: void

    CanRemove<epic_internal><native><native_callable>(Quest: quest)<decides><reads>: void

    Collection<epic_internal><native>: quest_collection

    GrantEvent<epic_internal><final><native>: listenable(quest) = external {}

    GrantQuest<epic_internal><native><native_callable>(
      quest_type: subtype(quest)
    )<transacts>: result(quest_type, []add_quest_error)

    JoinQuest<epic_internal><native><native_callable>(
      Quest: quest,
      Participant: quest_participant,
      Info: quest_participant_info
    )<transacts>: result(void, []join_quest_error)

    OnAdd<epic_internal><native><native_callable>(Quest: quest): void

    OnRemove<epic_internal><native><native_callable>(Quest: quest): void

    RemoveQuest<epic_internal><native><native_callable>(Quest: quest): void

    RevokeEvent<epic_internal><final><native>: listenable(quest) = external {}

    RevokeQuest<epic_internal><native><native_callable>(Quest: quest)<transacts>: result(void, []remove_quest_error)

    var<private> Quests<epic_internal><native>: []quest = external {}
  }

  @experimental
  # Record binding a quest to a participant with participation info.
  quest_membership<public><native> := class {
    # The participation info describing this participant's role.
    Info<public><native>: quest_participant_info

    # The participant in this membership.
    Participant<public><native>: quest_participant

    # The quest this membership belongs to.
    Quest<public><native>: quest
  }

  @experimental
  # Abstract base class for quest participants.
  quest_participant<public><native> := class<abstract><unique> {
    # Signaled when this participant abandons a quest.
    AbandonEvent<public><final><native>: listenable(quest_membership) = external {}

    CanAbandon<epic_internal><native><native_callable>(Quest: quest)<reads>: result(void, []abandon_quest_error)

    CanJoin<epic_internal><native><native_callable>(Quest: quest)<reads>: result(void, []join_quest_error)

    # Signaled when a quest this participant is in completes.
    CompleteEvent<public><final><native>: listenable(quest_membership) = external {}

    GetParticipatingQuests<epic_internal><final><native>()<reads>: []quest

    # Signaled when this participant joins a quest.
    JoinEvent<public><final><native>: listenable(quest_membership) = external {}

    OnAbandon<epic_internal><native><native_callable>(Quest: quest): void

    OnActivate<epic_internal><native><native_callable>(Quest: quest): void

    OnComplete<epic_internal><native><native_callable>(Quest: quest): void

    OnDeactivate<epic_internal><native><native_callable>(Quest: quest): void

    OnJoin<epic_internal><native><native_callable>(Quest: quest): void

    var<private> Memberships<epic_internal><native>: []quest_membership = external {}
  }

  @experimental
  quest_participant_component<epic_internal><native> := class<epic_internal><final_super>(component) {
    Participant<epic_internal><native>: agent_quest_participant
  }

  @experimental
  # Describes how a participant relates to a quest.
  quest_participant_info<public><native> := class(member_info_interface) {
    # Can this participant make progress on the quest.
    var Contributes<public><native>: logic = external {}

    # Can this participant observe quest state.
    var Observes<public><native>: logic = external {}

    # Can this participant receive rewards on quest completion.
    var Receives<public><native>: logic = external {}
  }

  @experimental
  quest_state<epic_internal><native> := enum<open><persistable> {
    Active

    Completed

    Inactive
  }

  @experimental
  remove_quest_error<epic_internal><native> := class<epic_internal> {}

  @experimental
  remove_quest_vetoed_error<epic_internal><native> := class<epic_internal>(remove_quest_error) {}
}

# Module import path: /Verse.org/Random
Random<public> := module {
  # Returns a uniformly distributed, cryptographically-secure random `float`
  # between `Low` and `High`, inclusive. (`Low` and `High` can be out of order.)
  GetRandomFloat<public><native>(Low: float, High: float)<transacts>: float

  # Returns a uniformly distributed, cryptographically-secure random `int`
  # between `Low` and `High`, inclusive. (`Low` and `High` can be out of order.)
  GetRandomInt<public><native>(Low: int, High: int)<transacts>: int

  # Makes an `array` with the same elements as `Input` shuffled in a
  # random order.
  Shuffle<public>(Input: []t where t: type)<transacts>: []t = external {}
}

# Verse path: /Verse.org
# Module import path: /Verse.org/Restricted
Restricted<public> := module {
  using { /Verse.org/Native }
  sticky_event<public><native>(t: type) := class(event(t)) {
    Await<native><override>()<suspends>: t

    ClearSignal<public><native>()<writes>: void

    IsSignaled<public><native>()<decides><reads>: void

    (/Verse.org/Restricted/sticky_event:)Restricted_sticky_event_Variance<private>(: t): tuple(t) = external {}

    @available { MinUploadedAtFNVersion := 4210 }
    (/Verse.org/Restricted/sticky_event:)Restricted_sticky_event_Variance_Inherited<private>(
      : t,
      : t,
      : t,
      : t
    ): tuple(t, t, t, t) = external {}

    Signal<native><override>(__dupe___unnamed_parameter_2: t): void
  }

  sticky_event<public>() := sticky_event(void)
}

SceneGraph<public> := module {
  # Suspends until the character's pawn is within PositionTolerance of
  # ExpectedPosition and RotationTolerance of ExpectedRotation, and its physics
  # has settled (stopped moving, grounded), or the timeout elapses.Returns true
  # on success, false on timeout. Player characters only.
  (Agent: agent).WaitForTeleportTo<epic_internal><native>(
    ExpectedPosition: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
    ExpectedRotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation,
    PositionTolerance: float,
    RotationToleranceDegrees: float,
    IgnoreUp: logic,
    VelocityTolerance: float,
    Timeout: float
  )<suspends>: logic

  # Find all objects in the scene that currently overlap this entity.
  (Entity: entity).FindOverlapHits<public>()<transacts>: generator(overlap_hit) = external {}

  # Find all objects in the scene that would overlap this entity if it were
  # placed at GlobalTransform.
  (Entity: entity).FindOverlapHits<public>(
    GlobalTransform: (/Verse.org/SpatialMath:)transform
  )<transacts>: generator(overlap_hit) = external {}

  # Find all objects in the scene that would overlap Volume if they were placed
  # at GlobalTransform. NOTE: This entity defines the context(scene) for the
  # query but does not otherwise take part in the sweep.
  (Entity: entity).FindOverlapHits<public>(
    GlobalTransform: (/Verse.org/SpatialMath:)transform,
    Volume: collision_volume
  )<transacts>: generator(overlap_hit) = external {}

  # Find objects in the scene that would intersect this entity if it were swept
  # from its location along the Displacement vector. Returns the first object
  # interacting as collision_interaction.Block, and all objects interacting as
  # collision_interaction.Overlap encountered before the first block. Hits are
  # sorted by hit distance, so the blocking hit will be last.
  (Entity: entity).FindSweepHits<public>(
    Displacement: (/Verse.org/SpatialMath:)vector3
  )<transacts>: generator(sweep_hit) = external {}

  # Find objects in the scene that would intersect this entity if it were swept
  # from GlobalTransform along the Displacement vector. Returns the first object
  # interacting as collision_interaction.Block, and all objects interacting as
  # collision_interaction.Overlap encountered before the first block. Hits are
  # sorted by hit distance, so the blocking hit will be last.
  (Entity: entity).FindSweepHits<public>(
    Displacement: (/Verse.org/SpatialMath:)vector3,
    StartGlobalTransform: (/Verse.org/SpatialMath:)transform
  )<transacts>: generator(sweep_hit) = external {}

  # Find all objects in the scene that would intersect Volume if they were swept
  # from GlobalTransform along the Displacement vector Hits are sorted by hit
  # distance. NOTE: This entity defines the context(scene) for the query but
  # does not otherwise take part in the sweep.
  (Entity: entity).FindSweepHits<public>(
    Displacement: (/Verse.org/SpatialMath:)vector3,
    StartGlobalTransform: (/Verse.org/SpatialMath:)transform,
    Volume: collision_volume
  )<transacts>: generator(sweep_hit) = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  # Get the players that this entity is currently be presented to. False
  # = presentable to everyone, array = presentable to no one.
  (Entity: entity).GetPresentableToPlayers<public><native>()<transacts>: ?[]player

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  # Play a skeletal_animation on an entity
  (Entity: entity).PlaySkeletalAnimation<public>(
    Animation: skeletal_animation,
    ?EaseInWindow: easing_window = external {},
    ?EaseOutWindow: easing_window = external {}
  )<transacts><decides>: play_skeletal_animation_result = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  # Assign the players that this entity will be presented to. False
  # = presentable to everyone, array = presentable to no one.
  (Entity: entity).SetPresentableToPlayers<public><native>(Players: ?[]player): void

  # Possess an entity. Fails if
  # PossessableComponent.CanBePossessedBy[Self] fails.
  (InAgent: agent).BeginPossess<epic_internal>(
    PossessableComponent: possessable_component
  )<transacts><decides>: void = external {}

  # Unpossess an entity.
  (InAgent: agent).EndPossess<epic_internal>(PossessableComponent: possessable_component)<transacts>: void = external {}

  # Event that will fire when a new entity is possessed.
  (InAgent: agent).GetBeginPossessEvent<epic_internal>(): listenable(possessable_component) = external {}

  # Event that will fire when an entity is unpossessed.
  #  Entities are automatically unpossessed when removed from the scene
  (InAgent: agent).GetEndPossessEvent<epic_internal>(): listenable(possessable_component) = external {}

  # All entities possessed by this agent.
  (InAgent: agent).GetPossessedEntities<public>()<reads>: []possessable_component = external {}

  # Checks if an entity is possessed.
  (InAgent: agent).IsEntityPossessed<public>(
    PossessableComponent: possessable_component
  )<decides><reads>: void = external {}

  # Finds all components attached to ancestor entities to `InEntity` of
  # type `component_type`.
  # The order of the returned components is unspecified and subject to change.
  (InEntity: entity).FindAncestorComponents<public><native>(
    component_type: castable_subtype(component)
  )<transacts>: generator(component_type)

  # Finds all ancestor entities to `InEntity` of type `entity_type`.
  # The order of the returned entities is unspecified and subject to change.
  (InEntity: entity).FindAncestorEntities<public><native>(
    entity_type: castable_subtype(entity)
  )<transacts>: generator(entity_type)

  # Finds all ancestor entities to `InEntity` containing a component of
  # type `component_type`.
  # The order of the returned entities is unspecified and subject to change.
  (InEntity: entity).FindAncestorEntitiesWithComponent<public><native>(
    component_type: castable_subtype(component)
  )<transacts>: generator(entity)

  # Finds all ancestor entities to `InEntity` that has any tags of
  # type `tag_type`.
  # The order of the returned entities is unspecified and subject to change.
  (InEntity: entity).FindAncestorEntitiesWithTag<public><native>(
    tag_type: castable_subtype(tag)
  )<transacts>: generator(entity)

  # Finds all components attached to descendant entities to and including
  # `InEntity` of type `component_type`.
  # The order of the returned components is unspecified and subject to change.
  (InEntity: entity).FindDescendantComponents<public><native>(
    component_type: castable_subtype(component)
  )<transacts>: generator(component_type)

  # Finds all descendant entities including `InEntity` of type `entity_type`.
  # The order of the returned entities is unspecified and subject to change.
  (InEntity: entity).FindDescendantEntities<public><native>(
    entity_type: castable_subtype(entity)
  )<transacts>: generator(entity_type)

  # Finds all descendant entities including `InEntity` containing a component of
  # type `component_type`.
  # The order of the returned entities is unspecified and subject to change.
  (InEntity: entity).FindDescendantEntitiesWithComponent<public><native>(
    component_type: castable_subtype(component)
  )<transacts>: generator(entity)

  # Finds all descendant entities including `InEntity` that has any tags of
  # type `tag_type`.
  # When querying from the simulation entity, the simulation entity itself is
  # not included in the results.
  # The order of the returned entities is unspecified and subject to change.
  (InEntity: entity).FindDescendantEntitiesWithTag<public><native>(
    tag_type: castable_subtype(tag)
  )<transacts>: generator(entity)

  # Returns the bounds of this entity by accumulating bounded components,
  # including owned entities, in world space.
  (InEntity: entity).GetGlobalBounds<epic_internal><native>()<transacts>: bounded_box

  # Returns the global transform of this entity, in the case the entity does not
  # have a transform_component it will return the transform of the first parent
  # that has a transform
  (InEntity: entity).GetGlobalTransform<public><native>()<transacts>: (/Verse.org/SpatialMath:)transform

  # Returns the bounds of this entity by accumulating bounded components,
  # including owned entities, in local space.
  (InEntity: entity).GetLocalBounds<epic_internal><native>()<transacts>: bounded_box

  # Returns the local transform of this entity, in the case the entity does not
  # have a transform_component it will return identity
  (InEntity: entity).GetLocalTransform<public><native>()<transacts>: (/Verse.org/SpatialMath:)transform

  # Returns the origin of the entity in any, in the case the entity does not
  # have a transform_component the method will fail
  (InEntity: entity).GetOrigin<public><native>()<transacts><decides>: origin

  # Returns the bounds of this entity by accumulating bounded components, not
  # including owned entities, in world space.
  (InEntity: entity).GetSelfGlobalBounds<epic_internal><native>()<transacts>: bounded_box

  # Returns the bounds of this entity by accumulating bounded components, not
  # including owned entities, in local space.
  (InEntity: entity).GetSelfLocalBounds<epic_internal><native>()<transacts>: bounded_box

  # Returns the simulation entity parent for this entity.
  #   * The simulation entity is the rootmost entity in an experience.
  #   * Fails if this entity is not currently in the scene.
  (InEntity: entity).GetSimulationEntity<public><native>()<transacts><decides>: entity

  (InEntity: entity).Preload<epic_internal><native>()<suspends>: logic

  # Resets the origin of this entity, which will now default to its parent
  (InEntity: entity).ResetOrigin<public><native>()<transacts>: void

  # Sets the global transform of this entity, in the case the entity does not
  # have a transform_component it will create one and set its global transform
  (InEntity: entity).SetGlobalTransform<public><native>(
    NewGlobalTransform: (/Verse.org/SpatialMath:)transform
  )<transacts>: void

  # Sets the local transform of this entity, in the case the entity does not
  # have a transform_component it will create one and set its local transform
  (InEntity: entity).SetLocalTransform<public><native>(
    NewLocalTransform: (/Verse.org/SpatialMath:)transform
  )<transacts>: void

  # Sets the origin of this entity, in the case the entity does not have a
  # transform_component it will create one and set its origin. This method fails
  # if it recognized dependency recursion.
  (InEntity: entity).SetOrigin<public><native>(NewOrigin: origin)<transacts>: void

  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /Verse.org/SpatialMath }
  # Verse path: /Verse.org/SceneGraph
  # Suspends until the transform update completes or the timeout elapses.
  # Returns true on success, false if the move did not complete in time.
  (InEntity: entity).WaitForGlobalTransform<epic_internal><native>(
    Agent: agent,
    NewGlobalTransform: (/Verse.org/SpatialMath:)transform,
    ?Timeout: float
  )<suspends>: logic

  # Suspends until the transform update completes or the timeout elapses.
  # Returns true on success, false if the move did not complete in time.
  (InEntity: entity).WaitForLocalTransform<epic_internal><native>(
    Agent: agent,
    NewLocalTransform: (/Verse.org/SpatialMath:)transform,
    ?Timeout: float
  )<suspends>: logic

  @available { MinUploadedAtFNVersion := 4100 }
  # Plaform-specific viewport to add specialized screen-space UI to. Always
  # renders on top of the regular viewport.
  (Player: player).GetPlatformViewport<epic_internal><native>()<transacts>: (/Verse.org/SceneGraph:)UI.widget

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  # Viewport to add all screen-space UI to.
  (Player: player).GetViewport<epic_internal><native>()<transacts>: (/Verse.org/SceneGraph:)UI.widget

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  CloneCameraBody<epic_internal><constructor>(CameraBody: camera_body)<computes>: camera_body = external {}

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  CloneCameraLens<epic_internal><constructor>(CameraLens: camera_lens)<computes>: camera_lens = external {}

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  CloneCameraState<epic_internal><constructor>(CameraState: camera_state)<computes>: camera_state = external {}

  # Module import path: /Verse.org/SceneGraph/CollisionChannels
  # The set of built-in collision_channels. This is a closed set for now.
  CollisionChannels<public> := module {
    avatar<public><native> := class(collision_channel) {}

    camera<public><native> := class(collision_channel) {}

    dynamic<public><native> := class(collision_channel) {}

    physics<public><native> := class(collision_channel) {}

    stationary<public><native> := class(collision_channel) {}

    visibility<public><native> := class(collision_channel) {}
  }

  # Module import path: /Verse.org/SceneGraph/CollisionProfiles
  # A set of useful collision profiles. New profiles can be created in
  # Verse code
  CollisionProfiles<public> := module {
    # Dynamic collision channel, Block all channels
    DynamicBlockAll<public>: collision_profile = external {}

    # Dynamic collision channel, Ignore all channels
    DynamicIgnoreAll<public>: collision_profile = external {}

    # Dynamic collision channel, Overlap all channels
    DynamicOverlapAll<public>: collision_profile = external {}

    # Stationary collision channel, Block all channels
    StationaryBlockAll<public>: collision_profile = external {}

    # Stationary collision channel, Block all channels except visibility (used
    # for e.g., invisible wall, glass)
    StationaryBlockVisible<public>: collision_profile = external {}

    # Stationary collision channel, Ignore all channels
    StationaryIgnoreAll<public>: collision_profile = external {}

    # Stationary collision channel, Overlap all channels
    StationaryOverlapAll<public>: collision_profile = external {}

    # Visibility collision channel, Overlap all channel (used for e.g.,
    # visibility testing)
    VisibilityOverlapAll<public>: collision_profile = external {}
  }

  DefaultChannelToInteraction<epic_internal>(
    __dupe___unnamed_parameter_0: collision_channel
  )<computes>: collision_interaction = external {}

  EmptyOverlapHitsGenerator<epic_internal><native>()<transacts>: generator(overlap_hit)

  EmptySweepHitsGenerator<epic_internal><native>()<transacts>: generator(sweep_hit)

  # Verse path: /Verse.org/SceneGraph
  # Module import path: /Verse.org/SceneGraph/FNECon
  FNECon<public> := module {
    @experimental
    # Used to handle general conversation.
    conversation_component<epic_internal><native> := class<epic_internal><final_super>(component, enableable) {
      # Event that sends the participating agent when a conversation has ended.
      ConversationEndedEvent<public><native>: listenable(agent) = external {}

      # Event that sends the participating agent when a conversation
      # has started.
      ConversationStartedEvent<public><native>: listenable(agent) = external {}

      # Disables this component.
      Disable<native><override>(): void

      # Enables this component.
      Enable<native><override>(): void

      # Ends all conversations associated with this component.
      EndAllConversations<public><native>(): void

      # Ends a conversation with the input agent.
      EndConversation<public><native>(Agent: agent): void

      # Gets the speaker's name.
      GetSpeakerName<public><native>(): message

      # Succeeds if the component is enabled. Fails if it’s disabled.
      IsEnabled<native><override>()<transacts><decides>: void

      OnBeginSimulationInternal<native><override>(): void

      OnEndSimulationInternal<native><override>(): void

      OnInitializedInternal<native><override>(): void

      OnRemovingFromSceneInternal<native><override>(): void

      OnUninitializingInternal<native><override>(): void

      # Sets the name of the speaker that is displayed during conversations.
      SetSpeakerName<public><native>(InSpeakerName: message): void

      # Starts a conversation with the input agent.
      StartConversation<public><native>(Agent: agent): void

      @editable
      # The conversation database used when a conversation is started.
      var ConversationDatabase<public><native>: conversation_database = external {}

      @editable
      # Determines the range at which a player will be able to see the speech
      # bubble (in meters). If set to less than 2m, the player will not see an
      # indicator speech bubble.
      var IndicatorBubbleRange<public><native>: float = external {}

      @editable
      # The max number of participants allowed to interact with this
      # component simultaneously.
      var MaximumParticipatingAgents<public><native>: int = external {}
    }

    using { /Verse.org/Assets }
    using { /Verse.org/Simulation }
    # Data type used for conversations.
    conversation_database<epic_internal><native> := class<epic_internal><computes><concrete>(asset) {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  # Resolves `SocketName` against `Mesh` and returns a `presentation_origin`
  # that follows that bone/socket.
  FindPresentationOrigin<epic_internal><native>(
    Mesh: mesh_component,
    SocketName: string
  )<decides><reads>: presentation_origin

  GetPhysicsSceneForEntity<epic_internal><native>(Entity: entity)<transacts><decides>: physics_scene_component

  @available { MinUploadedAtFNVersion := 4000 }
  # Helper function to aide in initializing the Entity pointer for components
  # during component field construction inside a verse class
  GetSelfEntityForComponentInitialization<epic_internal><native>()<converges>: entity

  @available { MinUploadedAtFNVersion := 4110 }
  GlobalModifierPosition<public>: rational = external {}

  @available { MinUploadedAtFNVersion := 4100 }
  # Module import path: /Verse.org/SceneGraph/HasCollisionInvalids
  HasCollisionInvalids<epic_internal> := module {
    InvalidCollisionMaterial<epic_internal>: collision_material = external {}
  }

  # Module import path: /Verse.org/SceneGraph/KeyframedMovement
  # Animate Scene Graph entities with keyframes.
  KeyframedMovement<public> := module {
    # Cubic bezier easing function. See CubicBezierEasingFunctions for some
    # basic easing values.
    cubic_bezier_easing_function<public><native> := class<epic_internal><concrete><computes>(easing_function) {
      Evaluate<native><override>(Input: float): float

      X0<public><native>: float = external {}

      X1<public><native>: float = external {}

      Y0<public><native>: float = external {}

      Y1<public><native>: float = external {}
    }

    @replicatable
    # Cubic Bezier function sent to clients to reconstruct the animation curves.
    cubic_bezier_easing_function_native<epic_internal><native> := struct<concrete> {
      X0<public><native>: float = external {}

      X1<public><native>: float = external {}

      Y0<public><native>: float = external {}

      Y1<public><native>: float = external {}
    }

    # `Ease` animations start slowly, speed up, then end slowly. The speed of
    # the animation is slightly slower at the end than the start.
    ease_cubic_bezier_easing_function<public><native> := class<final><concrete><computes>(
      cubic_bezier_easing_function
    ) {
      X0<override>: float = external {}

      X1<override>: float = external {}

      Y0<override>: float = external {}

      Y1<override>: float = external {}
    }

    # `EaseIn` animations start slow, then speed up towards the end.
    ease_in_cubic_bezier_easing_function<public><native> := class<final><concrete><computes>(
      cubic_bezier_easing_function
    ) {
      X0<override>: float = external {}

      X1<override>: float = external {}

      Y0<override>: float = external {}

      Y1<override>: float = external {}
    }

    # `EaseInOut` animations are similar to `Ease` but the start and end
    # animation speed is symmetric.
    ease_in_out_cubic_bezier_easing_function<public><native> := class<final><concrete><computes>(
      cubic_bezier_easing_function
    ) {
      X0<override>: float = external {}

      X1<override>: float = external {}

      Y0<override>: float = external {}

      Y1<override>: float = external {}
    }

    # `EaseOut` animations start fast, then slow down towards the end.
    ease_out_cubic_bezier_easing_function<public><native> := class<final><concrete><computes>(
      cubic_bezier_easing_function
    ) {
      X0<override>: float = external {}

      X1<override>: float = external {}

      Y0<override>: float = external {}

      Y1<override>: float = external {}
    }

    using { /Verse.org/Simulation }
    using { /Verse.org/SpatialMath }
    using { /Verse.org/Temporary/EpicGamesRestricted/Network }
    # Base class for an animation easing function.
    easing_function<public><native> := class<epic_internal><abstract><computes> {
      Evaluate<public><native>(Input: float): float
    }

    @replicatable
    # Contains all the information needed for the client to reconstruct the
    # entire animation command.
    keyframed_movement_command_data<epic_internal><native> := struct<concrete> {
      BlendOutDuration<native>: float = external {}

      Command<native>: keyframed_movement_net_command = external {}

      CommandServerTime<native>: float = external {}

      HaltTransform<native>: (/Verse.org/SpatialMath:)transform = external {}

      Keyframes<native>: []keyframed_movement_delta_native = external {}

      PlaybackMode<native>: keyframed_movement_playback_mode_native = external {}

      ServerStartTimeForBlendOut<native>: ?float = external {}

      StartTimeForPlay<native>: float = external {}
    }

    # Provides teleportation and simple keyframe-based animation for an entity.
    # Animations play back in the Pre-Physics tick phase. When animating an
    # entity with a parent_constraint, animation will be relative to the
    # parent entity.
    keyframed_movement_component<public><native> := class<final><final_super>(component) {
      # Get the event that fires when the animations ends, failing if the
      # animation is of infinite duration
      FinishedEvent<public><native>: listenable(tuple()) = external {}

      # Is there a valid set of playable keyframes?
      HasValidAnimation<public><native>()<decides><reads>: void

      # Is the animation paused?
      IsPaused<public><native>()<decides><reads>: void

      # Is the animation currently playing?
      IsPlaying<public><native>()<decides><reads>: void

      # Signaled when any keyframe is reached. (Keyframe:int, IsReversed:logic).
      KeyframeReachedEvent<public><native>: listenable(tuple(int, logic)) = external {}

      OnEndSimulationInternal<native><override>(): void

      OnInitializedInternal<native><override>(): void

      OnRep__PendingCommand<epic_internal><native>(): void

      # Pause movement. Subsequently calling Play() will resume from the point
      # in the animation when it was paused.
      Pause<public><native>(): void

      # Get the event that fires when the animation is Paused.
      PausedEvent<public><native>: listenable(tuple()) = external {}

      # Begin or resume playback.
      Play<public><native>(): void

      # Get the event that fires when the animation begins or resumes Playing.
      PlayedEvent<public><native>: listenable(tuple()) = external {}

      # Stop any ongoing animation, sets the animation path and rebases it
      # relative to the actor's current transform. Does not start playing until
      # you call Play().
      SetKeyframes<public><native>(
        RelativeKeyframes: []keyframed_movement_delta,
        PlaybackMode: keyframed_movement_playback_mode
      ): void

      # Stop and reset transform to the initial state. Subsequently calling
      # Play() will begin the animation anew.
      Stop<public><native>(BlendOutTime: float): void

      # Stop and reset transform to the initial state. Subsequently calling
      # Play() will begin the animation anew.
      Stop<public>(): void = external {}

      # Get the event that fires when the animation is Stopped.
      StoppedEvent<public><native>: listenable(tuple()) = external {}

      @replicated("RepNotify")
      var _PendingCommand<epic_internal><native>: keyframed_movement_command_data = external {}

      # Gets the duration in seconds this keyframed movement will take. Fails if
      # a fixed duration is not known (ex: looping animations).
      var<private> Duration<public><native>: ?float = external {}
    }

    # Represents a change in pose and scale over a duration.
    keyframed_movement_delta<public><native> := class<final><concrete> {
      @editable_number(float) { MinValue := option { 0.000000 } }
      # Duration of this keyframe in seconds.
      Duration<public><native>: float = external {}

      @editable
      # Easing function to use for playback.
      (/Verse.org/SceneGraph/KeyframedMovement/keyframed_movement_delta:)Easing<public><native>: easing_function = external {}

      @editable
      # Represents a change in the transform relative to the previous keyframe
      # or initial animation position. Translation and Scale are
      # interpreted additively.
      Transform<public><native>: (/Verse.org/SpatialMath:)transform = external {}
    }

    @replicatable
    # Keyframe delta sent to clients to reconstruct the animation frames.
    keyframed_movement_delta_native<epic_internal><native> := struct<concrete> {
      Duration<public><native>: float = external {}

      (/Verse.org/SceneGraph/KeyframedMovement/keyframed_movement_delta_native:)Easing<public><native>: cubic_bezier_easing_function_native = external {}

      Transform<public><native>: (/Verse.org/SpatialMath:)transform = external {}
    }

    # Play Command sent to clients to reconstruct the playback command
    keyframed_movement_net_command<epic_internal><native> := enum {
      HaltAt

      PlayFrom
    }

    # Controls how the animation plays back.
    keyframed_movement_playback_mode<public><native> := class<epic_internal><abstract><computes> {}

    # Control how the animation plays back.
    keyframed_movement_playback_mode_native<epic_internal><native> := enum {
      Loop

      OneShot

      PingPong
    }

    # `Linear` animations move at a constant speed.
    linear_easing_function<public><native> := class<final><concrete><computes>(cubic_bezier_easing_function) {
      X0<override>: float = external {}

      X1<override>: float = external {}

      Y0<override>: float = external {}

      Y1<override>: float = external {}
    }

    # Play once and repeat indefinitely.
    loop_keyframed_movement_playback_mode<public><native> := class<final><concrete><computes>(
      keyframed_movement_playback_mode
    ) {}

    # Play once and stop.
    oneshot_keyframed_movement_playback_mode<public><native> := class<final><concrete><computes>(
      keyframed_movement_playback_mode
    ) {}

    # Play continuously reversing direction at each end.
    pingpong_keyframed_movement_playback_mode<public><native> := class<final><concrete><computes>(
      keyframed_movement_playback_mode
    ) {}
  }

  MakeCollisionMaterial<epic_internal><native>(
    StaticFriction: float,
    DynamicFriction: float,
    Restitution: float
  )<converges>: collision_material

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  MakeSkeletonModifierStack<epic_internal><native>()<converges>: modifier_stack(skeleton)

  RouteUAFSharedVariableSet<epic_internal><native>(
    Component: has_uaf_shared_variables,
    Asset: animation_asset,
    PropertyName: string,
    NewValue: any
  )<transacts>: void

  using { /Verse.org/SceneGraph }
  # Verse path: /Verse.org/SceneGraph
  @available { MinUploadedAtFNVersion := 3800 }
  # Module import path: /Verse.org/SceneGraph/UI
  (/Verse.org/SceneGraph:)UI<public> := module {
    @available { MinUploadedAtFNVersion := 4210 }
    (Margin: ui_margin).GetMemberValue<epic_internal>(MemberName: []char)<transacts>: float = external {}

    @available { MinUploadedAtFNVersion := 4210 }
    (Margin: ui_margin).WithMemberValue<epic_internal>(
      MemberName: []char,
      Value: float
    )<transacts>: ui_margin = external {}

    DefaultTextValue<epic_internal><localizes>: message = external {}

    using { /UnrealEngine.com/Temporary/UI }
    using { /Verse.org/Assets }
    using { /Verse.org/Colors }
    using { /Verse.org/Native }
    using { /Verse.org/Simulation }
    using { /Verse.org/SpatialMath }
    using { /Verse.org/Temporary/EpicGamesRestricted/Network }
    @available { MinUploadedAtFNVersion := 4210 }
    # Layout hints for a child placed inside an absolute_container. Positions
    # the child relative to the container's rendered size, independent of its
    # flow siblings.
    absolute_container_element_component<epic_internal><native> := class(container_element_component) {
      # How this item is aligned along the horizontal axis within its containing
      # block, after offsets are applied. Center and End require a finite
      # container width; otherwise the item falls back to Start.
      var HorizontalAlignment<public>: ui_alignment = external {}

      # Inset from each edge of this item's containing block, in centimeters,
      # applied before alignment.
      var Offsets<public>: ui_margin = external {}

      # How this item is aligned along the vertical axis within its containing
      # block, after offsets are applied. Center and End require a finite
      # container height; otherwise the item falls back to Start.
      var VerticalAlignment<public>: ui_alignment = external {}
    }

    @available { MinUploadedAtFNVersion := 4210 }
    # Sizes to its content along its axis, clamped to [MinSize, MaxSize]. Use
    # proportional_grid_track to fill leftover container space.
    auto_grid_track<epic_internal><native> := class<final>(grid_track_definition) {
      @editable
      @replicated("")
      @tool_tip("Maximum resolved size, in centimeters. Inf = unbounded. Floored by MinSize.")
      var MaxSize<public><native>: float = external {}

      @editable
      @replicated("")
      @tool_tip("Minimum resolved size, in centimeters.")
      var MinSize<public><native>: float = external {}
    }

    @available { MinUploadedAtFNVersion := 4210 }
    @hide_in_editor
    container_element_component<epic_internal><native> := class<final_super>(component) {}

    @available { MinUploadedAtFNVersion := 4000 }
    drop_shadow_text_effect<epic_internal><native> := class(text_effect) {
      @editable
      @replicated("")
      # The color of the drop shadow.
      Color<public><native>: color = external {}

      @editable
      @replicated("")
      # The size and direction of the drop shadow to draw.
      Offset<public><native>: (/Verse.org/SpatialMath:)vector3 = external {}

      @editable
      @replicated("")
      # How the outline will apply to the text's drop shadow.
      Outline<public><native>: drop_shadow_text_outline = external {}
    }

    @available { MinUploadedAtFNVersion := 4000 }
    # How outlines are applied to drop shadows.
    drop_shadow_text_outline<epic_internal><native> := enum {
      # The outline will not be applied to the drop shadow.
      NoDropShadowOutline

      # The outline will be applied to the drop shadow.
      OutlineDropShadow
    }

    @available { MinUploadedAtFNVersion := 4210 }
    # A row or column track that has a fixed size, in centimeters.
    fixed_grid_track<epic_internal><native> := class<final>(grid_track_definition) {
      @editable
      @replicated("")
      @tool_tip("Fixed size of this track, in centimeters.")
      var Size<public><native>: float = external {}
    }

    @available { MinUploadedAtFNVersion := 4210 }
    # Container widget that arranges its children in a one-dimensional flowing
    # layout with optional wrapping.
    flex_container<epic_internal><native> := class((/Verse.org/SceneGraph/UI:)widget) {
      # Spacing between columns, in centimeters.
      var ColumnGap<public>: float = external {}

      # Alignment of lines along the cross axis.
      var ContentAlignment<public>: flex_content_alignment = external {}

      # Direction children flow along the main axis. Reversed directions
      # (RowReverse, ColumnReverse) require a finite main-axis MaxSize; Inf
      # silently disables reversal.
      var FlexDirection<public>: flex_direction = external {}

      # Alignment of items along the main axis within each line.
      var LineAlignment<public>: flex_content_alignment = external {}

      # Spacing between rows, in centimeters.
      var RowGap<public>: float = external {}

      # How children wrap onto multiple lines.
      var WrapDirection<public>: flex_wrap = external {}
    }

    @available { MinUploadedAtFNVersion := 4210 }
    # Layout hints for a child placed inside a flex_container.
    flex_container_element_component<epic_internal><native> := class(container_element_component) {
      # How this item is aligned along the cross axis (perpendicular to
      # FlexDirection) within its line.
      var AlignSelf<public>: ui_alignment = external {}

      # Alignment of this item along the main axis within an over-sized slot.
      var AlignSelfMajorAxis<public>: ui_alignment = external {}

      # Grow proportion along the main axis. If not set, the item does not grow.
      # Negative values clamp to 0.
      var GrowProportion<public>: ?float = external {}

      # Margin applied around this element within its line, in centimeters.
      var Margin<public>: ui_margin = external {}

      # Shrink proportion along the main axis. Set to false to disable
      # shrinking. Negative values clamp to 0.
      var ShrinkProportion<public>: ?float = external {}
    }

    @available { MinUploadedAtFNVersion := 4210 }
    # Alignment / distribution of content along an axis within a flex_container.
    flex_content_alignment<epic_internal><native> := enum {
      Center

      End

      Fill

      SpaceAround

      SpaceBetween

      SpaceEvenly

      Start
    }

    @available { MinUploadedAtFNVersion := 4210 }
    # Direction children flow along the main axis of a flex_container.
    flex_direction<epic_internal><native> := enum {
      Column

      ColumnReverse

      Row

      RowReverse
    }

    @available { MinUploadedAtFNVersion := 4210 }
    # Whether and how a flex_container wraps its children onto multiple lines.
    flex_wrap<epic_internal><native> := enum {
      NoWrap

      Wrap

      WrapReverse
    }

    @available { MinUploadedAtFNVersion := 4210 }
    # Container widget that arranges its children in a 2D row/column layout.
    grid_container<epic_internal><native> := class((/Verse.org/SceneGraph/UI:)widget) {
      # Add a column track definition to the grid. No-op if the same definition
      # is already present.
      AddColumnDefinition<public><native>(Definition: grid_track_definition)<transacts>: void

      # Add a row track definition to the grid. No-op if the same definition is
      # already present.
      AddRowDefinition<public><native>(Definition: grid_track_definition)<transacts>: void

      # Return the current ordered list of column track definitions.
      GetColumnDefinitions<public><native>()<reads>: []grid_track_definition

      # Return the current ordered list of row track definitions.
      GetRowDefinitions<public><native>()<reads>: []grid_track_definition

      # Remove a previously added column track definition from the grid.
      RemoveColumnDefinition<public><native>(Definition: grid_track_definition)<transacts>: void

      # Remove a previously added row track definition from the grid.
      RemoveRowDefinition<public><native>(Definition: grid_track_definition)<transacts>: void

      # Spacing between columns, in centimeters.
      var ColumnGap<public>: float = external {}

      # Spacing between rows, in centimeters.
      var RowGap<public>: float = external {}
    }

    @available { MinUploadedAtFNVersion := 4210 }
    # Layout hints for a child placed inside a grid_container.
    grid_container_element_component<epic_internal><native> := class(container_element_component) {
      # Column index of this item's anchor cell. Zero-based from the start;
      # negative values count from the end (-1 = last column). Out-of-range
      # values are clamped to the nearest valid column.
      var Column<public>: int = external {}

      # Number of columns this item spans across, starting at Column.
      var ColumnSpan<public>: int = external {}

      var HorizontalAlignment<public>: ui_alignment = external {}

      var Margin<public>: ui_margin = external {}

      # Row index of this item's anchor cell. Zero-based from the start;
      # negative values count from the end (-1 = last row). Out-of-range values
      # are clamped to the nearest valid row.
      var Row<public>: int = external {}

      # Number of rows this item spans across, starting at Row.
      var RowSpan<public>: int = external {}

      var VerticalAlignment<public>: ui_alignment = external {}
    }

    @available { MinUploadedAtFNVersion := 4210 }
    # Abstract base class for a single row or column track inside
    # a grid_container.
    grid_track_definition<epic_internal><native> := class<internal><abstract><unique> {}

    # How text should be aligned within the `text_widget`.
    horizontal_text_alignment<epic_internal><native> := enum {
      # Align the text in the center.
      Center

      # Align the text logically to the left of the frame ignoring the
      # current culture.
      InvariantLeft

      # Align the text logically to the right of the frame ignoring the
      # current culture.
      InvariantRight

      # Align the text logically to the left of the frame based on
      # current culture.
      Left

      # Align the text logically to the right of the frame based on
      # current culture.
      Right
    }

    @available { MinUploadedAtFNVersion := 4000 }
    @experimental
    # UI element that renders an image
    image_widget<epic_internal><native> := class((/Verse.org/SceneGraph/UI:)widget) {
      # The material used to render the image.
      var Material<public>: material_like = external {}
    }

    @available { MinUploadedAtFNVersion := 4000 }
    letter_spacing_text_effect<epic_internal><native> := class(text_effect) {
      @editable
      @replicated("")
      # The uniform spacing (or tracking) to apply between all characters in
      # the text.
      Amount<public><native>: float = external {}
    }

    @replicatable
    @import_as("/Script/LocalizableMessage.FLocalizableMessage")
    localizable_message_internal<epic_internal><native> := struct<concrete> {}

    @available { MinUploadedAtFNVersion := 4000 }
    material_text_effect<epic_internal><native> := class(text_effect) {
      @editable
      @replicated("")
      # A material to apply to the text
      Material<public><native>: material
    }

    @available { MinUploadedAtFNVersion := 4000 }
    # Text outline corner styles.
    outline_text_corners<epic_internal><native> := enum {
      # The outline will have sharp corners.
      Mitered

      # The outline will have rounded corners.
      Rounded
    }

    @available { MinUploadedAtFNVersion := 4000 }
    outline_text_effect<epic_internal><native> := class(text_effect) {
      @editable
      @replicated("")
      # The color of the outline.
      Color<public><native>: color = external {}

      @editable
      @replicated("")
      # How the corners of the outline should be styled.
      CornerStyle<public><native>: outline_text_corners = external {}

      @editable
      @replicated("")
      # The width of the outline to apply to the text.
      Size<public><native>: float = external {}
    }

    @available { MinUploadedAtFNVersion := 4210 }
    # Takes a weighted share of the container's leftover space. Clamped to
    # [MinSize, MaxSize].
    proportional_grid_track<epic_internal><native> := class<final>(grid_track_definition) {
      @editable
      @replicated("")
      @tool_tip("Maximum resolved size, in centimeters. Inf = unbounded. Floored by MinSize.")
      var MaxSize<public><native>: float = external {}

      @editable
      @replicated("")
      @tool_tip("Minimum resolved size, in centimeters.")
      var MinSize<public><native>: float = external {}

      # Weight when dividing leftover space. Weight 2 gets twice the share of
      # weight 1. Clamped to >= 0.
      var Proportion<public>: float = external {}
    }

    @available { MinUploadedAtFNVersion := 4000 }
    skew_text_effect<epic_internal><native> := class(text_effect) {
      @editable
      @replicated("")
      # How much to skew the text by
      Amount<public><native>: float = external {}
    }

    @available { MinUploadedAtFNVersion := 4000 }
    text_effect<epic_internal><native> := class<epic_internal><abstract> {}

    # The policy that determines what happens when the text is larger than
    # the `text_widget`.
    text_frame_overflow_policy<epic_internal><native> := enum {
      # Overflowing text will be clipped.
      Clip

      # Overflowing text will be replaced with an ellipsis.
      Ellipsis
    }

    @available { MinUploadedAtFNVersion := 4000 }
    text_style<epic_internal><native> := class {
      @editable
      @replicated("")
      # The color of the displayed text.
      Color<public><native>: color_alpha = external {}

      @editable
      @replicated("")
      # Text effects to apply with this style
      Effects<public><native>: []text_effect = external {}

      @editable
      @replicated("")
      # The size of the displayed text.
      Size<public><native>: float = external {}
    }

    @available { MinUploadedAtFNVersion := 4000 }
    # UI element that renders text.
    text_widget<epic_internal><native> := class((/Verse.org/SceneGraph/UI:)widget) {
      # How the text should be horizontally aligned within the text frame.
      var HorizontalAlignment<public>: horizontal_text_alignment = external {}

      # The policy that determines what happens when the text is larger than
      # the frame.
      var OverflowPolicy<public>: text_frame_overflow_policy = external {}

      # The style to apply to the rendered text.
      var Style<public>: text_style = external {}

      # The text to render.
      var Text<public>: message = external {}

      # How the text should be vertically aligned within the text frame.
      var VerticalAlignment<public>: vertical_text_alignment = external {}
    }

    @available { MinUploadedAtFNVersion := 4210 }
    ui_alignment<epic_internal><native> := enum {
      Center

      End

      Fill

      Start
    }

    @available { MinUploadedAtFNVersion := 4210 }
    @replicatable
    ui_margin<epic_internal><native> := struct<concrete><computes> {
      @editable
      Bottom<native>: float = external {}

      @editable
      Left<native>: float = external {}

      @editable
      Right<native>: float = external {}

      @editable
      Top<native>: float = external {}
    }

    @available { MinUploadedAtFNVersion := 4000 }
    @cpp_name("umg_widget_entity")
    @hide_in_editor
    (/Verse.org/SceneGraph/UI:)umg_widget<epic_internal><native> := class((/Verse.org/SceneGraph/UI:)widget) {
      @replicated("")
      Asset<epic_internal><native>: umg_widget_class_asset = external {}

      CreateLocalizableMessage<protected><native>(Message: message)<transacts>: localizable_message_internal

      CreateMessage<protected><native>(LocalizableMessage: localizable_message_internal)<transacts>: message

      GetWidgetField<epic_internal><native>(
        Widget: castable_subtype((/Verse.org/SceneGraph/UI:)widget),
        WidgetName: string
      )<transacts>: entity

      OnPropertyChanged<protected><native>(PropertyName: string)<transacts>: void
    }

    @available { MinUploadedAtFNVersion := 4000 }
    @hide_in_editor
    umg_widget_component<epic_internal><native> := class<final_super>(component) {}

    # Alignment mode for `text_widget`.
    vertical_text_alignment<epic_internal><native> := enum {
      # Align the rendered text to the bottom of the frame.
      Bottom

      # Center the rendered text vertically within the frame.
      Center

      # Align the rendered text to the top of the frame.
      Top
    }

    @available { MinUploadedAtFNVersion := 4000 }
    @cpp_name("widget_entity")
    (/Verse.org/SceneGraph/UI:)widget<epic_internal><native> := class(entity) {}
  }

  @replicatable
  VerseRepMovement<epic_internal><native> := struct {
    Acceleration<native>: (/Verse.org/SpatialMath:)vector3 = external {}

    AngularVelocity<native>: (/Verse.org/SpatialMath:)vector3 = external {}

    LinearVelocity<native>: (/Verse.org/SpatialMath:)vector3 = external {}

    Location<native>: (/Verse.org/SpatialMath:)vector3 = external {}

    LocationQuantizationLevel<native>: vector_quantization = external {}

    Rotation<native>: (/Verse.org/SpatialMath:)rotation = external {}

    RotationQuantizationLevel<native>: rotator_quantization = external {}

    ServerFrame<native>: int = external {}

    ServerPhysicsHandle<native>: int = external {}

    TeleportSeq<native>: int = external {}

    VelocityQuantizationLevel<native>: vector_quantization = external {}

    bRepAcceleration<native>: logic = external {}

    bRepPhysics<native>: logic = external {}

    bSimulatedPhysicSleep<native>: logic = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  VisualModifierPosition<public>: rational = external {}

  @replicatable
  @import_as("/Script/Entity.FActorOriginData")
  actor_data<epic_internal><native> := struct<concrete> {}

  @hide_in_editor
  # class to provide alternative origin to the 'transform_component' as an
  # actor. This class should never be public and is intended for internal
  # use only.
  actor_origin<epic_internal><native> := class(origin) {
    @editable
    @replicated("RepNotify")
    ActorData<epic_internal><native>: actor_data

    GetTransform<native><override>()<transacts>: (/Verse.org/SpatialMath:)transform
  }

  # Payload of the AgentChangeEvent. Contains the previous and the current
  # possessing agent.
  agent_changed_result<epic_internal><native> := struct {
    CurrentAgent<native>: ?agent = external {}

    PreviousAgent<native>: ?agent = external {}
  }

  using { /Verse.org/Native }
  using { /Verse.org/Simulation }
  using { /Verse.org/Temporary/EpicGamesRestricted/Network }
  # Verse path: /Verse.org/SceneGraph
  # An interactable component with a composable feature set.
  basic_interactable_component<public><native> := class(interactable_component) {
    # Attempt to cancel an interaction. Fails if the supplied agent is not
    # currently interacting with the component.
    Cancel<public><native>(Agent: agent)<transacts><decides>: void

    @editable
    @replicated("")
    # Cooldowns begin elapsing on successful interactions. A cooldown which
    # applies for all attempts to interact on this component.
    Cooldown<public><native>: ?interactable_cooldown = external {}

    @editable
    @replicated("")
    # Cooldowns begin elapsing on successful interactions. A cooldown which
    # applies for future attempts to interact on this component by the agent
    # which succeeded.
    CooldownPerAgent<public><native>: ?interactable_cooldown_per_agent = external {}

    # Get the remaining cooldown of the interactable for the supplied agent.
    # This returns the duration left in seconds of either the shared or per
    # agent cooldown, whichever is greater. Returns the same value when called
    # multiple times within a transaction.
    GetRemainingCooldownDurationAffectingAgent<public><native>(Agent: agent): float

    @available { MinUploadedAtFNVersion := 4020 }
    InteractMessage<override>(Agent: agent)<decides><reads>: message = external {}

    @editable
    @replicated("")
    # An interaction with a duration does not succeed until the duration has
    # elapsed, and success is not guaranteed as it can be canceled while the
    # duration is active.
    InteractableDuration<public><native>: ?interactable_duration = external {}

    OnInitializedInternal<native><override>(): void

    # Attempt to succeed at an interaction. Success will also happen
    # automatically after InteractDuration has elapsed after starting an
    # interaction. Fails if the supplied agent is not currently interacting with
    # the component.
    Succeed<public><native>(Agent: agent)<transacts><decides>: void

    @editable
    @replicated("")
    # Success limits prevent new interactions once the component has been
    # successfully interacted with a specified number of times.
    SuccessLimit<public><native>: ?interactable_success_limit = external {}

    @available { MinUploadedAtFNVersion := 4020 }
    @editable
    # Message shown if CanInteract succeeds.
    var CanInteractMessage<public>: message = external {}

    @available { MinUploadedAtFNVersion := 4020 }
    @editable
    # Message shown if CanInteract fails.
    var CannotInteractMessage<public>: message = external {}

    # The agents which are currently interacting with this interactable.
    var<private> InteractingAgents<public><native>: []agent = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  basic_stackable_component<public><native> := class(stackable_component) {
    # Succeeds if this entity can be merged into the target entity. Merging an
    # entity with itself will always fail.
    CanMergeInto<override>(TargetEntity: entity)<decides><reads>: void = external {}

    Split<override>(Amount: int)<transacts><decides>: entity = external {}

    @editable
    # The prefab used when this entity merges with another or when it is split
    # into a new instance.
    split_prefab_type<public><native>: castable_concrete_subtype(entity) = external {}
  }

  # Implemented by classes whose instances can provide a bounds.
  bounded<epic_internal><native> := interface {
    # Returns the associated bounded box for this object, in world space.
    GetBoundedGlobalBox<epic_internal><native_callable>()<transacts>: bounded_box

    # Returns the associated bounded box for this object, in local space.
    GetBoundedLocalBox<epic_internal><native_callable>()<transacts>: bounded_box
  }

  using { /Verse.org/Simulation/Tags }
  @import_as("/*.FBoundedBox")
  # 3-dimensional box.
  bounded_box<epic_internal><native> := struct<concrete> {
    BoxMax<native>: (/Verse.org/SpatialMath:)vector3 = external {}

    BoxMin<native>: (/Verse.org/SpatialMath:)vector3 = external {}

    Valid<native>: logic = external {}
  }

  using { /Verse.org/Assets }
  # Verse path: /Verse.org/SceneGraph
  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Camera body settings, e.g. sensor/film settings, shutter speed, etc
  camera_body<public><native> := class<final><computes> {
    @replicated("")
    # The camera sensor sensitivity to light.
    ISO<public><native>: float = external {}

    @replicated("")
    # Height of camera sensor in millimeters.
    SensorHeightMillimeters<public><native>: float = external {}

    @replicated("")
    # Horizontal offset of camera sensor.
    SensorHorizontalOffsetMillimeters<public><native>: float = external {}

    @replicated("")
    # Vertical offset of camera sensor.
    SensorVerticalOffsetMillimeters<public><native>: float = external {}

    @replicated("")
    # Width of camera sensor in millimeters.
    SensorWidthMillimeters<public><native>: float = external {}

    @replicated("")
    # Camera shutter speed.
    ShutterSpeed<public><native>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Represents the physical body, lens of the camera and other cinematographic
  # qualities, such as sensor size, aspect ratio lock/constraint, focal length,
  # focus distance, post-process settings, etc.
  camera_component<public><native> := class<final_super><abstract>(component, has_camera_modifier) {
    AddCameraModifier<epic_internal><native_callable>(
      Modifier: camera_modifier,
      Priority: rational
    ): cancelable = external {}

    @experimental
    # Get transition to use when entering this camera mode to transition to the
    # specified camera mode
    GetEnterTransition<public><native_callable>(
      SourceCamera: camera_component
    )<transacts><decides>: camera_transition = external {}

    @experimental
    GetEnterTransition_Internal<epic_internal><native_callable>(
      SourceCamera: camera_component
    )<transacts><decides>: camera_transition = external {}

    @experimental
    # Get transition to use when exiting this camera mode to transition to the
    # destination camera mode
    GetExitTransition<public><native_callable>(
      DestinationCamera: camera_component
    )<transacts><decides>: camera_transition = external {}

    @editable
    @replicated("")
    @experimental
    # Optionally override the far clipping plane distance. If value is Inf then
    # use the default settings
    var FarClippingPlaneDistance<public><native>: float = external {}

    @editable
    @replicated("")
    @experimental
    # Optionally override the near clipping plane distance. If value is <= 0.0
    # then use the default settings
    var NearClippingPlaneDistance<public><native>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  @hide_in_editor
  camera_component_impl_modifier<epic_internal><native> := class(camera_modifier) {
    Evaluate<override>(InValue: camera_state)<reads>: camera_state = external {}

    NativeEvaluate<epic_internal><native>(InValue: camera_state)<reads>: camera_state
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  camera_director_camera_entry<epic_internal><native> := class<epic_internal>(cancelable) {
    @experimental
    @replicated("")
    CameraComponent<public><native>: camera_component

    Cancel<native><override>()<transacts>: void

    @experimental
    @replicated("")
    DirectorComponent<public><native>: camera_director_component

    @experimental
    @replicated("")
    Priority<public><native>: rational

    @experimental
    @replicated("")
    var Transition<public><native>: camera_transition = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Responsible for selecting a camera and blending when the active
  # camera changes.
  # Also allows global settings to be shared between different cameras (such as
  # post process settings) and modifications to the final blended camera state,
  # such as camera shakes
  camera_director_component<public><native> := class<final_super>(camera_component) {
    # Add a camera to the director. The camera with the highest priority will be
    # chosen to be the active camera
    AddCamera<public><native>(Camera: camera_component, Priority: rational)<transacts><decides>: cancelable

    # Returns the current camera transform if available.
    GetActiveCameraTransform<epic_internal><native>()<decides><reads>: (/Verse.org/SpatialMath:)transform

    @replicated("")
    @experimental
    @available { MinUploadedAtFNVersion := 4230 }
    var UseCameraLocationAsAudioListenerPosition<epic_internal><native>: logic = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Camera lens settings
  camera_lens<public><native> := class<final><computes> {
    @replicated("")
    # Number of blades of diaphragm.
    BladeCount<public><native>: int = external {}

    @replicated("")
    # Aperture of the lens in FStop.
    FStop<public><native>: float = external {}

    @replicated("")
    # Focal length of the lens in millimeters.
    FocalLengthMillimeters<public><native>: float = external {}

    @replicated("")
    # Focus distance in centimeters.
    FocusDistance<epic_internal><native>: ?float = external {}

    @replicated("")
    # Squeeze factor for anamorphic lenses.
    SqueezeFactor<public><native>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  @hide_in_editor
  # Configurable blend between two camera modes
  camera_mode_blend<public><native> := class<concrete> {}

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Linear blend between camera modes
  camera_mode_blend_linear<public><native> := class<concrete>(camera_mode_blend) {}

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Configurable blend between two camera modes
  camera_mode_blend_orbit<public><native> := class<concrete>(camera_mode_blend) {
    @replicated("")
    DrivingBlend<public><native>: camera_mode_blend = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Instantly snap to target mode
  camera_mode_blend_pop<public><native> := class<concrete>(camera_mode_blend) {}

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Camera mode blend that uses the smootherstep function to blend between the
  # two camera modes
  camera_mode_blend_smootherstep<public><native> := class<concrete>(camera_mode_blend) {}

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Camera mode blend that uses the smoothstep function to blend between the two
  # camera modes
  camera_mode_blend_smoothstep<public><native> := class<concrete>(camera_mode_blend) {}

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Base class for objects that can modify camera state.
  camera_modifier<public><native> := class(modifier(camera_state)) {
    Evaluate<override><native_callable>(InValue: camera_state)<reads>: camera_state = external {}

    @experimental
    NativeCameraRigAsset<epic_internal><native>: camera_rig_asset = external {}

    @experimental
    Tick<epic_internal><native_callable>(DeltaTime: float)<transacts>: void = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Modifier stack for camera state.
  camera_modifier_stack<public><native> := class(modifier_stack(camera_state)) {
    # Returns a camera_state which is the input evaluated against each modifier
    # in the stack, executed in position order.
    Evaluate<native><override>(InValue: camera_state)<reads>: camera_state
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  camera_projection_mode<public><native> := enum<open> {
    Orthographic

    Perspective
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  camera_state<public><native> := class<epic_internal><final><computes> {
    @experimental
    @replicated("")
    # Physical camera body settings
    Body<public><native>: camera_body = external {}

    @experimental
    @replicated("")
    FarClippingPlaneDistance<public><native>: float = external {}

    @experimental
    @replicated("")
    # Physical camera lens settings
    Lens<public><native>: camera_lens = external {}

    @experimental
    @replicated("")
    NearClippingPlaneDistance<public><native>: float = external {}

    @experimental
    @replicated("")
    # Determines how wide the camera projects in orthographic mode, in
    # centimeters - Used only if projection mode is orthographic
    OrthographicProjectionWidth<public><native>: float = external {}

    @experimental
    @replicated("")
    # How much to apply physical camera settings between 0.0 and 1.0
    PhysicalCameraWeight<public><native>: float = external {}

    @experimental
    @replicated("")
    # Projection mode - perspective or orthographic
    ProjectionMode<public><native>: camera_projection_mode = external {}

    @experimental
    @replicated("")
    # Render location of the camera. This render location can be modified by
    # camera directions (like camera shakes), without modifying the physical
    # location of any camera entity
    RenderLocation<public><native>: (/Verse.org/SpatialMath:)vector3

    @experimental
    @replicated("")
    # Render rotation of the camera. This render rotation can be modified by
    # camera directions (like camera shakes), without modifying the physical
    # location of any camera entity
    RenderRotation<public><native>: (/Verse.org/SpatialMath:)rotation
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Controls how a camera mode transitions to another
  camera_transition<public><native> := class<concrete> {
    @editable
    @replicated("")
    Blend<public><native>: camera_mode_blend = external {}

    @editable
    @replicated("")
    # Sets the duration of the camera transition
    Duration<public><native>: float = external {}

    @editable
    @replicated("")
    InitialTargetOrientation<epic_internal><native>: ?camera_transition_initial_orientation = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Controls how a camera mode transitions to another
  camera_transition_initial_orientation<public><native> := enum {
    PreviousAbsoluteTarget

    PreviousRelativeTarget

    PreviousYawPitch
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  cancelable_impl_internal<epic_internal> := class<epic_internal>(cancelable) {
    Cancel<override>()<transacts>: void = external {}

    Cancelable<epic_internal>: cancelable
  }

  using { /Verse.org/Colors }
  using { /Verse.org/Restricted }
  # A `capsule_light_component` emits light in all directions into the scene
  # from a capsule shaped source with a specified radius and length. A radius
  # and length of 0 makes it a point light. You can use these to simulate any
  # kind of light sources that emit in all directions and need an elongated
  # source shape, such as a long light bulb.
  capsule_light_component<public><native> := class<final>(light_component) {
    OnAddedToSceneInternal<native><override>(): void

    # The bounds of the light's visible influence. This clamping of the light's
    # influence is not physically correct but very important for performance,
    # larger lights cost more. The light falloff is based on Inverse Square law.
    # Towards the tail end of the AttenuationRadius, there is an additional
    # smoothing factor to fade out the light contribution to 0 to avoid a
    # hard cutoff.
    var AttenuationRadius<public>: ?float = external {}

    # Set the visible light intensity emitted in SI unit Candela.
    # Specified before ColorFilter (which multiplies each color component after
    # the intensity calculation and can change the effective intensity of
    # the light).
    var Intensity<public>: float = external {}

    # Length of the source capsule shape in centimeters along the local Z axis.
    # Note that light shapes which intersect shadow casting geometry can cause
    # shadowing artifacts.
    var SourceLength<public>: float = external {}

    # Radius of the source capsule shape in centimeters around the local Z axis.
    # Note that light shapes which intersect shadow casting geometry can cause
    # shadowing artifacts.
    var SourceRadius<public>: float = external {}
  }

  change_icon_component_event<epic_internal> := class(scene_event) {
    Entity<public>: entity

    IconComponent<public>: ?icon_component = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  change_max_stack_size_result<public><native> := class<epic_internal> {
    CurrentMaxStackSize<public><native>: ?int

    PreviousMaxStackSize<public><native>: ?int

    StackableComponent<public><native>: stackable_component
  }

  @available { MinUploadedAtFNVersion := 4000 }
  change_rarity_component_event<epic_internal> := class(scene_event) {
    Entity<public>: entity

    RarityComponent<public>: ?rarity_component = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  change_stack_size_result<public><native> := class<epic_internal> {
    CurrentStackSize<public><native>: int

    PreviousStackSize<public><native>: int

    StackableComponent<public><native>: stackable_component
  }

  @available { MinUploadedAtFNVersion := 4000 }
  change_stackable_component_event<epic_internal> := class(scene_event) {
    Entity<public>: entity

    StackableComponent<public>: ?stackable_component = external {}
  }

  # Child entities client streaming modes
  children_streaming_policy<public><native> := enum {
    # Child entities are loaded atomically with their parent.
    Atomic

    # Child entities are loaded independently from their parent.
    Discrete
  }

  # An axis-aligned collision box.
  collision_box<public><native> := class(collision_element) {
    var Extents<public>: (/Verse.org/SpatialMath:)vector3
  }

  # A collision capsule aligned along the Z axis.
  collision_capsule<public><native> := class(collision_element) {
    # The length of the capsule's cylindrical section (distance between the two
    # end cap centers)
    var Length<public>: float = external {}

    # The radius of the capsule
    var Radius<public>: float = external {}
  }

  # Every volume has a collision channel as part of its collision_profile. It is
  # used to determine how two volumes interact. See collision_profile.
  collision_channel<public><native> := class<epic_internal><concrete> {}

  # An alias for the function type used to map a collision_channel to a
  # collision_interaction used by  collision_profile.
  collision_channel_to_interaction<public> := type { _(: collision_channel)<computes>: collision_interaction }

  # Base class for collision_volumes that consist of a single volume with a
  # single collision_profile and collision_material for the whole volume. This
  # covers most volume types used in queries and physics, except compound types
  # like a mesh. A query will always return an element rather than a general
  # volume. For example when colliding with a mesh, the element will be a
  # collision_triangle, which is a collision_element and has a single material,
  # rather than a collision_triangle_mesh, which is not an element and has a
  # material palette.
  collision_element<public><native> := class<abstract>(collision_volume) {
    # The collision_profile for this volume.
    var CollisionProfile<public>: collision_profile = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  collision_hit<epic_internal><native> := struct<epic_internal> {
    CollisionVolumes<public><native>: collision_volume_pair

    ContactPoints<public><native>: []contact_point
  }

  # Specifies how a collision volume pair should interact.
  # See collision_profile.
  collision_interaction<public><native> := enum {
    # The pair will be detected by Overlap and Sweep queries. The pair will
    # collide in the physics simulation.
    Block

    # The pair will not be detected by Overlap and Sweep queries. The pair will
    # not collide in the physics simulation.
    Ignore

    # The pair will be detected by Overlap and Sweep queries. The pair will not
    # collide in the physics simulation.
    Overlap
  }

  @replicatable
  collision_material<epic_internal><native> := struct<epic_internal> {
    # Friction coefficient for sliding contacts
    DynamicFriction<native>: float = external {}

    # Bounciness of the object
    Restitution<native>: float = external {}

    # Friction coefficient for stationary contacts
    StaticFriction<native>: float = external {}
  }

  # A collision point.
  collision_point<public><native> := class<concrete>(collision_element) {}

  # A collision profile determines how a volume interacts with other volumes for
  # Overlap queries, Sweep queries, and physics simulation. When two volumes are
  # being tested to see how they interact, the algorithm looks like this:
  #    GetInteraction(A:collision_profile, B:collision_profile):collision_interaction =
  #        InteractionA = B.GetChannelInteraction(A.Channel)
  #        InteractionB = A.GetChannelInteraction(B.Channel)
  #        return Min(InteractionA, InteractionB)
  collision_profile<public><native> := class<concrete> {
    # The collision channel for the owning object.
    Channel<public><native>: collision_channel = external {}

    # How the owning object should interact with other
    # objects.GetChannelInteraction is a function which maps a collision_channel
    # to a collision_interaction. It can be implemented as an simple sequence of
    # if statements. For example, to block all channels except camera:
    #     BlockAllIgnoreCamera(Channel:collision_channel)<computes>:collision_interaction =
    #         if (CollisionChannels.camera[Channel]):
    #             return collision_interaction.Ignore
    #         return collision_interaction.Block
    #     MyProfile<public>:collision_profile = MakeCollisionProfile(CollisionChannels.dynamic, BlockAllIgnoreCamera)
    GetChannelInteraction<public><native>: collision_channel_to_interaction = external {}
  }

  # A collision sphere.
  collision_sphere<public><native> := class(collision_element) {
    # The radius of the sphere
    var Radius<public>: float = external {}
  }

  # Collision Volumes represent the collision shapes of meshes. They can be
  # detected by Overlap and Sweep queries and generate collisions in the
  # physics simulation.
  collision_volume<public><native> := class<abstract> {
    # Get the transform of this volume in the space of its owner (usually a
    # component on an entity)
    GetLocalTransform<public>()<transacts>: (/Verse.org/SpatialMath:)transform = external {}

    # Set the transform of this volume in the space of its owner (usually a
    # component on an entity)
    SetLocalTransform<public>(NewLocalTransform: (/Verse.org/SpatialMath:)transform)<transacts>: void = external {}

    # Enable/disable collision on this volume.
    var Collidable<public>: logic = external {}

    # Enable/disable spatial queries against this volume.
    var Queryable<public>: logic = external {}
  }

  collision_volume_internal<epic_internal><native> := class<epic_internal><concrete>(collision_element) {}

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  collision_volume_pair<epic_internal><native> := struct<epic_internal> {
    SourceComponent<public><native>: component

    SourceVolume<public><native>: collision_element

    TargetComponent<public><native>: component

    TargetVolume<public><native>: collision_element
  }

  @available { MinUploadedAtFNVersion := 4000 }
  common_rarity<public> := class<allocates>(rarity) {}

  # Base class for authoring logic and data in the SceneGraph. Using components
  # you can author re-usable building blocks of logic and data which can then be
  # added to entities in the scene.
  #
  # Components are a very low level building block which can be used in
  # many ways.
  # For example:
  #   * Exposing engine level concepts like mesh or sound
  #   * Adding gameplay capabilities like damage or interaction
  #   * Storing an inventory for a character in the game
  #
  # As components are generic there is no specific way that they must be used.
  # It is up to the needs of your experience if you use one big game component
  # or if you break up logic into many small components.
  #
  # Classes deriving from component must also specify `<final_super>` to be
  # added to entities. This ensures the class will always derive directly
  # from `component`.
  # Further subclassing of the initial derived component is allowed and does not
  # require specifying `<final_super>` on the derived classes.
  #
  # Only one instance of a component from each subclass group can be added to an
  # entity at a time. For example, given this group of components, only one
  # light_component can exist on a single entity. To create multiple lights you
  # should use multiple entities.
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
  #   to entities, added to the scene, and begin running in the simulation.
  #   Components should override these methods to perform setup and run
  #   their simulation.
  #
  #   As a component shuts down it will then move through shutdown version of
  #   these functions, giving users the opportunity to clean up any retained
  #   state on the component before it is disposed
  # .
  #   Lifetime Methods:
  #      OnAddedToScene
  #        OnBeginSimulation -> OnSimulate<suspends>
  #        OnEndSimulation
  #      OnRemovingFromScene
  # ==============================================================================
  component<public><native> := class<abstract><unique><castable><final_super_base>(diagnosable) {
    @allow_self_reference
    @experimental_always_overridden
    # The parent entity of this component.
    #   * Components must have a parent entity pointer provided when
    #     being constructed.
    #   * Components cannot be moved between parents.
    Entity<public><native>: entity

    GetDiagnostic<override><native>()<reads>: diagnostic

    # Succeeds if the component is currently in the scene.
    #   * After `OnAddedToScene` is called this call succeeds.
    #   * After `OnRemovingFromScene` is called this call fails.
    IsInScene<public><final><native>()<decides><reads>: void

    # Succeeds if the component is currently initialized with its parent entity.
    #   * After `OnInitialized` is called this call succeeds.
    #   * After `OnUninitializing` is called this call fails.
    IsInitialized<epic_internal><final><native>()<decides><reads>: void

    # Succeeds if the component is currently simulating.
    #   * After `OnBeginSimulation` is called this call succeeds.
    #   * After `OnEndSimulation` is called this call fails.
    IsSimulating<public><final><native>()<decides><reads>: void

    # Called when the component is added to the scene by parenting it under the
    # simulation entity or another entity already in the scene.
    #   * Querying for components in the scene is valid after this
    #     phase completes.
    OnAddedToScene<protected><native><native_callable>(): void

    OnAddedToSceneInternal<epic_internal><native><native_callable>(): void

    # Called when the component begins simulating within the scene.
    #   * Use this to set up TickEvent callbacks or other setup that must be
    #     guaranteed to complete immediately.
    #   * `OnAddedToScene` is guaranteed to run before `OnBeginSimulation`.
    OnBeginSimulation<protected><native><native_callable>(): void

    OnBeginSimulationInternal<epic_internal><native><native_callable>(): void

    # Called when the component ends simulation within the scene.
    #   * Simulation ends on a component when the experience resets, the parent
    #     entity is removed from the scene.
    #   * Cached TickEvents cancelables should be canceled in `OnEndSimulation`.
    #   * `OnSimulate` task will be canceled before `OnEndSimulation` is called.
    #   * `OnEndSimulation` is only called on components that have already had
    #     `OnBeginSimulation` called.
    OnEndSimulation<protected><native><native_callable>(): void

    OnEndSimulationInternal<epic_internal><native><native_callable>(): void

    # Called when the component is added to an entity
    # using `entity.AddComponents`.
    #   * Components can check for dependent sibling components at this stage
    #     through `entity.GetComponents`.
    #   * Components can add additional components at this stage
    #     using `entity.AddComponents`
    OnInitialized<epic_internal><native><native_callable>(): void

    OnInitializedInternal<epic_internal><native><native_callable>(): void

    @available { MinUploadedAtFNVersion := 4000 }
    # Respond to a scene event. Return true to consume the event and halt
    # propagation to the next entity.
    OnReceive<protected><native_callable>(SceneEvent: scene_event): logic = external {}

    # Called when the component is about to be removed from the scene.
    #   * Components are removed from a scene when the parent entity is removed
    #     from the scene.
    #   * `OnRemovingFromScene` is only called on components that have already
    #     had `OnAddedToScene` called.
    OnRemovingFromScene<protected><native><native_callable>(): void

    OnRemovingFromSceneInternal<epic_internal><native><native_callable>(): void

    # Called when the component begins simulating within the scene.
    #   * Use this to add asynchronous/suspends update logic for a component.
    #   * `OnBeginSimulation` is guaranteed to run before `OnSimulate`.
    #   * `OnSimulate` will be cancelled before `OnEndSimulation`
    OnSimulate<protected><native_callable>()<suspends>: void = external {}

    # Called when the component is about to be removed from the parent entity.
    #   * `OnUninitializing` is only called on components that have already had
    #     `OnInitialized` called.
    OnUninitializing<epic_internal><native><native_callable>(): void

    OnUninitializingInternal<epic_internal><native><native_callable>(): void

    # Removes the component from the entity.
    #   * Removed components are removed from the scene and can only be added
    #     back to the same entity.
    #   * Flows through `OnEndSimulation`-> `OnRemovingFromScene`.
    RemoveFromEntity<public><final><native>(): void

    # Send a scene event to this component, invoking OnReceive.  Returns true if
    # any participant consumed the event.
    SendDown<public><final><native><native_callable>(SceneEvent: scene_event): logic

    # Set callbacks to `TickEvents.PrePhysics` and `TickEvents.PostPhysics` to
    # receive per-frame updates before and after physics is updated on
    # your object.
    var<private> TickEvents<protected>: tick_events = external {}
  }

  component_query_iterator_interface<epic_internal><native> := interface<epic_internal> {
    NextValue<public><native_callable>()<transacts><decides>: component
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  contact_point<epic_internal><native> := struct<epic_internal> {
    ContactDepth<public><native>: float = external {}

    ContactImpulse<public><native>: (/Verse.org/SpatialMath:)vector3 = external {}

    ContactNormal<public><native>: (/Verse.org/SpatialMath:)vector3 = external {}

    ContactPosition<public><native>: (/Verse.org/SpatialMath:)vector3 = external {}
  }

  # Internal component used to flag an entity as the source of a Content Scope
  content_scope_component<epic_internal><native> := class<final><final_super>(component) {}

  @experimental
  damageable_component<epic_internal><native> := class<final_super>(component) {
    @experimental
    Damage<public><native>(Amount: float): void

    @experimental
    DamagedEvent<public><final><native>: listenable(float) = external {}
  }

  # Used to place a decal in the scene.
  decal_component<epic_internal><native> := class<final_super>(component, property_changed_interface) {
    Material<epic_internal><native>: material = external {}

    OnAddedToSceneInternal<native><override>(): void

    OnInitializedInternal<native><override>(): void

    OnPropertyChangedFromVerse<native><override>(PropertyName: string)<transacts>: void

    OnRemovingFromSceneInternal<native><override>(): void

    OnUninitializingInternal<native><override>(): void
  }

  # Detail level tier required for a `mesh_component` to be rendered. Mirrors
  # UE's `EDetailMode` so the ordinals line up with the `r.DetailMode`
  # scalability CVar (Low=0, Medium=1, High=2, Epic=3).
  detail_mode<epic_internal><native> := enum {
    # Rendered only when `r.DetailMode` is 3. Equivalent to UE's `DM_Epic`.
    Epic

    # Rendered when `r.DetailMode` is at least 2. Equivalent to UE's `DM_High`.
    High

    # Always rendered. Equivalent to UE's `DM_Low`.
    Low

    # Rendered when `r.DetailMode` is at least 1. Equivalent to
    # UE's `DM_Medium`.
    Medium
  }

  # A `directional_light_component` simulates light that is being emitted from a
  # source that is infinitely far away. This means that all shadows cast by this
  # light will be parallel, making this the ideal choice for
  # simulating sunlight.
  directional_light_component<public><native> := class<final>(light_component) {
    @editable_slider(float) { EpicOnly := true; MinValue := option { 0.000000 }; MaxValue := option { 1.000000 } }
    @category("Epic Internal")
    # Controls the size of the fade out region at the far extent of the dynamic
    # shadow's influence
    CascadeDistanceFadeoutFraction<epic_internal><native>: float = external {}

    @editable_slider(float) { EpicOnly := true; MinValue := option { 1.000000 }; MaxValue := option { 4.000000 } }
    @category("Epic Internal")
    # Controls whether the cascades are distributed closer to the camera (larger
    # exponent) or further from the camera (smaller exponent)
    CascadeDistributionExponent<epic_internal><native>: float = external {}

    @editable_slider(float) { EpicOnly := true; MinValue := option { 0.000000 }; MaxValue := option { 0.300000 } }
    @category("Epic Internal")
    # Proportion of the fade region between cascades
    CascadeTransitionFraction<epic_internal><native>: float = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # How far, in centimeters, cascaded shadow map dynamic shadows will cover,
    # measured in units from the camera. A value of 0 disables the
    # dynamic shadow
    DynamicShadowDistance<epic_internal><native>: float = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Distance at which the far shadow cascade should end
    EnableLightShaftOcclusion<epic_internal><native>: logic = external {}

    @editable_slider(int) { EpicOnly := true; MinValue := option { 0 }; MaxValue := option { 4 } }
    @category("Epic Internal")
    # The number of cascades between DynamicShadowDistance and FarShadowDistance
    # that are covered by Far Shadow Cascades, or zero to disable far
    # shadow cascades
    FarShadowCascadeCount<epic_internal><native>: int = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Distance, in centimeters, at which the far shadow cascade should end
    FarShadowDistance<epic_internal><native>: float = external {}

    @editable_slider(int) { EpicOnly := true; MinValue := option { 0 }; MaxValue := option { 4 } }
    @category("Epic Internal")
    # Number of cascades to split the view frustum into for the whole scene
    # dynamic shadow
    NumDynamicShadowCascades<epic_internal><native>: int = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Everything closer to the camera than this distance, measured in
    # centimeters, will occlude light shafts
    OcclusionDepthRange<epic_internal><native>: float = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Controls how dark the occlusion masking is
    OcclusionMaskDarkness<epic_internal><native>: float = external {}

    OnAddedToSceneInternal<native><override>(): void

    # Intensity of the light hitting the surface. In Lux (Lumen per
    # square meter).
    var Illuminance<public>: float = external {}

    # Angle subtended by light source in degrees (also known as angular
    # diameter). Defaults to 0.5357 which is the angle for our sun.
    var SourceAngleDegrees<public>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  # Interface used to trigger easing behaviors
  easeable<public> := interface<epic_internal>(cancelable) {
    # Trigger an ease-in.
    # Triggering an ease-in again when already easing-in or when fully eased-in
    # has no effect unless a different target weight is specified.
    (/Verse.org/SceneGraph/easeable:)EaseIn<epic_internal>()<transacts>: void

    # Trigger an ease-in providing a new ease-in window, overriding any
    # previously provided window.
    # Triggering an ease-in again when already easing-in or when fully eased-in
    # has no effect unless a different target weight is specified.
    (/Verse.org/SceneGraph/easeable:)EaseIn<epic_internal>(EaseInWindow: easing_window)<transacts>: void

    # Event that gets called when an ease in is started.
    EaseInEvent<epic_internal>: listenable(tuple())

    # Trigger an ease-out.
    # Triggering an ease-out again when already easing-out, or when fully
    # eased-out has no effect
    (/Verse.org/SceneGraph/easeable:)EaseOut<public>()<transacts>: void

    # Trigger an ease-out. If an easing_window is provided here, then it will
    # override any previously provided window.
    # Triggering an ease-out again when already easing-out, or when fully
    # eased-out has no effect
    (/Verse.org/SceneGraph/easeable:)EaseOut<public>(EaseOutWindow: easing_window)<transacts>: void

    # Event that gets called when an ease out starts.
    EaseOutEvent<epic_internal>: listenable(tuple())

    # Event that gets called when an ease in is finished.
    PostEaseInEvent<epic_internal>: listenable(tuple())

    # Event that gets called when an ease out finishes.
    PostEaseOutEvent<epic_internal>: listenable(tuple())
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  easeout_impl_internal<epic_internal> := class<epic_internal> {
    EasingModifier<epic_internal>: easing_modifier(skeleton)
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  # Modifier that eases in and out based around a duration, with timing based on
  # a clock.
  # The internal timeline begins when the modifier is eased-in and ends either:
  # - When a timer of finite length expires.
  # - When the modifier is removed from the stack via cancelable.Cancel().
  # - When the modifier is eased out by calling EaseOut and the ease-out
  #   window completes.
  # Target weight transitions from 0.0 to 1.0 over the duration of the ease-in
  # window, then transitions from 1.0 to 0.0 over the duration of the easing
  # away window.
  # If the ease in/out windows overlap when applied relative to the target
  # modifier's timeline, then the weight is the product of each window’s weight.
  # The easing out window is applied when either the internal timeline reaches
  # the window, or the modifier is cancelled on the stack, whichever
  # occurs earlier.
  easing_modifier<epic_internal><native>(t: type) := class<epic_internal><final>(
    easing_modifier_base,
    modifier(t),
    easeable
  ) {
    Cancel<override>()<transacts>: void = external {}

    # Trigger an ease-in providing a new ease-in window, overriding any
    # previously provided window.
    # Triggering an ease-in again when already easing-in or when fully eased-in
    # has no effect unless a different target weight is specified.
    (/Verse.org/SceneGraph/easeable:)EaseIn<native><override>((local:)EaseInWindow: easing_window)<transacts>: void

    # Trigger an ease-in.
    # Triggering an ease-in again when already easing-in or when fully eased-in
    # has no effect unless a different target weight is specified.
    (/Verse.org/SceneGraph/easeable:)EaseIn<native><override>()<transacts>: void

    # Event that gets called when an ease in is started.
    EaseInEvent<native><override>: listenable(tuple()) = external {}

    # Easing to apply when easing in (i.e. 'towards' the target).
    EaseInWindow<epic_internal><native>: easing_window = external {}

    # Trigger an ease-out. If an easing_window is provided here, then it will
    # override any previously provided window.
    # Triggering an ease-out again when already easing-out, or when fully
    # eased-out has no effect
    (/Verse.org/SceneGraph/easeable:)EaseOut<native><override>((local:)EaseOutWindow: easing_window)<transacts>: void

    # Trigger an ease-out.
    # Triggering an ease-out again when already easing-out, or when fully
    # eased-out has no effect
    (/Verse.org/SceneGraph/easeable:)EaseOut<native><override>()<transacts>: void

    # Event that gets called when an ease out starts.
    EaseOutEvent<native><override>: listenable(tuple()) = external {}

    # Easing to apply when easing out (i.e. 'away from' the target).
    EaseOutWindow<epic_internal><native>: easing_window = external {}

    Evaluate<native><override>(InValue: t)<reads>: t

    # Event that gets called when an ease in is finished.
    PostEaseInEvent<native><override>: listenable(tuple()) = external {}

    # Event that gets called when an ease out finishes.
    PostEaseOutEvent<native><override>: listenable(tuple()) = external {}

    (/Verse.org/SceneGraph/easing_modifier:)SceneGraph_easing_modifier_Variance<private>(
      : t,
      : t
    ): tuple(t, t) = external {}

    @available { MinUploadedAtFNVersion := 4210 }
    (/Verse.org/SceneGraph/easing_modifier:)SceneGraph_easing_modifier_Variance_Inherited<private>(
      : t,
      : t
    ): tuple(t, t) = external {}

    @editable
    @replicated("RepNotify")
    # Target to transition into or out from
    Target<epic_internal><native>: modifier(t)
  }

  @import_as("/Script/EntityModifiers.UEntityEasingModifierBase")
  easing_modifier_base<epic_internal><native> := class<epic_internal> {}

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  # An easing function combined with a relative time window
  easing_window<public><native> := struct<concrete> {
    @editable
    # Duration of the easing window in seconds
    Duration<native>: float = external {}

    # Easing function to apply
    (/Verse.org/SceneGraph/easing_window:)Easing<native>: type { _(: float)<reads>: float } = external {}

    @editable
    # Offset of the easing window in seconds
    # The offset allows the window to be moved later or earlier relative to the
    # easing modifier’s internal timeline.
    # For example, moving the ease-in window later (ie +Offset) would cause the
    # blend to happen later - ie delay it.
    # For -ve offsets to ease-in and +ve offsets to ease-out, this has the
    # effect of allowing ‘frozen’ states of targets to be observed (for
    # time-varying targets).
    Offset<native>: float = external {}
  }

  # Entities are the base object in the SceneGraph.
  #   * Objects in experiences are constructed of one or more entities.
  #   * Entities are hierarchical. You can query your parent using `GetParent`
  #     and add child entities using `AddEntities`.
  #   * Behavior is added to entities
  #     through `component`s. You can add new components using `AddComponents`.
  #   * The structure and content of entities is dynamic and be changed at any
  #     time through your experience
  # .
  # ==============================================================================
  # Deriving from entity
  #
  #   In the SceneGraph system a class that derives from `entity` is also known
  #   as a prefab. Prefabs are useful when you want to spawn/re-use a collection
  #   of entities and components many times within your game. Primarily prefabs
  #   are authored through the editor, with their Verse classes generated as
  #   part of the build into the projects
  #   Assets.digest.verse file.
  #
  #   While you can create base prefabs for common game object types like a
  #   vehicle or character, we highly recommended that you do not add code
  #   directly to the entity class, and instead keep logic in components.
  #   Keeping logic and data in components allows you to restructure your
  #   prefabs throughout production of your experience, without needing to
  #   massively refactor your class structure.
  entity<public><native> := class<concrete><unique><transacts><castable>(diagnosable, has_tags) {
    # Adds the provided components to the entity.
    #   * If a component is not allowed to be added to this entity it
    #     is skipped.
    #   Note: When called during the AddedToScene or BeginSimulation phase, it
    #         will make sure the added component has achieved the
    #         corresponding phase.
    #   * Components are added following these rules:
    #       1. All components are added to the entity child list.
    #       2. All components have `OnAddedToScene` called (if this entity is in
    #          the scene).
    #       3. All components have `OnBeginSimulation` called (if this entity
    #          is simulating).
    AddComponents<public><final><native>(Components: []component): void

    # Adds the provided entities as children of this entity.
    #   * If child entity already has a parent, removes the entity from its
    #     current parent and adds it to the new one.
    #   * Added child entities will move through their lifetime methods until
    #     they match the state of the new parent.
    AddEntities<public><final><native>(NewChildEntities: []entity): void

    # Adds a `tag` instance to this entity. Returns a `tag_key` that is uniquely
    # associated with the added instance.
    AddTag<final><override><native>(Tag: tag)<transacts>: tag_key

    # Fails if at least one type in `tag_types` cannot be found in this
    # container, succeeds otherwise. Note that this means that if `tag_types` is
    # empty this call succeeds.
    ContainsAllTags<final><override><native>(tag_types: []castable_subtype(tag))<decides><reads>: void

    # Succeeds if at least of the types in `tag_types` is found in this
    # container, fails otherwise. Note that this means that if `tag_types` is
    # empty this call fails.
    ContainsAnyTag<final><override><native>(tag_types: []castable_subtype(tag))<decides><reads>: void

    # Succeeds if at least one tag of type `tag_type` is found in this
    # container, fails otherwise.
    ContainsTag<final><override><native>(tag_type: castable_subtype(tag))<decides><reads>: void

    # Succeeds and returns the child component of type `component_type` if it
    # exists and is accessible from the calling context.
    #   Note: When called during the AddedToScene or BeginSimulation phase, it
    #         will make sure the returned component has achieved the
    #         corresponding phase.
    #   Fails if no component of `component_type` exists or can be accessed.
    GetComponent<public><final><native>(component_type: castable_subtype(component))<decides><reads>: component_type

    # Returns the child components belonging to this entity which are accessible
    # from the calling context.
    GetComponents<public><final><native>()<reads>: []component

    GetDiagnostic<override><native>()<reads>: diagnostic

    # Returns the child entities belonging to this entity which are accessible
    # from the calling context.
    #   * This method only gets the direct entity children. To query multiple
    #     levels down the entity structure use the Find* query methods instead.
    GetEntities<public><final><native>()<reads>: []entity

    # Returns the parent entity of this entity.
    #   * The parent entity controls the lifetime of its child entities and
    #     components. When an entity is removed from the scene, all its child
    #     entities and components will be removed as well.
    #   * Method fails if there is currently no parent entity.
    GetParent<public><final><native>()<decides><reads>: entity

    # Removes all tag instances of type `tag_type`, succeeds if at least one
    # instance was removed, fails otherwise.
    RemoveAllTags<final><override><native>(tag_type: castable_subtype(tag))<transacts><decides>: void

    # Removes all tag instances that are not of type `tag_type`, succeeds if at
    # least one instance was removed, fails otherwise.
    RemoveAllTagsExcept<final><override><native>(tag_type: castable_subtype(tag))<transacts><decides>: void

    # Removes all tag instances that are not of any of the types in `tag_types`,
    # succeeds if at least one instance was removed, fails otherwise.
    RemoveAllTagsExcept<final><override><native>(tag_types: []castable_subtype(tag))<transacts><decides>: void

    # Removes this entity from its parent. This is used to remove entities from
    # the scene.
    #   * Components on this entity and its children will run through
    #     `OnEndSimulation` -> `OnRemovingFromScene`.
    #   * Entity can be added back later by using `NewParent.AddEntities`.
    RemoveFromParent<public><final><native>(): void

    # Removes the tag instance associated with the `tag_key`, succeeds if an
    # instance was removed, fails otherwise.
    RemoveTag<final><override><native>(Key: tag_key)<transacts><decides>: void

    # Send a scene event to this entity and then down the hierarchy. First,
    # SendDown/OnReceive will be invoked on each component on this entity. Next,
    # SendDown will be invoked on each child entity.  Consuming the event at any
    # point will halt propagation. Returns true if any participant consumed
    # the event.
    SendDown<public><final><native><native_callable>(SceneEvent: scene_event): logic

    # Send a scene event to this entity and then up the hierarchy. First,
    # SendDown/OnReceive will be invoked on each component on this entity. Next,
    # SendUp will be invoked on this entity's parent. Consuming the event at any
    # point will halt propagation. Returns true if any participant consumed
    # the event.
    SendUp<public><final><native><native_callable>(SceneEvent: scene_event): logic
  }

  # class to provide alternative origin to the 'transform_component' as
  # an entity
  entity_origin<public><native> := class<final>(origin) {
    @editable
    @replicated("RepNotify")
    Entity<public><native>: entity

    GetTransform<override>()<transacts>: (/Verse.org/SpatialMath:)transform = external {}

    OnRep_Entity<epic_internal><native>(): void

    OnRep_EntityOriginTransform<epic_internal><native>(): void

    @replicated("RepNotify")
    @transient
    var EntityOriginTransform<epic_internal><native>: (/Verse.org/SpatialMath:)transform = external {}
  }

  # Reference type to editor defined prefab. Only generated digest code should
  # reference this type.
  entity_prefab<public><native> := class<epic_internal><computes>(asset) {}

  entity_query_iterator<epic_internal><native> := class<epic_internal>(entity_query_iterator_interface) {
    NextValue<native><override>()<transacts><decides>: entity
  }

  entity_query_iterator_interface<epic_internal><native> := interface<epic_internal> {
    NextValue<public><native_callable>()<transacts><decides>: entity
  }

  @hide_in_editor
  entity_registry_component<epic_internal><native> := class<epic_internal><final_super>(component) {}

  # Entity client streaming modes
  entity_streaming_policy<public><native> := enum {
    # Entity will be non-spatially loaded.
    NonSpatial

    # Entity will be always loaded.
    Persistent

    # Entity will be spatially loaded.
    Spatial
  }

  @available { MinUploadedAtFNVersion := 4000 }
  epic_rarity<public> := class<allocates>(rare_rarity) {
    Color<override>: color = external {}
  }

  # Used to subscribe a callback or await an event based callback.
  execution_event<epic_internal><native> := class<epic_internal>(listenable(tuple())) {
    # Suspends the current task until resumed by a matching call
    # to `signalable.Signal`.
    Await<native><override>()<suspends>: tuple()

    # Subscribe a callback function to this event.
    Subscribe<native><override>(Callback: type { _(): void })<transacts>: cancelable
  }

  # Users to subscribe to, or await on, a DeltaTime based callback from one of
  # the phases in a component's `TickEvents` object.
  execution_listenable<public><native> := class<epic_internal>(listenable(float)) {
    # Suspends the current task until resumed by a matching call to
    # `signalable.Signal`. Returns the event `payload`.
    Await<native><override>()<suspends>: float

    # Subscribe a callback function to this TickEvent phase. The input parameter
    # to your function (DeltaTime) is the time that has passed between the last
    # update and the current update.
    Subscribe<native><override>(Callback: type { _(: float): void })<transacts>: cancelable
  }

  # Verse path: /Verse.org/SceneGraph
  execution_subscription<epic_internal><native> := class(cancelable) {
    Cancel<native><override>()<transacts>: void

    RunAfter<epic_internal><native>(__dupe___unnamed_parameter_0: execution_subscription): void

    RunBefore<epic_internal><native>(__dupe___unnamed_parameter_0: execution_subscription): void
  }

  @available { MinUploadedAtFNVersion := 4000 }
  exotic_rarity<epic_internal> := class<allocates>(mythic_rarity) {
    Color<override>: color = external {}
  }

  @experimental
  @replicatable
  # A range with a minimum and maximum value. For a value to fall inside of this
  # range, the min value must be less than or equal to the max value.
  float_range<public><native> := struct<concrete> {
    @editable
    Maximum<public><native>: float = external {}

    Minimum<public><native>: float = external {}
  }

  @experimental
  # gear change event data
  gear_change_info<epic_internal><native> := struct<epic_internal> {
    ChangedToGear<public><native>: int
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Interface for classes that own a camera modifier stack.
  has_camera_modifier<public><native> := interface {
    @editable
    @replicated("")
    @experimental
    CameraModifiers<public>: modifier_stack(camera_state) = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  has_collision<epic_internal><native> := interface<epic_internal>(has_mesh_part_support) {
    @experimental
    GetBeginCollideEvent<epic_internal><final><native_callable>(): listenable(generator(collision_hit)) = external {}

    @experimental
    GetBeginOverlapEvent<epic_internal><final><native_callable>(): listenable(generator(overlap_hit)) = external {}

    # True if any associated physics objects are physically collidable
    GetCollidable<epic_internal><final><native_callable>()<reads>: logic = external {}

    @deprecated
    @experimental
    GetCollisionEnteredEvent<epic_internal><final><native_callable>(): listenable(generator(
      collision_hit
    )) = external {}

    @experimental
    GetCollisionEvent<epic_internal><final><native_callable>(): listenable(generator(collision_hit)) = external {}

    @deprecated
    @experimental
    GetCollisionExitedEvent<epic_internal><final><native_callable>(): listenable(generator(collision_hit)) = external {}

    GetCollisionMaterial<epic_internal><final><native_callable>()<reads>: collision_material = external {}

    @experimental
    GetEndCollideEvent<epic_internal><final><native_callable>(): listenable(generator(collision_hit)) = external {}

    @experimental
    GetEndOverlapEvent<epic_internal><final><native_callable>(): listenable(generator(overlap_hit)) = external {}

    @deprecated
    @experimental
    GetOverlapEnteredEvent<epic_internal><final><native_callable>(): listenable(generator(overlap_hit)) = external {}

    @deprecated
    @experimental
    GetOverlapExitedEvent<epic_internal><final><native_callable>(): listenable(generator(overlap_hit)) = external {}

    # Set the physics collidability for all associated physics objects
    SetCollidable<epic_internal><final><native_callable>(In: logic): void = external {}

    SetCollisionMaterial<epic_internal><final><native_callable>(In: collision_material): void = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  has_collision_impl<epic_internal><native> := class<epic_internal><final> {
    @experimental
    CollisionEnteredEventImpl<epic_internal><native>: listenable(generator(collision_hit)) = external {}

    @experimental
    CollisionEventImpl<epic_internal><native>: listenable(generator(collision_hit)) = external {}

    @experimental
    CollisionExitedEventImpl<epic_internal><native>: listenable(generator(collision_hit)) = external {}

    GetCollidableImpl<epic_internal><native>()<reads>: logic

    GetCollisionMaterialImpl<epic_internal><native>()<reads>: collision_material

    @experimental
    OverlapEnteredEventImpl<epic_internal><native>: listenable(generator(overlap_hit)) = external {}

    @experimental
    OverlapExitedEventImpl<epic_internal><native>: listenable(generator(overlap_hit)) = external {}

    SetCollidableImpl<epic_internal><native>(In: logic): void

    SetCollisionMaterialImpl<epic_internal><native>(In: collision_material): void
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  has_dynamics<epic_internal><native> := interface<epic_internal>(has_mesh_part_support) {
    ApplyAngularImpulse<epic_internal><final><native_callable>(
      AngularImpulse: (/Verse.org/SpatialMath:)vector3
    ): void = external {}

    ApplyForce<epic_internal><final><native_callable>(Force: (/Verse.org/SpatialMath:)vector3): void = external {}

    ApplyLinearImpulse<epic_internal><final><native_callable>(
      LinearImpulse: (/Verse.org/SpatialMath:)vector3
    ): void = external {}

    ApplyTorque<epic_internal><final><native_callable>(Torque: (/Verse.org/SpatialMath:)vector3): void = external {}

    GetAngularVelocity<epic_internal><final><native_callable>(): (/Verse.org/SpatialMath:)vector3 = external {}

    # By default, true if any associated physics objects are
    # physically simulated
    GetDynamic<epic_internal><final><native_callable>()<reads>: logic = external {}

    GetLinearVelocity<epic_internal><final><native_callable>(): (/Verse.org/SpatialMath:)vector3 = external {}

    GetMass<epic_internal><final><native_callable>(): float = external {}

    SetAngularVelocity<epic_internal><final><native_callable>(
      AngularVelocity: (/Verse.org/SpatialMath:)vector3
    ): void = external {}

    # By default, set the dynamic state for all associated physics objects
    SetDynamic<epic_internal><final><native_callable>(In: logic): void = external {}

    SetLinearVelocity<epic_internal><final><native_callable>(
      LinearVelocity: (/Verse.org/SpatialMath:)vector3
    ): void = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  has_dynamics_impl<epic_internal><native> := class<epic_internal><final> {
    ApplyAngularImpulseImpl<epic_internal><native>(AngularImpulse: (/Verse.org/SpatialMath:)vector3): void

    ApplyForceImpl<epic_internal><native>(Force: (/Verse.org/SpatialMath:)vector3): void

    ApplyLinearImpulseImpl<epic_internal><native>(LinearImpulse: (/Verse.org/SpatialMath:)vector3): void

    ApplyTorqueImpl<epic_internal><native>(Torque: (/Verse.org/SpatialMath:)vector3): void

    GetAngularVelocityImpl<epic_internal><native>(): (/Verse.org/SpatialMath:)vector3

    GetDynamicImpl<epic_internal><native>()<reads>: logic

    GetLinearVelocityImpl<epic_internal><native>(): (/Verse.org/SpatialMath:)vector3

    GetMassImpl<epic_internal><native>(): float

    SetAngularVelocityImpl<epic_internal><native>(AngularVelocity: (/Verse.org/SpatialMath:)vector3): void

    SetDynamicImpl<epic_internal><native>(In: logic): void

    SetLinearVelocityImpl<epic_internal><native>(LinearVelocity: (/Verse.org/SpatialMath:)vector3): void
  }

  # Merge Rules Interface. Implemented by components that want to participate in
  # entity mergeability checks.
  has_merge_rules<public> := interface<unique> {
    AllowMergeInto<public>(TargetEntity: entity)<decides><reads>: void = external {}

    OnMergeInto<public>(TargetEntity: entity, MergeAmount: int)<transacts>: void = external {}
  }

  has_mesh_part_support<epic_internal><native> := interface<epic_internal> {}

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  has_origin<epic_internal><native> := interface<epic_internal>(has_mesh_part_support) {
    # Returns the origin of the socket this mesh_part is attached to, or false
    # if no socket is associated/resolvable
    GetPartOrigin<epic_internal><final><native_callable>()<reads>: ?origin = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  has_origin_impl<epic_internal><native> := class<epic_internal><final> {
    GetOriginImpl<epic_internal><native>()<decides><reads>: presentation_origin
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  # A owner of a modifier of skeletons, used to animate meshes using
  # skeletal animation
  has_skeletal_animation<epic_internal><native> := interface<epic_internal> {
    GetSkeletalAnimation<epic_internal><native_callable>(): modifier_stack(skeleton) = external {}

    @editable
    @category("Animation")
    SkeletalAnimation<epic_internal>: modifier_stack(skeleton)
  }

  has_uaf_shared_variables<epic_internal><native> := interface<epic_internal> {
    InternalAsset<epic_internal>: animation_asset

    SetProperty<epic_internal>(PropertyName: string, NewValue: any)<transacts>: void = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  has_ue_physics_properties<epic_internal><native> := interface<epic_internal> {
    GetCollisionProfileName<epic_internal><native_callable>()<reads>: string = external {}

    GetGravityEnabled<epic_internal><native_callable>()<reads>: logic = external {}

    GetGravityGroupIndex<epic_internal><native_callable>()<reads>: int = external {}

    GetLinearEtherDrag<epic_internal><native_callable>()<reads>: float = external {}

    GetMassOverride<epic_internal><native_callable>()<reads>: float = external {}

    GetMaxAngularVelocityDegs<epic_internal><native_callable>()<reads>: float = external {}

    GetOverridesMaxAngularVelocity<epic_internal><native_callable>()<reads>: logic = external {}

    GetSleepType<epic_internal><native_callable>()<reads>: ue_phys_sleep_type = external {}

    GetStartAwake<epic_internal><native_callable>()<reads>: logic = external {}

    GetUE_CollisionMaterial<epic_internal><native_callable>(): ue_collision_material = external {}

    GetUseCCD<epic_internal><native_callable>()<reads>: logic = external {}

    SetCollisionProfileName<epic_internal><native_callable>(In: string): void = external {}

    SetGravityEnabled<epic_internal><native_callable>(In: logic): void = external {}

    SetGravityGroupIndex<epic_internal><native_callable>(In: int): void = external {}

    SetLinearEtherDrag<epic_internal><native_callable>(In: float): void = external {}

    SetMassOverride<epic_internal><native_callable>(In: float): void = external {}

    SetMaxAngularVelocityDegs<epic_internal><native_callable>(In: float): void = external {}

    SetOverridesMaxAngularVelocity<epic_internal><native_callable>(In: logic): void = external {}

    # Teleports the physics body to InTranslation/InRotation and records the
    # change in the resim buffer. Resets linear and angular velocity
    SetPhysicsTransform<epic_internal><native_callable>(
      InTranslation: (/Verse.org/SpatialMath:)vector3,
      InRotation: (/Verse.org/SpatialMath:)rotation
    )<transacts>: void = external {}

    SetSleepType<epic_internal><native_callable>(In: ue_phys_sleep_type): void = external {}

    SetStartAwake<epic_internal><native_callable>(In: logic): void = external {}

    SetUE_CollisionMaterial<epic_internal><native_callable>(In: ue_collision_material): void = external {}

    SetUseCCD<epic_internal><native_callable>(In: logic): void = external {}

    UpdateMassProperties<epic_internal><native_callable>(): void = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  has_ue_physics_properties_impl<epic_internal><native> := class<final> {
    GetCollisionProfileNameImpl<epic_internal><native>()<reads>: string

    GetGravityEnabledImpl<epic_internal><native>()<reads>: logic

    GetGravityGroupIndexImpl<epic_internal><native>()<reads>: int

    GetLinearEtherDragImpl<epic_internal><native>()<reads>: float

    GetMassOverrideImpl<epic_internal><native>()<reads>: float

    GetMaxAngularVelocityDegsImpl<epic_internal><native>()<reads>: float

    GetOverridesMaxAngularVelocityImpl<epic_internal><native>()<reads>: logic

    GetSleepTypeImpl<epic_internal><native>()<reads>: ue_phys_sleep_type

    GetStartAwakeImpl<epic_internal><native>()<reads>: logic

    GetUE_CollisionMaterialImpl<epic_internal><native>(): ue_collision_material

    GetUseCCDImpl<epic_internal><native>()<reads>: logic

    SetCollisionProfileNameImpl<epic_internal><native>(In: string): void

    SetGravityEnabledImpl<epic_internal><native>(In: logic): void

    SetGravityGroupIndexImpl<epic_internal><native>(In: int): void

    SetLinearEtherDragImpl<epic_internal><native>(In: float): void

    SetMassOverrideImpl<epic_internal><native>(In: float): void

    SetMaxAngularVelocityDegsImpl<epic_internal><native>(In: float): void

    SetOverridesMaxAngularVelocityImpl<epic_internal><native>(In: logic): void

    SetPhysicsTransformImpl<epic_internal><native>(
      InTranslation: (/Verse.org/SpatialMath:)vector3,
      InRotation: (/Verse.org/SpatialMath:)rotation
    )<transacts>: void

    SetSleepTypeImpl<epic_internal><native>(In: ue_phys_sleep_type): void

    SetStartAwakeImpl<epic_internal><native>(In: logic): void

    SetUE_CollisionMaterialImpl<epic_internal><native>(In: ue_collision_material): void

    SetUseCCDImpl<epic_internal><native>(In: logic): void

    UpdateMassPropertiesImpl<epic_internal><native>(): void
  }

  @experimental
  hit_result<epic_internal><native> := struct {
    @experimental
    HitLocation<public><native>: (/Verse.org/SpatialMath:)vector3

    @experimental
    HitNormal<public><native>: (/Verse.org/SpatialMath:)vector3

    @experimental
    OtherComponent<public><native>: ?component

    @experimental
    OtherEntity<public><native>: ?entity

    @experimental
    ThisComponent<public><native>: ?component

    @experimental
    ThisEntity<public><native>: ?entity
  }

  # Component that holds an icon for an entity.
  icon_component<public><native> := class<final_super>(component, has_icon) {
    OnBeginSimulation<override>(): void = external {}

    OnEndSimulation<override>(): void = external {}

    OnIconChanged<epic_internal><native_callable>(): void = external {}

    var Icon<override>: texture = external {}

    var<private> HasChangedFields<epic_internal><native>: logic = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  @experimental
  impossible_rarity<epic_internal> := class<allocates>(exotic_rarity) {
    Color<override>: color = external {}
  }

  # Used to handle general interaction.
  interactable_component<public><native> := class<final_super>(component, enableable) {
    # Returns whether the specified agent can interact.
    CanInteract<public><native><native_callable>(Agent: agent)<decides><reads>: void

    # Event fires when an interaction has ended before completing successfully.
    # Sends the formerly interacting agent. interactable_component cannot be
    # canceled, this event is provided for subclasses to fire where appropriate.
    CanceledEvent<public><native>: listenable(agent) = external {}

    # Disable interaction with the component. Disabled components do not provide
    # interaction prompts.
    Disable<native><override>(): void

    # Enable interaction with the component.
    Enable<native><override>(): void

    # Returns an appropriate message to display to players to communicate the
    # current state of the interactable.
    InteractMessage<public><native><native_callable>(Agent: agent)<decides><reads>: message

    # Succeeds if the component is enabled, fails if it’s disabled.
    IsEnabled<native><override>()<transacts><decides>: void

    OnBeginSimulationInternal<native><override>(): void

    OnEndSimulationInternal<native><override>(): void

    OnInitializedInternal<native><override>(): void

    # Called from Start if CanInteract pass successfully to start the
    # interaction. Overriding this function will allow you to create a custom
    # interaction behaviour.
    OnStarted<protected><native><native_callable>(Agent: agent)<transacts><decides>: void

    OnUninitializingInternal<native><override>(): void

    # Fires the CanceledEvent event.
    SignalCancelEvent<protected><native>(Agent: agent)<transacts>: void

    # Fires the StartedEvent event.
    SignalStartEvent<protected><native>(Agent: agent)<transacts>: void

    # Fires the SucceededEvent event.
    SignalSucceedEvent<protected><native>(Agent: agent)<transacts>: void

    # Attempt to start an interaction. Fails if the agent does not pass the
    # CanInteract function.
    Start<public><final><native>(Agent: agent)<transacts><decides>: void

    # Event fires when a successful interaction starts. Sends the interacting
    # agent. InteractDuration at or below 0 makes this event identical
    # to InteractSucceededEvent.
    StartedEvent<public><native>: listenable(agent) = external {}

    # Event fires when an interaction has completed successfully. Sends the
    # formerly interacting agent. InteractDuration at or below 0 makes this
    # event identical to InteractStartedEvent.
    SucceededEvent<public><native>: listenable(agent) = external {}
  }

  # Used to set a cooldown when interacted.
  interactable_cooldown<public><native> := class<concrete> {
    # Event which fires when the shared cooldown expires.
    ExpiredEvent<public><native>: listenable(tuple()) = external {}

    # Get the remaining shared cooldown duration in seconds, affecting
    # all agents.
    GetRemainingDuration<epic_internal><native>(__dupe___unnamed_parameter_0: accessor)<transacts>: float

    # Set the remaining shared cooldown duration in seconds, affecting
    # all agents.
    SetRemainingDuration<epic_internal><native>(
      __dupe___unnamed_parameter_0: accessor,
      InRemainingDuration: float
    )<transacts>: void

    @editable
    # The number of seconds after a successful interaction, before being able to
    # initiate a subsequent interaction for anyone.
    # This is only used if duration is greater than 0.0. Modifying this does not
    # affect the RemainingDuration.
    # When a cooldown starts on the component all other interactions
    # are canceled.
    var Duration<public><native>: float = external {}

    # The remaining cooldown, in seconds, before new interactions can be
    # initiated on this component.
    var<public> RemainingDuration<public>: float = external {}
  }

  # Used to set a cooldown per agent when interacted.
  interactable_cooldown_per_agent<public><native> := class<concrete> {
    # Event which fires when the per agent cooldown expires. Sends the agent
    # which was previously affected by the cooldown.
    ExpiredEvent<public><native>: listenable(agent) = external {}

    # Get the remaining shared cooldown duration in seconds, affecting
    # all agents.
    GetRemainingDurationForAgent<epic_internal><native>(
      __dupe___unnamed_parameter_0: accessor,
      Agent: agent
    )<transacts>: float

    # Set the remaining shared cooldown duration in seconds, affecting
    # all agents.
    SetRemainingDurationForAgent<epic_internal><native>(
      __dupe___unnamed_parameter_0: accessor,
      Agent: agent,
      InRemainingDuration: float
    )<transacts>: void

    @editable
    # The duration in seconds after a successful interaction, before the
    # interacting agent can initiate a subsequent interaction.
    # This is only used if the duration is greater than 0.0. Modifying this does
    # not affect any RemainingPerAgentCooldownDuration.
    # This property gives other agents time to interact, when there is a limited
    # number of Simultaneous Interactors.
    var Duration<public><native>: float = external {}

    # The cooldown remaining, in seconds, before a particular agent is able to
    # initiate an interaction on this component.
    var<private> RemainingDuration<public><native>: [agent]float = external {}
  }

  # Used to set an interaction duration.
  interactable_duration<public><native> := class<concrete> {
    # Interact duration getter.
    GetInteractDuration<epic_internal><native>(__dupe___unnamed_parameter_0: accessor)<transacts>: float

    # Max Simultaneous Interactors duration getter.
    GetMaxSimultaneousInteractors<epic_internal><native>(__dupe___unnamed_parameter_0: accessor)<transacts>: ?int

    # Returns an agent’s remaining duration, in seconds, for interaction. Fails
    # if the agent is not interacting with this component.Returns the same value
    # when called multiple times within a transaction.
    GetRemainingInteractDurationForAgent<public><final><native>(Agent: agent)<decides><reads>: float

    # Interact duration setter.
    SetInteractDuration<epic_internal><native>(
      __dupe___unnamed_parameter_0: accessor,
      InRemainingDuration: float
    )<transacts>: void

    # Max Simultaneous Interactors duration setter.
    SetMaxSimultaneousInteractors<epic_internal><native>(
      __dupe___unnamed_parameter_0: accessor,
      InRemainingDuration: ?int
    )<transacts>: void

    # Sets an agent’s remaining duration, in seconds, for interaction. Fails if
    # the agent is not interacting with this component.
    SetRemainingInteractDurationForAgent<public><final><native>(Agent: agent, RemainingDuration: float)<transacts>: void

    @editable
    # The number of seconds an agent must spend interacting with the object to
    # successfully complete an interaction.
    # 0.0 or less results in an immediate successful interaction.
    # If set during an interaction, the value given will be used for the next
    # interaction and the remaining duration will be updated subtracting the new
    # given value with the current time elapsed.
    # If the subtraction were zero or less it will immediately conclude.
    var InteractDuration<public>: float = external {}

    @editable
    # The max number of simultaneous interactors. A value of false is unlimited.
    # This value represents how many agents may have active interactions.
    # If this changes to a value less than the current number of active
    # interactions, those interactions are not canceled but new interactions
    # will not start.
    var MaxSimultaneousInteractors<public>: ?int = external {}

    @replicated("")
    @editable
    @display_name("Interact Duration")
    # Internal InteractDuration value.
    var _InteractDuration<epic_internal><native>: float = external {}

    @replicated("")
    @editable
    @display_name("MaxSimultaneousInteractors")
    # Internal Max Simultaneous Interactors value.
    var _MaxSimultaneousInteractors<epic_internal><native>: ?int = external {}
  }

  # Used to set a limit of times to interact.
  interactable_success_limit<public><native> := class<concrete> {
    # Resets the counter for the times this component has had a
    # successful interaction.
    ClearSuccessfulInteractionCount<public><native>()<transacts>: void

    # Get the maximum number of successful interactions possible.
    GetMaxSuccessfulInteractions<epic_internal><native>(__dupe___unnamed_parameter_0: accessor)<transacts>: ?int

    # Update the maximum number of successful interactions possible, a value of
    # false is unlimited.
    # If the current number of tracked interactions is greater than the value
    # specified here, all current interactions will be canceled.
    SetMaxSuccessfulInteractions<epic_internal><native>(
      __dupe___unnamed_parameter_0: accessor,
      InMaxSuccessfulInteractions: ?int
    )<transacts>: void

    # The number of times the component can be successfully interacted with. A
    # value of false is unlimited.
    # When SuccessfulInteractionCount reaches MaxSuccessfulInteractions all
    # active interactions are canceled, and the component cannot be
    # interacted with.
    var MaxSuccessfulInteractions<public>: ?int = external {}

    # The number of times this component has had a successful interaction.
    var SuccessfulInteractionCount<public>: int = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Epic internal-only camera_modifier class that supports client execution.
  internal_camera_modifier<epic_internal><native> := class(camera_modifier) {}

  @available { MinUploadedAtFNVersion := 4000 }
  legendary_rarity<public> := class<allocates>(epic_rarity) {
    Color<override>: color = external {}
  }

  @hide_in_editor { CVar := "LevelEntity.ShowLevelEntityInOutliner"; Hidden := false }
  level_entity<epic_internal><native> := class<concrete><unique><transacts>(entity) {}

  level_subsim_component<epic_internal><native> := class<final_super>(component) {
    @editable
    SimulationEntityPrefab<epic_internal><native>: subtype(simulation_entity) = external {}
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
  light_component<public><native> := class<epic_internal><final_super><abstract>(component, enableable) {
    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether the light affects global illumination, when ray-traced global
    # illumination is enabled
    AffectGlobalIllumination<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # After exposure is applied, scene color brightness larger than the max
    # brightness will be rescaled down to the max brightness
    BloomMaxBrightness<epic_internal><native>: float = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Scales the additive color
    BloomScale<epic_internal><native>: float = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Scene color must be larger than this to create bloom in the light shafts
    BloomThreshold<epic_internal><native>: float = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Multiplies against scene color to create the bloom color
    BloomTint<epic_internal><native>: color = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether the light shadows volumetric fog
    CastVolumetricShadow<epic_internal><native>: logic = external {}

    # Disables rendering of this light.
    Disable<native><override>(): void

    # Enables rendering of this light.
    Enable<native><override>(): void

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether to render light shaft bloom from this light
    EnableLightShaftBloom<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether to enable lighting on the default channel for all primitives
    # and lights
    EnableLightingChannel0<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether to enable lighting on the first custom channel
    EnableLightingChannel1<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether to enable lighting on the second custom channel
    EnableLightingChannel2<epic_internal><native>: logic = external {}

    @editable_slider(float) { EpicOnly := true; MinValue := option { 0.000000 }; MaxValue := option { 10.000000 } }
    @display_name("IES Intensity Scale")
    @category("Epic Internal")
    # Global scale for IES brightness contribution. Only available when "Use IES
    # Intensity" is selected, and a valid IES profile texture is set.
    IESIntensityScale<epic_internal><native>: float = external {}

    @editable { EpicOnly := true }
    @display_name("IES Profile Texture")
    @category("Epic Internal")
    # If true, take light brightness from IES profile texture. If false, use the
    # light brightness. The maximum light in one direction is used to define no
    # masking. Will be disabled if a valid IES profile texture is not supplied.
    IESProfileTexture<epic_internal><native>: ?texture = external {}

    @editable_slider(float) { EpicOnly := true; MinValue := option { 0.000000 }; MaxValue := option { 6.000000 } }
    @category("Epic Internal")
    # Scales the indirect lighting contribution from this light
    IndirectLightingIntensity<epic_internal><native>: float = external {}

    # Succeeds if the component is enabled, fails if it's disabled.
    IsEnabled<native><override>()<transacts><decides>: void

    @editable_slider(float) { EpicOnly := true; MinValue := option { 0.000000 }; MaxValue := option { 1.000000 } }
    @category("Epic Internal")
    # Brightness factor applied to the light when the light function is
    # specified but disabled
    LightFunctionDisabledBrightness<epic_internal><native>: float = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Distance, in centimeters, at which the light function should be completely
    # faded to the configured disabled brightness
    LightFunctionFadeDistance<epic_internal><native>: float = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # The light function material to be applied to this light
    LightFunctionMaterial<epic_internal><native>: ?material = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Scales the light function projection. X and Y scale in the directions
    # perpendicular to the light's direction, Z scales along the
    # light direction.
    LightFunctionScale<epic_internal><native>: (/Verse.org/SpatialMath:)vector3 = external {}

    OnAddedToSceneInternal<native><override>(): void

    OnInitializedInternal<native><override>(): void

    OnRemovingFromSceneInternal<native><override>(): void

    OnUninitializingInternal<native><override>(): void

    @editable { EpicOnly := true }
    @display_name("Use IES Intensity")
    @category("Epic Internal")
    # If true, take light brightness from IES profile texture. If false, use the
    # light brightness. The maximum light in one direction is used to define no
    # masking. Will be disabled if a valid IES profile texture is not supplied.
    UseIESIntensity<epic_internal><native>: logic = external {}

    @editable_slider(float) { EpicOnly := true; MinValue := option { 0.000000 }; MaxValue := option { 4.000000 } }
    @category("Epic Internal")
    # Intensity of the volumetric scattering from this light
    VolumetricScatteringIntensity<epic_internal><native>: float = external {}

    # Whether the light should cast any shadows.
    var CastShadows<public>: logic = external {}

    # Set the filter color of the light. This acts as a colored filter in front
    # of the light source. Note that this can change the light's effective
    # intensity. In normalized range 0-1.
    var ColorFilter<public>: color = external {}

    # Multiplier on diffuse lighting. Any value besides 1.0 is not physical. 0.0
    # means no diffuse contribution from this light.
    var DiffuseScale<public>: float = external {}

    # Multiplier on specular highlights. Can be used to artistically remove
    # highlights mimicking polarizing filters or photo touch up. Any value
    # besides 1.0 is not physical. 0.0 means no specular contribution from
    # this light.
    var SpecularScale<public>: float = external {}
  }

  map_ready_component<epic_internal><native> := class<final_super>(component) {
    AddDependency<public><native_callable>(Event: sticky_event(comparable)): void = external {}

    MapReadyEvent<public>: sticky_event(comparable) = external {}
  }

  # Used to render a `mesh` at the location of this entity. A mesh is a set of
  # polygons that can be used to represent shapes in the world such as:
  #   * foliage and terrain decorations
  #   * movers (for example, doors and lifts)
  #   * procedurally created buildings
  #
  # Dependencies:
  #   * `transform_component` on the entity positions the mesh.
  mesh_component<public><native> := class<epic_internal><final_super>(
    component,
    enableable,
    bounded,
    property_changed_interface
  ) {
    @experimental
    @experimental_always_overridden
    # Cached bounds used when the owning entity is not initialized.
    CachedLocalBounds<epic_internal><native>: bounded_box = external {}

    @experimental
    @transient
    @available { MinUploadedAtFNVersion := 4100 }
    CollisionEnteredEvent<epic_internal><native>: listenable(generator(collision_hit)) = external {}

    @experimental
    @transient
    @available { MinUploadedAtFNVersion := 4100 }
    CollisionEvent<epic_internal><native>: listenable(generator(collision_hit)) = external {}

    @experimental
    @transient
    @available { MinUploadedAtFNVersion := 4100 }
    CollisionExitedEvent<epic_internal><native>: listenable(generator(collision_volume_pair)) = external {}

    # Disables rendering of this mesh.
    Disable<native><override>(): void

    # Enables rendering of this mesh.
    Enable<native><override>(): void

    @transient
    # Triggered at the beginning of each tick when another entity first overlaps
    # this entity.
    EntityEnteredEvent<public><native>: listenable(entity) = external {}

    @transient
    # Triggered at the beginning of each tick when another entity is no longer
    # overlapping this entity
    EntityExitedEvent<public><native>: listenable(entity) = external {}

    # Returns the bounded box of this component, in world space.
    GetBoundedGlobalBox<override><native>()<reads>: bounded_box

    # Returns the bounded box of this component, in local space.
    GetBoundedLocalBox<override><native>()<reads>: bounded_box

    # Get an array of the materials assigned to this mesh's slots.
    GetMaterials<epic_internal><native>()<transacts>: generator(material)

    @available { MinUploadedAtFNVersion := 4110 }
    @experimental
    # Get mesh_part's on this mesh_component.
    GetMeshParts<epic_internal><native>()<transacts>: []mesh_part

    @experimental
    GetRigidBody<epic_internal><native>()<transacts>: rigid_body

    # Succeeds if the component is enabled, fails if it's disabled.
    IsEnabled<native><override>()<transacts><decides>: void

    # The `mesh` to be rendered by this `mesh_component`.
    Mesh<epic_internal><native>: mesh = external {}

    OnAddedToSceneInternal<native><override>(): void

    OnBeginSimulationInternal<native><override>(): void

    OnEndSimulationInternal<native><override>(): void

    OnInitializedInternal<native><override>(): void

    OnPropertyChangedFromVerse<native><override>(PropertyName: string)<transacts>: void

    OnRemovingFromSceneInternal<native><override>(): void

    OnUninitializingInternal<native><override>(): void

    ___PropertyInterface_On_Collidable_Changed<epic_internal>(): void = external {}

    ___PropertyInterface_On_Queryable_Changed<epic_internal>(): void = external {}

    ___PropertyInterface_On_Visible_Changed<epic_internal>(): void = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Controls whether the mesh should influence indirect lighting.
    var AffectDynamicIndirectLighting<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Controls whether the mesh should affect indirect lighting when hidden.
    var AffectIndirectLightingWhileHidden<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether this component should be affected by lighting in channel 0.
    var AffectedByLightingChannel0<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether this component should be affected by lighting in channel 1.
    var AffectedByLightingChannel1<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether this component should be affected by lighting in channel 2.
    var AffectedByLightingChannel2<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether this component should cast contact shadows.
    var CastContactShadow<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # When enabled, the component will be rendering into the far shadow cascades
    # (only for directional lights).
    var CastFarShadow<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # If true, the mesh will cast shadows even if HiddenInGame is true.
    var CastHiddenShadow<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether this component should create a per-object shadow that gives higher
    # effective shadow resolution.
    var CastInsetShadow<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Controls whether this mesh should cast a shadow or not.
    var CastShadow<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether this mesh should cast dynamic shadows as if it were a two
    # sided material.
    var CastShadowAsTwoSided<epic_internal><native>: logic = external {}

    # Enable/disable collision on this mesh. If enabled, meshes may collide in
    # the physics simulation.
    var Collidable<public>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    @experimental
    # Minimum scalability `r.DetailMode` tier required to render this mesh. If
    # the current scalability tier is lower than this value, no render scene
    # proxy is created. Re-evaluated automatically when the player's quality
    # settings change.
    var DetailMode<epic_internal><native>: detail_mode = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    @experimental
    # Whether to hide this mesh in game, if the mesh is Visible.
    var HiddenInGame<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    @experimental
    # When enabled this mesh will never be culled by distance.
    var NeverDistanceCull<epic_internal><native>: logic = external {}

    # Enable/disable spatial queries against this mesh. Disabling this field
    # will also disable EntityEnteredEvent/EntityExitedEvent.
    var Queryable<public>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    @experimental
    # Whether this mesh should allow decals.
    var ReceivesDecals<epic_internal><native>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Controls the sort priority of this mesh if it is translucent.
    var TranslucencySortPriority<epic_internal><native>: int = external {}

    # Enable/disable visibility of this mesh.
    var Visible<public>: logic = external {}

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # If true, this component will be visible in ray traced reflections. Screen
    # space traces will ignore this flag, as they directly sample SceneColor
    var VisibleInReflections<epic_internal><native>: logic = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  mesh_part<epic_internal><native> := class<epic_internal><abstract><unique>(diagnosable) {
    @available { MinUploadedAtFNVersion := 4200 }
    ApplyShow<epic_internal><native>(NewShow: logic)<transacts>: void

    GetDiagnostic<override><native>()<reads>: diagnostic

    HasCollisionImpl<epic_internal><native>: has_collision_impl = external {}

    HasDynamicsImpl<epic_internal><native>: has_dynamics_impl = external {}

    @available { MinUploadedAtFNVersion := 4200 }
    HasOriginImpl<epic_internal><native>: has_origin_impl = external {}

    HasUEPhysicsPropertiesImpl<epic_internal><native>: has_ue_physics_properties_impl = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  mesh_part_collision_element<epic_internal><native> := class<epic_internal><concrete>(collision_element) {
    @experimental
    MeshParts<epic_internal><native>: []mesh_part = external {}
  }

  @experimental
  # The modular vehicle simulation component simulates vehicle behaviour
  modular_vehicle_component<epic_internal><native> := class<epic_internal><final_super>(component) {
    @experimental
    @available { MinUploadedAtFNVersion := 4100 }
    CollisionEnteredEvent<epic_internal><native>: listenable(generator(collision_hit)) = external {}

    @experimental
    @available { MinUploadedAtFNVersion := 4100 }
    CollisionEvent<epic_internal><native>: listenable(generator(collision_hit)) = external {}

    @experimental
    @available { MinUploadedAtFNVersion := 4100 }
    CollisionExitedEvent<epic_internal><native>: listenable(generator(collision_volume_pair)) = external {}

    @experimental
    ModuleAddedEvent<epic_internal><final><native>: listenable(module_info) = external {}

    @experimental
    ModuleRemovedEvent<epic_internal><final><native>: listenable(module_info) = external {}

    # Notification the owner entity was added to a world, create
    # vehicle implementation
    OnAddedToSceneInternal<native><override>(): void

    # Simulation starting, delayed construction possible
    OnBeginSimulationInternal<native><override>(): void

    # Simulation ending
    OnEndSimulationInternal<native><override>(): void

    # The component is being initialized, called when it is attached to
    # an entity
    OnInitializedInternal<native><override>(): void

    # Notification the owner entity is about to be removed from world, destroy
    # vehicle implementation
    OnRemovingFromSceneInternal<native><override>(): void

    # The component is being uninitialized, called when it is about to be
    # detached from an entity
    OnUninitializingInternal<native><override>(): void

    # Possess the vehicle proxy actor with the given player's controller.
    # Required for camera/view control.
    PossessProxyActor<epic_internal><native>(InPlayer: player): void

    # Apply control input of type MAxis3D
    SetInput<public><native>(InputName: string, Value: (/Verse.org/SpatialMath:)vector3): void

    # Apply control input of type MAxis1D
    SetInput<public><native>(InputName: string, Value: float): void

    # Apply control input of type MInteger
    SetInput<public><native>(InputName: string, Value: int): void

    # Apply control input of type MBoolean
    SetInput<public><native>(InputName: string, Value: logic): void

    # Apply state input of type MAxis3D
    SetState<public><native>(InputName: string, Value: (/Verse.org/SpatialMath:)vector3): void

    # Apply state input of type MAxis1D
    SetState<public><native>(InputName: string, Value: float): void

    # Apply state input of type MInteger
    SetState<public><native>(InputName: string, Value: int): void

    # Apply state input of type MBoolean
    SetState<public><native>(InputName: string, Value: logic): void

    # Replace the current control input configuration
    SetupControlInputConfiguration<public><native_callable>(
      ControlInputConfigurationIn: []vehicle_input_setup
    ): void = external {}

    # Replace the current state input configuration
    SetupStateInputConfiguration<public><native_callable>(
      StateInputConfigurationIn: []vehicle_input_setup
    ): void = external {}
  }

  @experimental
  modular_vehicle_input_component<epic_internal><native> := class<epic_internal><final_super>(component) {
    GetBrakePressedEvent<public>()<reads>: subscribable_event_intrnl(tuple()) = external {}

    GetGearDownPressedEvent<public>()<reads>: subscribable_event_intrnl(tuple()) = external {}

    GetGearUpPressedEvent<public>()<reads>: subscribable_event_intrnl(tuple()) = external {}

    GetHandbrakePressedEvent<public>()<reads>: subscribable_event_intrnl(tuple()) = external {}

    GetPitchPressedEvent<public>()<reads>: subscribable_event_intrnl(tuple()) = external {}

    GetRollPressedEvent<public>()<reads>: subscribable_event_intrnl(tuple()) = external {}

    GetSteeringPressedEvent<public>()<reads>: subscribable_event_intrnl(tuple()) = external {}

    GetThrottlePressedEvent<public>()<reads>: subscribable_event_intrnl(tuple()) = external {}

    GetYawPressedEvent<public>()<reads>: subscribable_event_intrnl(tuple()) = external {}

    OnEndSimulation<override>(): void = external {}

    OnPlayerAdded<public>(InPlayer: player): void = external {}

    OnPlayerRemoved<public>(InPlayer: player): void = external {}

    RegisterAllPlayerBindings<public>(): void = external {}

    UnregisterAllPlayerBindings<public>(): void = external {}
  }

  @experimental
  # Information about a module.
  module_info<epic_internal><native> := struct<epic_internal> {
    Entity<public><native>: entity

    SimComponent<public><native>: vehicle_sim_base_component
  }

  # Enumerated presets for the types of control input variable; Equates to what
  # enhanced input can provide
  module_input_value_type<public><native> := enum {
    MAxis1D

    MAxis2D

    MAxis3D

    MBoolean

    MInteger
  }

  @available { MinUploadedAtFNVersion := 4000 }
  mythic_rarity<epic_internal> := class<allocates>(legendary_rarity) {
    Color<override>: color = external {}
  }

  network_physics_settings_component<epic_internal><native> := class<epic_internal><final_super>(component) {
    @editable {}
    # The NetworkPhysicsSettingsData Asset to use for this entity
    var NetworkedPhysicsSettingsData<epic_internal><native>: network_physics_settings_data = external {}
  }

  null_component_query_iterator<epic_internal><native> := class<epic_internal>(component_query_iterator_interface) {
    NextValue<native><override>()<transacts><decides>: component
  }

  null_entity_query_iterator<epic_internal><native> := class<epic_internal>(entity_query_iterator_interface) {
    NextValue<native><override>()<transacts><decides>: entity
  }

  # Interface to provide alternative origin to an entity which is defaulted to
  # its parent. See `transform_component`
  origin<public><native> := interface<epic_internal> {
    GetTransform<public><native_callable>()<transacts>: (/Verse.org/SpatialMath:)transform
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Simple orthographic camera.
  orthographic_camera_component<public><native> := class<final_super>(camera_component) {
    @editable
    @replicated("")
    @experimental
    # Determines how wide the camera projects in orthographic mode,
    # in centimeters
    var OrthographicProjectionWidth<public><native>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  @hide_in_editor
  orthographic_camera_component_impl_modifier<epic_internal><native> := class<final>(camera_component_impl_modifier) {
    NativeEvaluate<override><native>(InValue: camera_state)<reads>: camera_state
  }

  # The results of an overlap query. See entity.FindOverlapHits(). We will get
  # one overlap_hit for each intersection of any volume in SourceVolumes with
  # any other volume.
  overlap_hit<public><native> := struct<epic_internal> {
    # The source component and volume (query input). For compound inputs (like
    # an entity hierarchy) this will be a component/volume in that hierarchy.
    # The SourceTransform is the transform of SourceVolume used for the overlap
    # test. For single volume inputs like a sphere, the Source volume and
    # transform are just the inputs to the overlap test, and the component
    # is false.
    SourceComponent<public><native>: ?component

    # The source volume transform
    SourceGlobalTransform<public><native>: (/Verse.org/SpatialMath:)transform

    # The source volume (query input)
    SourceVolume<public><native>: collision_volume

    # The component that was hit by SourceVolume
    TargetComponent<public><native>: component

    # The volume that was hit by SourceVolume
    TargetVolume<public><native>: collision_element
  }

  # Used to spawn a `particle_system` at the location of this entity. The
  # `particle_system` will simulate while the `particle_system_component` is in
  # the scene.
  #
  # Dependencies:
  #   * `transform_component` on the entity positions the `particle_system`.
  particle_system_component<public><native> := class<epic_internal><final_super>(
    component,
    enableable,
    property_changed_interface
  ) {
    # Disables the simulation and rendering of this `particle_system`.
    Disable<override><native>(): void

    # Enables the simulation and rendering of this `particle_system`.
    Enable<override><native>(): void

    # Succeeds if the component is enabled, fails if it’s disabled.
    IsEnabled<override><native>()<transacts><decides>: void

    OnAddedToSceneInternal<native><override>(): void

    OnBeginSimulationInternal<native><override>(): void

    OnInitializedInternal<native><override>(): void

    OnPropertyChangedFromVerse<native><override>(PropertyName: string)<transacts>: void

    OnRemovingFromSceneInternal<native><override>(): void

    OnUninitializingInternal<native><override>(): void

    ParticleSystem<epic_internal><native>: particle_system = external {}

    Play<public><native>(): void

    SetVariableArrayBool<epic_internal><native>(
      PropertyName: string,
      Values: []logic,
      MarkDirty: logic
    )<transacts>: void

    SetVariableArrayColor<epic_internal><native>(
      PropertyName: string,
      Values: []color,
      MarkDirty: logic
    )<transacts>: void

    SetVariableArrayFloat<epic_internal><native>(
      PropertyName: string,
      Values: []float,
      MarkDirty: logic
    )<transacts>: void

    SetVariableArrayInt32<epic_internal><native>(PropertyName: string, Values: []int, MarkDirty: logic)<transacts>: void

    SetVariableArrayPosition<epic_internal><native>(
      PropertyName: string,
      Values: [](/Verse.org/SpatialMath:)vector3,
      MarkDirty: logic
    )<transacts>: void

    SetVariableArrayVec2<epic_internal><native>(
      PropertyName: string,
      Values: []vector2,
      MarkDirty: logic
    )<transacts>: void

    SetVariableArrayVec3<epic_internal><native>(
      PropertyName: string,
      Values: [](/Verse.org/SpatialMath:)vector3,
      MarkDirty: logic
    )<transacts>: void

    SetVariableBool<epic_internal><native>(PropertyName: string, Value: logic, MarkDirty: logic)<transacts>: void

    SetVariableColor<epic_internal><native>(PropertyName: string, Value: color, MarkDirty: logic)<transacts>: void

    SetVariableEntity<epic_internal><native>(PropertyName: string, Value: ?entity, MarkDirty: logic)<transacts>: void

    SetVariableFloat<epic_internal><native>(PropertyName: string, Value: float, MarkDirty: logic)<transacts>: void

    SetVariableInt32<epic_internal><native>(PropertyName: string, Value: int, MarkDirty: logic)<transacts>: void

    SetVariableMaterial<epic_internal><native>(
      PropertyName: string,
      Value: ?material,
      MarkDirty: logic
    )<transacts>: void

    SetVariablePosition<epic_internal><native>(
      PropertyName: string,
      Value: (/Verse.org/SpatialMath:)vector3,
      MarkDirty: logic
    )<transacts>: void

    SetVariableTexture<epic_internal><native>(PropertyName: string, Value: ?texture, MarkDirty: logic)<transacts>: void

    SetVariableVec2<epic_internal><native>(PropertyName: string, Value: vector2, MarkDirty: logic)<transacts>: void

    SetVariableVec3<epic_internal><native>(
      PropertyName: string,
      Value: (/Verse.org/SpatialMath:)vector3,
      MarkDirty: logic
    )<transacts>: void

    Stop<public><native>(): void

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Should the niagara component tick pre (default) or post physics?
    TickPostPhysicsInternal<epic_internal><native>: logic = external {}

    @editable
    @replicated("")
    # Controls if the `particle_system_component` should play the simulation
    # automatically when added to the scene, or when enabled from a
    # disabled state.
    var<private> AutoPlay<public><native>: logic = external {}

    @editable
    @replicated("RepNotify")
    # Controls if the `particle_system_component` should start enabled.
    var<private> Enabled<public><native>: logic = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Simple perspective camera.
  perspective_camera_component<public><native> := class<final_super>(camera_component) {
    @editable
    @replicated("")
    @experimental
    # Horizontal field of view in degrees, specified for an aspect ratio of 16:9
    # /nThis is then to calculate an effective horizontal field of view for the
    # display’s real aspect ratio /nIf for example the screen is an ultrawide
    # (21:9, or 32:9 being common ultrawide aspect ratios) then in practice the
    # actual field of view will be wider. This is known as the Hor+ view scaling
    # method and is generally accepted to be the best solution for
    # ultrawide displays.
    var FieldOfViewDegrees<public><native>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  @hide_in_editor
  perspective_camera_component_impl_modifier<epic_internal><native> := class<final>(camera_component_impl_modifier) {
    NativeEvaluate<override><native>(InValue: camera_state)<reads>: camera_state
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  # Camera that is physically based, determining its view properties in a manner
  # more consistent with a physical camera
  physical_camera_component<public><native> := class<final_super>(camera_component) {
    OnInitializedInternal<native><override>(): void

    OnUninitializingInternal<native><override>(): void

    @experimental
    # Camera’s body settings.
    #  This contains sensor settings, e.g. film or digital camera sensor,
    #  shutter speed, etc
    var Body<public>: camera_body = external {}

    @experimental
    # Lens of the camera
    var Lens<public>: camera_lens = external {}
  }

  @available { MinUploadedAtFNVersion := 4110 }
  @experimental
  @hide_in_editor
  physical_camera_component_impl_modifier<epic_internal><native> := class<final>(camera_component_impl_modifier) {
    NativeEvaluate<override><native>(InValue: camera_state)<reads>: camera_state
  }

  @experimental
  physics_component<epic_internal><native> := class<final><final_super>(component, enableable) {
    # Disable this object.
    Disable<native><override>(): void

    # Enable this object.
    Enable<native><override>(): void

    @experimental
    # Event signaled when the component experiences a blocking hit
    HitEvent<public><native>: listenable(hit_result) = external {}

    # Succeeds if the component is enabled, fails if it’s disabled.
    IsEnabled<native><override>()<transacts><decides>: void

    OnAddedToSceneInternal<native><override>(): void

    OnInitializedInternal<native><override>(): void

    OnRemovingFromSceneInternal<native><override>(): void

    OnUninitializingInternal<native><override>(): void
  }

  @hide_in_editor
  physics_replication_component<epic_internal><native> := class<epic_internal><final_super>(component) {
    OnAddedToSceneInternal<native><override>(): void

    OnBeginSimulationInternal<native><override>(): void

    OnEndSimulationInternal<native><override>(): void

    OnInitializedInternal<native><override>(): void

    OnRemovingFromSceneInternal<native><override>(): void

    OnUninitializingInternal<native><override>(): void

    @replicated("RepNotify")
    var VerseReplicatedMovement<epic_internal><native>: VerseRepMovement = external {}
  }

  physics_scene_component<epic_internal><native> := class<epic_internal><final><final_super>(component) {
    FindEntityOverlaps<public><native>(
      QueryEntity: entity,
      QueryTransform: (/Verse.org/SpatialMath:)transform
    )<transacts>: generator(overlap_hit)

    FindEntitySweepHits<public><native>(
      QueryEntity: entity,
      QueryTransform: (/Verse.org/SpatialMath:)transform,
      QueryTraceVector: (/Verse.org/SpatialMath:)vector3
    )<transacts>: generator(sweep_hit)

    FindShapeOverlaps<public><native>(
      QueryShape: collision_volume,
      QueryTransform: (/Verse.org/SpatialMath:)transform
    )<transacts>: generator(overlap_hit)

    FindShapeSweepHits<public><native>(
      QueryShape: collision_volume,
      QueryTransform: (/Verse.org/SpatialMath:)transform,
      QueryTraceVector: (/Verse.org/SpatialMath:)vector3
    )<transacts>: generator(sweep_hit)

    OnAddedToSceneInternal<native><override>(): void

    OnInitializedInternal<native><override>(): void

    OnRemovingFromSceneInternal<native><override>(): void

    OnUninitializingInternal<native><override>(): void
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  play_skeletal_animation_result<public> := struct<epic_internal> {
    # The skeletal_animation that was played
    Animation: skeletal_animation

    # An easeable interface used to control blending
    Easeable: easeable
  }

  # Computes per-client Custom Primitive Data for the sibling mesh_component,
  # letting each client render a different value for a CPD-bound
  # material parameter.
  player_primitive_data_component<epic_internal><native> := class<final_super>(component) {
    @transient
    # Subscribe to set the sibling mesh's custom primitive data per local
    # player. The server triggers it with InvalidatePlayerPrimitiveData.
    ComputePlayerPrimitiveDataEvent<epic_internal><native>: listenable(player_primitive_data_context) = external {}

    # Triggers ComputePlayerPrimitiveDataEvent on each client, once per local
    # player, passing UserData to the callbacks.
    InvalidatePlayerPrimitiveData<epic_internal>(UserData: player_primitive_data_payload): void = external {}
  }

  @hide_in_editor
  # Marks an entity that can be possessed by an agent.
  possessable_component<public><native> := class<epic_internal><final_super>(component) {
    # Notify when the possessing agent changes.
    AgentChangeEvent<epic_internal><final><native>: listenable(agent_changed_result) = external {}

    # Internal function to call when possessing for updating status and
    # triggering the AgentChangeEvent.
    BeginPossess<epic_internal><final>(NewPossessingAgent: agent)<transacts>: void = external {}

    # Entity's opinion on whether it can be possessed by a specific agent.
    #  By default it fails if the entity is already possessed.
    CanBePossessedBy<epic_internal><native_callable>(AgentToCheck: agent)<decides><reads>: void = external {}

    # Internal function to call when unpossessing for updating status and
    # triggering the AgentChangeEvent.
    EndPossess<epic_internal><final>()<transacts>: void = external {}

    OnEndSimulation<override>(): void = external {}

    # Signals the AgentChangeEvent.
    SignalAgentChangeEvent<epic_internal><final>(PreviousAgent: ?agent)<transacts>: void = external {}

    # Internal function that signals the AgentChangeEvent.
    SignalAgentChangeEventInternal<epic_internal><final><native>(
      AgentChangedResult: agent_changed_result
    )<transacts>: void

    # Which agent is this entity currently possessed by.
    var<private> Agent<public><final><native>: ?agent = external {}
  }

  presentation_component<epic_internal><native> := class<final_super>(component) {}

  @available { MinUploadedAtFNVersion := 4200 }
  @experimental
  # Positions an entity at a named bone or socket on another entity's
  # mesh.Assign this as the `Origin` of a `transform_component` to have an
  # entity follow a socket/bone.
  presentation_origin<epic_internal><native> := class(origin) {
    GetTransform<override><native>()<transacts>: (/Verse.org/SpatialMath:)transform

    @replicated("")
    SocketName<epic_internal><native>: string

    @replicated("")
    var MeshEntity<epic_internal><native>: ?entity = external {}
  }

  @available { MinUploadedAtFNVersion := 4240 }
  @experimental
  # Follows the skeletal animation of another entity's animation source, so e.g.
  # this mesh follows another mesh. SourceEntity's skeletal-animation stack
  # output is republished as this stack's incoming skeleton.
  proxy_skeleton_modifier<epic_internal><native> := class<epic_internal><final>(
    proxy_skeleton_modifier_base,
    modifier(skeleton)
  ) {
    Evaluate<native><override>(InValue: skeleton)<reads>: skeleton

    @editable
    # The retargeting method applied to the followed skeletal animation. Unset
    # means plain remapping.
    var RetargetMethod<epic_internal><native>: ?skeletal_animation_retarget_method = external {}

    @editable
    @replicated("RepNotify")
    # The entity whose skeletal animation to follow. While unset or unresolved,
    # this mesh stays on its reference pose.
    var SourceEntity<epic_internal><native>: ?entity = external {}
  }

  @import_as("/Script/EntitySkeletalAnimation.UEntityProxySkeletonModifierBase")
  proxy_skeleton_modifier_base<epic_internal><native> := class<epic_internal> {}

  @available { MinUploadedAtFNVersion := 4000 }
  rare_rarity<public> := class<allocates>(uncommon_rarity) {
    Color<override>: color = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Rarity may be used by gameplay and presentation systems to classify and
  # rank things.
  rarity<public><native> := class<castable><concrete><unique><allocates> {
    @editable
    Color<public><native>: color = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # Component that denotes the rarity of an entity.
  rarity_component<public><native> := class<final_super>(component) {
    GetRarity<epic_internal><native>(__dupe___unnamed_parameter_0: accessor)<transacts>: rarity

    OnBeginSimulation<override>(): void = external {}

    OnEndSimulation<override>(): void = external {}

    SetRarity<epic_internal><native>(__dupe___unnamed_parameter_0: accessor, InRarity: rarity)<transacts>: void

    # The rarity of this entity. An entity can have only one rarity.
    var Rarity<public>: rarity = external {}

    var<private> HasChangedFields<epic_internal><native>: logic = external {}
  }

  # A `rect_light_component` emits light into the scene from a rectangular plane
  # with a specified width and height. You can use these to simulate any kind of
  # light sources that have rectangular areas, such as televisions or monitor
  # screens, overhead lighting fixtures, or wall sconces.
  rect_light_component<public><native> := class<final>(light_component, bounded) {
    # Returns the bounded box of this component, in world space.
    GetBoundedGlobalBox<override><native>()<reads>: bounded_box

    # Returns the bounded box of this component, in local space.
    GetBoundedLocalBox<override><native>()<reads>: bounded_box

    OnAddedToSceneInternal<native><override>(): void

    # The bounds of the light's visible influence, in centimeters. This clamping
    # of the light's influence is not physically correct but very important for
    # performance, larger lights cost more. The light falloff is based on
    # Inverse Square law. Towards the tail end of the AttenuationRadius, there
    # is an additional smoothing factor to fade out the light contribution to 0
    # to avoid a hard cutoff.
    var AttenuationRadius<public>: ?float = external {}

    # The angle of the barn door in degrees attached to the light source rect.
    # Clamped between 0.0 and 90.0 degrees.
    var BarnDoorAngleDegrees<public>: float = external {}

    # The length of the barn door attached to the light source rect,
    # in centimeters.
    var BarnDoorLength<public>: float = external {}

    # Set the visible light intensity emitted in SI unit Candela.
    # Specified before ColorFilter (which multiplies each color component after
    # the intensity calculation and can change the effective intensity of
    # the light).
    var Intensity<public>: float = external {}

    # The height of the light source rect, in centimeters. Note that light
    # source's shapes which intersect shadow casting geometry can cause
    # shadowing artifacts.
    var SourceHeight<public>: float = external {}

    # The width of the light source rect, in centimeters. Note that light source
    # shapes which intersect shadow casting geometry can cause
    # shadowing artifacts.
    var SourceWidth<public>: float = external {}
  }

  replication_component<epic_internal><native> := class<final_super>(component) {
    @category("Epic Internal")
    @editable
    # Internal only - Flag to make this entity always relevant for replication
    # to clients
    AlwaysRelevant<epic_internal><native>: logic = external {}

    ClearNetCullDistanceOverride<epic_internal><native>()<transacts>: void

    @category("Epic Internal")
    @editable
    # Internal only - Flag to enable or disable replication
    EnableReplication<epic_internal><native>: logic = external {}

    OnAddedToSceneInternal<native><override>(): void

    OnBeginSimulationInternal<native><override>(): void

    OnEndSimulationInternal<native><override>(): void

    OnRemovingFromSceneInternal<native><override>(): void

    SetNetCullDistanceOverride<epic_internal><native>(Override: float)<transacts>: void

    var NetCullDistance<epic_internal>: float = external {}
  }

  rigid_body<epic_internal><native> := class<final> {
    AddAngularImpulse<public><native>(AngularImpulseVector: (/Verse.org/SpatialMath:)vector3)<transacts>: void

    AddLinearImpulse<public><native>(LinearImpulseVector: (/Verse.org/SpatialMath:)vector3)<transacts>: void

    var AngularVelocity<public>: (/Verse.org/SpatialMath:)vector3 = external {}

    var GlobalMassTranslation<public>: (/Verse.org/SpatialMath:)vector3 = external {}

    var GlobalRotation<public>: (/Verse.org/SpatialMath:)rotation = external {}

    var GlobalTranslation<public>: (/Verse.org/SpatialMath:)vector3 = external {}

    var Inertia<public>: (/Verse.org/SpatialMath:)vector3 = external {}

    var IsDynamic<public>: logic = external {}

    var LinearVelocity<public>: (/Verse.org/SpatialMath:)vector3 = external {}

    var LocalMassRotation<public>: (/Verse.org/SpatialMath:)rotation = external {}

    var LocalMassTranslation<public>: (/Verse.org/SpatialMath:)vector3 = external {}

    var Mass<public>: float = external {}
  }

  @hide_in_editor
  @experimental
  rigid_body_component<epic_internal><native> := class<epic_internal><final><final_super>(component) {
    OnAddedToSceneInternal<native><override>(): void

    OnBeginSimulationInternal<native><override>(): void

    OnEndSimulationInternal<native><override>(): void

    OnInitializedInternal<native><override>(): void

    OnRemovingFromSceneInternal<native><override>(): void

    OnUninitializingInternal<native><override>(): void

    @experimental
    # Enable/Disable simulation of this body.
    var Dynamic<public>: logic = external {}

    @experimental
    @editable
    # The gravity group index to use for component.
    var GravityGroupIndex<public>: int = external {}

    @experimental
    @editable
    # The mass to use for component.
    var MassInKg<public>: float = external {}

    @experimental
    @editable
    # The max angular velocity to use for component.
    var MaxAngularVelocityInRadians<public>: float = external {}
  }

  rotator_quantization<epic_internal><native> := enum<open> {
    ByteComponents

    ShortComponents
  }

  # An event which can be sent through the scene graph.
  scene_event<public><native> := interface {}

  @hide_in_editor { CVar := "SimulationEntity.AllowCustomSimulationEntities"; Hidden := false }
  simulation_entity<epic_internal><native> := class<concrete><unique><transacts>(entity) {}

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  # A modifier of skeletons, used to animate meshes using skeletal animation
  skeletal_animation<public><native> := class<epic_internal><castable>(skeletal_animation_base, modifier(skeleton)) {
    @replicated("")
    # Controls if the `skeletal_animation` should play automatically
    # when created.
    AutoPlay<epic_internal><native>: logic = external {}

    BeginTime<epic_internal><native>: float = external {}

    EndTime<epic_internal><native>: float = external {}

    Evaluate<native><override>(InValue: skeleton)<reads>: skeleton

    # Get this animation's lifetime, in seconds.Fails if an animation has an
    # indefinite duration (i.e. it is not possible at the point of the call to
    # tell how long the animation is)Animations can be of infinite length (such
    # as a looping animation)
    GetDuration<epic_internal><native_callable>()<decides><reads>: float = external {}

    GetIsLooping<epic_internal><native_callable>()<reads>: logic = external {}

    GetSeconds<epic_internal><native>()<reads>: float

    @replicated("RepNotify")
    InternalAsset<epic_internal><native>: animation_asset = external {}

    Pause<epic_internal><native>()<transacts>: void

    PauseEvent<epic_internal><native>: listenable(tuple()) = external {}

    Play<epic_internal><native>()<transacts>: void

    PlayEvent<epic_internal><native>: listenable(tuple()) = external {}

    # Get a listenable event that will fire Offset seconds before this animation
    # finishes.This can be useful for triggering crossfades as animations
    # naturally finishFails if this animation has an indefinite duration (i.e.
    # it is not possible at the point of the call to tell how long the animation
    # is)If this animation has an infinite duration, then this event will
    # never fire.
    PreFinishEvent<epic_internal><native>(Offset: float)<transacts><decides>: listenable(tuple())

    SetProperty<epic_internal><native>(PropertyName: string, NewValue: any)<transacts>: void

    Stop<epic_internal><native>()<transacts>: void

    StopEvent<epic_internal><native>: listenable(tuple()) = external {}

    var<private> IsPlaying<epic_internal><native>: logic = external {}
  }

  @import_as("/Script/EntitySkeletalAnimation.UEntitySkeletalAnimationBase")
  skeletal_animation_base<epic_internal><native> := class<epic_internal> {}

  @experimental
  # A method used to retarget skeletal animation between different skeletons.
  # Unset on a proxy_skeleton_modifier means plain remapping.
  skeletal_animation_retarget_method<epic_internal><native> := class<epic_internal><abstract>(
    skeletal_animation_retarget_method_base
  ) {}

  @import_as("/Script/EntitySkeletalAnimation.USkeletalAnimationRetargetMethodBase")
  skeletal_animation_retarget_method_base<epic_internal><native> := class<epic_internal> {}

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  # Skeletons are collections of bones & sets/chains
  skeleton<public><native> := class<epic_internal> {}

  slow_component_array_copy_query_iterator<epic_internal><native> := class<epic_internal>(
    component_query_iterator_interface
  ) {
    NextValue<native><override>()<transacts><decides>: component
  }

  slow_entity_array_copy_query_iterator<epic_internal><native> := class<epic_internal>(
    entity_query_iterator_interface
  ) {
    NextValue<native><override>()<transacts><decides>: entity
  }

  @experimental
  @hide_in_editor
  # Used to attach entities to a socket on an actor.
  socket_origin<epic_internal><native> := class(actor_origin) {
    @editable
    @replicated("")
    var SocketName<public><native>: string
  }

  sound_component<public><native> := class<epic_internal><final_super><abstract>(
    component,
    property_changed_interface,
    enableable
  ) {
    # Disable the sound component.
    Disable<override><native>(): void

    # Enable the sound component.
    Enable<override><native>(): void

    # The path to the sound asset
    InternalMetaSoundAssetPath<epic_internal><native>: metasound = external {}

    # Succeeds if the sound component is enabled, fails if it is disabled.
    IsEnabled<override><native>()<transacts><decides>: void

    OnAddedToSceneInternal<native><override>(): void

    OnBeginSimulationInternal<native><override>(): void

    OnInitializedInternal<native><override>(): void

    OnPropertyChangedFromVerse<native><override>(PropertyName: string)<transacts>: void

    OnRemovingFromSceneInternal<native><override>(): void

    OnUninitializingInternal<native><override>(): void

    # Play the sound asset
    Play<public><native>(): void

    # Stop the sound asset
    Stop<public><native>(): void

    @editable
    @replicated("")
    var<private> AutoPlay<public><native>: logic = external {}

    @editable
    @replicated("RepNotify")
    var<private> Enabled<public><native>: logic = external {}
  }

  # A `sphere_light_component` emits light in all directions into the scene from
  # a spherical source shape with a specified radius. A radius of 0 makes it a
  # point light. You can use these to simulate any kind of light sources that
  # emit in all directions, such as a light bulb.
  sphere_light_component<public><native> := class<final>(light_component, bounded) {
    # Returns the bounded box of this component, in world space.
    GetBoundedGlobalBox<override><native>()<reads>: bounded_box

    # Returns the bounded box of this component, in local space.
    GetBoundedLocalBox<override><native>()<reads>: bounded_box

    @editable_slider(float) { EpicOnly := true; MinValue := option { 2.000000 }; MaxValue := option { 16.000000 } }
    @category("Epic Internal")
    # Controls the radial falloff of the light when UseInverseSquaredFalloff
    # is disabled
    LightFalloffExponent<epic_internal><native>: float = external {}

    OnAddedToSceneInternal<native><override>(): void

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether to use physically based inverse squared distance falloff
    UseInverseSquaredFalloff<epic_internal><native>: logic = external {}

    # The bounds of the light's visible influence, in centimeters. This clamping
    # of the light's influence is not physically correct but very important for
    # performance, larger lights cost more. The light falloff is based on
    # Inverse Square law. Towards the tail end of the AttenuationRadius, there
    # is an additional smoothing factor to fade out the light contribution to 0
    # to avoid a hard cutoff.
    var AttenuationRadius<public>: ?float = external {}

    # Set the visible light intensity emitted in SI unit Candela.
    # Specified before ColorFilter (which multiplies each color component after
    # the intensity calculation and can change the effective intensity of
    # the light).
    var Intensity<public>: float = external {}

    # Radius of the source shape, in centimeters. Note that light shapes which
    # intersect shadow casting geometry can cause shadowing artifacts.
    var SourceRadius<public>: float = external {}
  }

  # A `spot_light_component` emits light from a single point in a cone shape.
  # The shape of the light is defined by two cones: the `InnerConeAngleDegrees`
  # and `OuterConeAngleDegrees`. Within the `InnerConeAngleDegrees` the light
  # achieves full brightness. As you go from the extent of the inner radius to
  # the extents of the `OuterConeAngleDegrees` a falloff takes place, creating a
  # penumbra, or softening around the `spot_light_component`'s disc of
  # illumination. The Radius of the light defines the length of the cones. More
  # simply, this will work like a flash light or stage can light.
  spot_light_component<public><native> := class<final>(light_component, bounded) {
    # Returns the bounded box of this component, in world space.
    GetBoundedGlobalBox<override><native>()<reads>: bounded_box

    # Returns the bounded box of this component, in local space.
    GetBoundedLocalBox<override><native>()<reads>: bounded_box

    @editable_slider(float) { EpicOnly := true; MinValue := option { 2.000000 }; MaxValue := option { 16.000000 } }
    @category("Epic Internal")
    # Controls the radial falloff of the light when UseInverseSquaredFalloff
    # is disabled
    LightFalloffExponent<epic_internal><native>: float = external {}

    OnAddedToSceneInternal<native><override>(): void

    @editable { EpicOnly := true }
    @category("Epic Internal")
    # Whether to use physically based inverse squared distance falloff
    UseInverseSquaredFalloff<epic_internal><native>: logic = external {}

    # The bounds of the light's visible influence, in centimeters. This clamping
    # of the light's influence is not physically correct but very important for
    # performance, larger lights cost more. The light falloff is based on
    # Inverse Square law. Towards the tail end of the AttenuationRadius, there
    # is an additional smoothing factor to fade out the light contribution to 0
    # to avoid a hard cutoff.
    var AttenuationRadius<public>: ?float = external {}

    # The light's inner cone shaped angle in degrees. Clamped between 0.0
    # and 80.0.
    var InnerConeAngleDegrees<public>: float = external {}

    # Set the visible light intensity emitted in SI unit Candela.
    # Specified before ColorFilter (which multiplies each color component after
    # the intensity calculation and can change the effective intensity of
    # the light).
    var Intensity<public>: float = external {}

    # The light's outer cone shaped angle in degrees. Clamped between 1.0
    # and 80.0.
    var OuterConeAngleDegrees<public>: float = external {}

    # Radius of the source shape, in centimeters. Note that light shapes which
    # intersect shadow casting geometry can cause shadowing artifacts.
    var SourceRadius<public>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4000 }
  # A component that when attached to an entity allows for it to merge or
  # 'stack' with other entities with compatible components.
  stackable_component<public><native> := class<final_super><abstract>(component) {
    # Succeeds if this entity can be merged into the target entity. Merging an
    # entity with itself will always fail. Note that merging should be checked
    # in both directions!
    CanMergeInto<public><native_callable>(TargetEntity: entity)<decides><reads>: void = external {}

    CanMergeIntoInternal<epic_internal><final><native>(TargetEntity: entity)<reads>: ?logic

    ChangeMaxStackSizeEvent<public><final><native>: listenable(change_max_stack_size_result) = external {}

    ChangeStackSizeEvent<public><final><native>: listenable(change_stack_size_result) = external {}

    # Attempts to merge this entity into the specified entity. Fails if entities
    # cannot be merged.
    #  If TargetAmount is specified, only that amount will try to be merged into
    #  this entity. By default, the entire stack will try to merge.
    #  If the specified amount is invalid, the merge will fail.
    MergeInto<public><native_callable>(
      TargetEntity: entity,
      ?TargetAmount: ?int = external {}
    )<transacts><decides>: void = external {}

    MergeIntoInternal<epic_internal><final><native>(TargetEntity: entity, TargetAmount: int)<transacts><decides>: int

    OnBeginSimulation<override>(): void = external {}

    OnEndSimulation<override>(): void = external {}

    # Sets the maximum stack size for this component. If NewMaxStackSize is
    # false, stack size is unlimited. If ClampStackSize is true, StackSize will
    # be clamped to NewMaxStackSize.
    SetMaxStackSize<public><final><native>(NewMaxStackSize: ?int, ?ClampStackSize: logic = external {})<transacts>: void

    # Sets the stack size of this component. If the provided stack size is
    # invalid, e.g. negative or exceeding MaxStackSize, stack size will
    # not change.
    SetStackSize<public><final><native>(NewStackSize: int)<transacts>: void

    Split<public><native_callable>(Amount: int)<transacts><decides>: entity

    var<private> HasChangedFields<epic_internal><native>: logic = external {}

    @replicated("RepNotify")
    @editable
    # The maximum amount this component can hold. If unset, it holds an
    # unlimited amount.
    var<private> MaxStackSize<public><native>: ?int = external {}

    @replicated("RepNotify")
    @editable_number(int) { MinValue := option { 1 } }
    # The current amount of this entity held in the stack.
    var<private> StackSize<public><native>: int = external {}
  }

  @experimental
  streaming_component<epic_internal><native> := class<final_super>(component) {
    @editable
    # Determines how the entity will stream its children on clients.
    ChildrenStreamingPolicy<epic_internal><native>: ?children_streaming_policy = external {}

    @editable
    # Determines how the entity will be streamed on clients with regards to
    # its parent.
    EntityStreamingPolicy<epic_internal><native>: ?entity_streaming_policy = external {}

    @editable
    # Determines the streaming distance at which the entity will be loaded on
    # clients, in meters.
    StreamingDistance<epic_internal><native>: ?float = external {}
  }

  # The results of a sweep query. See entity.FindSweepHits(). We will get one
  # sweep_hit for each intersection of any volume in SourceVolumes with any
  # other volume.
  sweep_hit<public><native> := struct<epic_internal> {
    # If TargetVolume is a polygonal object (mesh, convex hull, etc.) and the
    # contact point is on an edge or vertex, this is the most-opposing face
    # normal of the faces that share that edge or vertex. Otherwise it is the
    # same as HitNormal.
    ContactFaceNormal<public><native>: (/Verse.org/SpatialMath:)vector3 = external {}

    # The normal on TargetVolume at the HitPosition.
    ContactNormal<public><native>: (/Verse.org/SpatialMath:)vector3 = external {}

    # The point of contact between SourceVolume and TargetVolume.
    ContactPosition<public><native>: (/Verse.org/SpatialMath:)vector3 = external {}

    # The source component and volume (query input). For compound inputs (like
    # an entity hierarchy) this will be a component/volume in that hierarchy.
    # The SourceGlobalTransform is the transform of SourceVolume at the start of
    # the sweep. For single volume inputs like a sphere, the volume and
    # transform are just the inputs to the sweep, and the component is false.
    SourceComponent<public><native>: ?component

    # The Distance along the sweep at which SourceVolume touches TargetVolume.
    SourceHitDistance<public><native>: float = external {}

    # The world-space translation (relative to SourceStartGlobalTransform) of
    # SourceVolume when it touches TargetVolume.
    SourceHitTranslation<public><native>: (/Verse.org/SpatialMath:)vector3 = external {}

    # The source volume transform at the start of the sweep.
    SourceStartGlobalTransform<public><native>: (/Verse.org/SpatialMath:)transform

    # The source volume (query input).
    SourceVolume<public><native>: collision_volume

    # The component that was hit by SourceVolume.
    TargetComponent<public><native>: component

    # The volume that was hit by SourceVolume.
    TargetVolume<public><native>: collision_element
  }

  @experimental
  # Used to render a string at the location of this entity.
  #
  # Dependencies:
  #   * `transform_component` on the entity positions
  #     the `text_display_component`.
  text_display_component<epic_internal><native> := class<final_super>(component, enableable) {
    # Disable this object.
    Disable<native><override>(): void

    # Enable this object.
    Enable<native><override>(): void

    # Succeeds if the component is enabled, fails if it is disabled.
    IsEnabled<native><override>()<transacts><decides>: void

    OnAddedToSceneInternal<native><override>(): void

    OnInitializedInternal<native><override>(): void

    OnRemovingFromSceneInternal<native><override>(): void

    @editable
    @replicated("RepNotify")
    # The color with which to display the text.
    var Color<public><native>: color = external {}

    @editable
    @replicated("RepNotify")
    # The time in seconds for the text to fully fade in.
    var FadeInTime<epic_internal><native>: float = external {}

    @editable
    @replicated("RepNotify")
    # The time in seconds for the text to fully fade out.
    var FadeOutTime<epic_internal><native>: float = external {}

    @experimental
    @editable
    @replicated("RepNotify")
    # Message to be displayed on the entity.
    var Message<public><native>: message = external {}
  }

  # Describes discrete phases of a frame update. Subscribe to members of the
  # tick_events object to run code before or after the physics system has
  # updated your object, allowing you to affect or react to these updates.
  tick_events<public><native> := class<epic_internal> {
    DuringPhysics<epic_internal><native>: execution_listenable = external {}

    EndFrame<epic_internal><native>: execution_listenable = external {}

    EndPhysics<epic_internal><native>: execution_listenable = external {}

    # Listen `PostPhysics` to run your code after the physics system has updated
    # your object this frame.
    PostPhysics<public><native>: execution_listenable = external {}

    # Listen `PrePhysics` to run your code before the physics system has updated
    # your object this frame.
    PrePhysics<public><native>: execution_listenable = external {}

    StartPhysics<epic_internal><native>: execution_listenable = external {}
  }

  transform_bridge_offset_info<epic_internal><native> := struct {}

  # Implemented by components that want to offset the entity transform from the
  # actor transform mirrored by a transform_component_bridge.
  transform_bridge_offset_interface<epic_internal><native> := interface<epic_internal> {
    # Returns the world space translation to add to the actor transform to
    # produce the entity transform, or false if this component doesn't
    # contribute an offset.
    GetTransformOffset<protected><native_callable>(
      Info: transform_bridge_offset_info
    )<reads>: ?(/Verse.org/SpatialMath:)vector3
  }

  # Stores the transforms for an entity, which are used to position the entity.
  transform_component<public><native> := class<final><final_super>(component) {
    OnInitializedInternal<native><override>(): void

    OnUninitializingInternal<native><override>(): void

    # Current transform of the entity, globally referenced. Any value set at
    # construction will be overrridden with the calculation from the
    # Local Transform
    var GlobalTransform<public>: (/Verse.org/SpatialMath:)transform = external {}

    # LocalTransform to its parent/origin
    var LocalTransform<public>: (/Verse.org/SpatialMath:)transform = external {}

    # alternate origin than the default parent entity
    var Origin<public>: ?origin = external {}
  }

  @display_name("Translation Retarget")
  @experimental
  # Retargets bone translations using the per-bone retarget modes authored on
  # the target skeleton.
  translation_retarget_method<epic_internal><native> := class<epic_internal><final>(
    skeletal_animation_retarget_method
  ) {}

  @available { MinUploadedAtFNVersion := 4100 }
  @replicatable
  ue_collision_material<epic_internal><native> := struct<epic_internal> {
    DynamicFriction<native>: float = external {}

    FrictionCombineMode<native>: ue_phys_mat_combine_mode = external {}

    Restitution<native>: float = external {}

    RestitutionCombineMode<native>: ue_phys_mat_combine_mode = external {}

    SleepCounterThreshold<native>: int = external {}

    SleepingAngularThreshold<native>: float = external {}

    SleepingLinearThreshold<native>: float = external {}

    StaticFriction<native>: float = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  ue_phys_mat_combine_mode<epic_internal><native> := enum<open> {
    EAvg

    EMax

    EMin

    EMultiply
  }

  @available { MinUploadedAtFNVersion := 4100 }
  ue_phys_sleep_type<epic_internal><native> := enum<open> {
    MaterialSleep

    NeverSleep
  }

  @available { MinUploadedAtFNVersion := 4000 }
  uncommon_rarity<public> := class<allocates>(common_rarity) {
    Color<override>: color = external {}
  }

  # The component responsible for managing Networked Physics Replication
  # for entities.
  vector_quantization<epic_internal><native> := enum<open> {
    RoundOneDecimal

    RoundTwoDecimals

    RoundWholeNumber
  }

  @experimental
  vehicle_aerofoil_component<epic_internal><native> := class<epic_internal><final>(vehicle_sim_base_component) {}

  @experimental
  vehicle_clutch_component<epic_internal><native> := class<epic_internal><final>(vehicle_sim_base_component) {}

  @experimental
  vehicle_engine_component<epic_internal><native> := class<epic_internal><final>(vehicle_sim_base_component) {
    GetRPM<epic_internal>(Accessor: accessor)<transacts>: float = external {}

    GetTorque<epic_internal>(Accessor: accessor)<transacts>: float = external {}
  }

  @experimental
  # Defines each of the vehicle control inputs that the individual module
  # simulations are looking for
  vehicle_input_setup<epic_internal><native> := struct<epic_internal> {
    InputDecay<public><native>: logic = external {}

    InputName<public><native>: string = external {}

    InputType<public><native>: module_input_value_type = external {}
  }

  @hide_in_editor
  @experimental
  vehicle_sim_base_component<epic_internal><native> := class<epic_internal><final_super>(component) {}

  @experimental
  vehicle_suspension_component<epic_internal><native> := class<epic_internal><final>(vehicle_sim_base_component) {
    GetImpactNormal<epic_internal>(Accessor: accessor)<transacts>: (/Verse.org/SpatialMath:)vector3 = external {}

    GetSpringDisplacement<epic_internal>(Accessor: accessor)<transacts>: float = external {}

    GetSpringDisplacementVector<epic_internal>(
      Accessor: accessor
    )<transacts>: (/Verse.org/SpatialMath:)vector3 = external {}

    GetSpringSpeed<epic_internal>(Accessor: accessor)<transacts>: float = external {}
  }

  @experimental
  vehicle_thruster_component<epic_internal><native> := class<epic_internal><final>(vehicle_sim_base_component) {}

  @experimental
  vehicle_transmission_component<epic_internal><native> := class<epic_internal><final>(vehicle_sim_base_component) {
    @experimental
    GearChangeEvent<epic_internal><final><native>: listenable(gear_change_info) = external {}

    GetCurrentGear<epic_internal>(Accessor: accessor)<transacts>: int = external {}
  }

  @experimental
  vehicle_wheel_component<epic_internal><native> := class<epic_internal><final>(vehicle_sim_base_component) {
    GetAngularPositionDegrees<epic_internal>(Accessor: accessor)<transacts>: float = external {}

    GetForceIntoSurface<epic_internal>(Accessor: accessor)<transacts>: float = external {}

    GetRPM<epic_internal>(Accessor: accessor)<transacts>: float = external {}

    GetSlipAngle<epic_internal>(Accessor: accessor)<transacts>: float = external {}

    GetSteeringAngleDegrees<epic_internal>(Accessor: accessor)<transacts>: float = external {}

    GetTouchingGround<epic_internal>(Accessor: accessor)<transacts>: logic = external {}

    @experimental
    WheelTouchChangeEvent<epic_internal><final><native>: listenable(wheel_touch_change_info) = external {}
  }

  @experimental
  # wheel contact event
  wheel_touch_change_info<epic_internal><native> := struct<epic_internal> {
    IsInContact<public><native>: logic
  }
}

# Verse path: /Verse.org
# Module import path: /Verse.org/Simulation
Simulation<public> := module {
  @available { MinUploadedAtFNVersion := 3800 }
  (Session: session).Environment<public><native>()<transacts>: session_environment

  # Returns the `session` corresponding to the current round.  The result can be
  # used with `weak_map` to implement global variables.
  # Note: may be changed in a future release to return a single instance per
  # game. Round-local behavior should not be relied upon.
  GetSession<public><native>()<reads>: session

  # Get the seconds that have elapsed since the world began simulating
  GetSimulationElapsedTime<public><native>()<transacts>: float

  (/Verse.org/Simulation:)MakeLocalizableValue<epic_internal>(Agent: agent): localizable_agent = external {}

  # Waits specified number of seconds and then resumes. If `Seconds` = 0.0 then
  # it waits until next tick/frame/update. If `Seconds` = Inf then it waits
  # forever and only calls back if canceled - such as via `race`. If `Seconds`
  # < 0.0 then it completes immediately and does not yield to other
  # aysnc expressions.
  # Waiting until the next update (0.0) is especially useful in a loop of a
  # coroutine that needs to do some work every update and this yields to other
  # coroutines so that it doesn't hog a processor's resources.
  # Waiting forever (Inf) will have any expression that follows never be
  # evaluated. Occasionally it is desireable to have a task never complete such
  # as the last expression in a `race` subtask where the task must never win the
  # race though it still may be canceled earlier.
  # Immediately completing (less than 0) is useful when you want programmatic
  # control over whether an expression yields or not.
  Sleep<public><native>(Seconds: float)<suspends>: void

  # Verse path: /Verse.org/Simulation
  # Module import path: /Verse.org/Simulation/Tags
  Tags<public> := module {
    # Succeeds if Left and Right are equal.
    Equals<epic_internal><native>(Left: tag, Right: tag)<transacts><decides>: void

    # Succeeds if all tags in Left are found in Right and all tags in Right are
    # found in Left.
    Equals<epic_internal><native>(Left: tag_container, Right: tag_container)<transacts><decides>: void

    # Utility function to allow for easy construction from editor
    # exposable tag_type_info
    MakeTag<epic_internal><native>(TagTypeInfo: tag_type_info)<transacts><decides>: tag

    # Create a tag container from an array of tags.
    MakeTagContainer<epic_internal><native>(InTags: []tag)<transacts>: tag_container

    # Utility function to allow for easy construction from editor
    # exposable tag_type_info_container
    MakeTagContainer<epic_internal><native>(
      TagTypeInfoContainer: tag_type_info_container
    )<transacts><decides>: tag_container

    # Utility function to allow for easy construction from subclass
    MakeTagFromSubClass<epic_internal><native>(tag_type: subtype(tag))<transacts><decides>: tag

    # Get a string representation of the tag. Useful for debugging.
    (/Verse.org/Simulation/Tags:)ToString<epic_internal><native>(__dupe___unnamed_parameter_0: tag)<computes>: string

    # Returns abbreviated human readable Tag list. Useful for debugging.
    (/Verse.org/Simulation/Tags:)ToString<epic_internal><native>(
      __dupe___unnamed_parameter_0: tag_container
    )<computes>: string

    using { /Verse.org/Native }
    # An interface representing a mutable collection of tags.
    has_tags<public><native> := interface<epic_internal> {
      # Adds a `tag` instance to this container. Returns a `tag_key` that is
      # uniquely associated with the added instance.
      AddTag<public><native_callable>(Tag: tag)<transacts>: tag_key

      # Fails if at least one type in `tag_types` cannot be found in this
      # container, succeeds otherwise. Note that this means that if `tag_types`
      # is empty this call succeeds.
      ContainsAllTags<public><native_callable>(tag_types: []castable_subtype(tag))<decides><reads>: void

      # Succeeds if at least of the types in `tag_types` is found in this
      # container, fails otherwise. Note that this means that if `tag_types` is
      # empty this call fails.
      ContainsAnyTag<public><native_callable>(tag_types: []castable_subtype(tag))<decides><reads>: void

      # Succeeds if at least one tag of type `tag_type` is found in this
      # container, fails otherwise.
      ContainsTag<public><native_callable>(tag_type: castable_subtype(tag))<decides><reads>: void

      # Removes all tag instances of type `tag_type`, succeeds if at least one
      # instance was removed, fails otherwise.
      RemoveAllTags<public><native_callable>(tag_type: castable_subtype(tag))<transacts><decides>: void

      # Removes all tag instances that are not of type `tag_type`, succeeds if
      # at least one instance was removed, fails otherwise.
      RemoveAllTagsExcept<public><native_callable>(tag_type: castable_subtype(tag))<transacts><decides>: void

      # Removes all tag instances that are not of any of the types in
      # `tag_types`, succeeds if at least one instance was removed,
      # fails otherwise.
      RemoveAllTagsExcept<public><native_callable>(tag_types: []castable_subtype(tag))<transacts><decides>: void

      # Removes the tag instance associated with the `tag_key`, succeeds if an
      # instance was removed, fails otherwise.
      RemoveTag<public><native_callable>(Key: tag_key)<transacts><decides>: void
    }

    # A base type used for tagging objects in order to hierarchically evaluate
    # an objects classification.
    tag<public><native> := class<abstract><castable> {}

    # A mutable collection of tags.
    tag_container<epic_internal><native> := class<concrete>(tag_view) {
      # Add the specified tag to the container.
      Add<epic_internal><native>(Tag: tag): void

      # Adds all the tags from one container to this container NOTE: From set
      # theory, this effectively is the union of the container this is called on
      # with TagsToAdd.
      Add<epic_internal><native>(TagsToAdd: []tag): void

      # Adds all the tags from one container to this container NOTE: From set
      # theory, this effectively is the union of the container this is called on
      # with TagsToAdd.
      Add<epic_internal><native>(TagsToAdd: tag_container): void

      # Returns a generator for the tags in this container. This is an expensive
      # operation since it will create new tag instances for all tags in the
      # container. Do preferably not use this function for anything else
      # than debugging.
      GetTags<epic_internal><native>()<transacts>: generator(tag)

      # Determine if TagToCheck is present in this container, also checking
      # against parent tags {"A.1"}.Has("A") will return True, {"A"}.Has("A.1")
      # will return False If TagToCheck is not Valid it will always
      # return False.
      Has<native><override>(TagToCheck: tag)<decides><reads>: void

      # Checks if this container contains ALL of the tags in the specified
      # container, also checks against parent tags
      # {"A.1","B.1"}.HasAll({"A","B"}) will return True,
      # {"A","B"}.HasAll({"A.1","B.1"}) will return False If InTags is
      # empty/invalid it will always return True, because there were no
      # failed checks.
      (/Verse.org/Simulation/Tags/tag_container:)HasAll<epic_internal><native>(
        InTags: tag_container
      )<decides><reads>: void

      # Checks if this container contains ALL of the tags in the specified
      # container, also checks against parent tags
      # {"A.1","B.1"}.HasAll({"A","B"}) will return True,
      # {"A","B"}.HasAll({"A.1","B.1"}) will return False If InTags is
      # empty/invalid it will always return True, because there were no
      # failed checks.
      (/Verse.org/Simulation/Tags/tag_view:)HasAll<native><override>(InTags: []tag)<decides><reads>: void

      # Checks if this container contains ANY of the tags in the specified
      # container, also checks against parent tags {"A.1"}.HasAny({"A","B"})
      # will return True, {"A"}.HasAny({"A.1","B"}) will return False If InTags
      # is empty/invalid it will always return False.
      (/Verse.org/Simulation/Tags/tag_container:)HasAny<epic_internal><native>(
        InTags: tag_container
      )<decides><reads>: void

      # Checks if this container contains ANY of the tags in the specified
      # container, also checks against parent tags {"A.1"}.HasAny({"A","B"})
      # will return True, {"A"}.HasAny({"A.1","B"}) will return False If InTags
      # is empty/invalid it will always return False.
      (/Verse.org/Simulation/Tags/tag_view:)HasAny<native><override>(InTags: []tag)<decides><reads>: void

      # Returns the number of explicitly added tags.
      Num<epic_internal><native>()<reads>: int

      # Remove the specified tag from the container.
      Remove<epic_internal><native>(Tag: tag)<decides>: void

      # Removes all tags in TagsToRemove from this container.
      Remove<epic_internal><native>(TagsToRemove: []tag): void

      # Removes all tags in TagsToRemove from this container.
      Remove<epic_internal><native>(TagsToRemove: tag_container): void

      # Remove all tags from the container. Will maintain slack by default.
      Reset<epic_internal><native>(): void

      # Remove all tags from the container. Update the amount of slack
      # pre-allocated for tags.
      ResetWithSlack<epic_internal><native>(slack: int): void
    }

    @import_as("/Script/VerseTags.FVerseTagInstanceContainer")
    tag_instance_container<epic_internal><native> := struct<concrete> {}

    @import_as("/*.FVerseTagKey")
    # A `tag_key` is the return value from adding a `tag` to a container
    # implementing the `has_tags` interface, and is used to selectively remove
    # such an instance from the same container.
    tag_key<public><native> := struct<internal><uht_comparable> {}

    # Advanced tag search criteria
    tag_search_criteria<public><native> := class {
      # Tags that may NOT be on the object. All items with these tags are
      # excluded from the search.
      ExclusionTags<public><native>: []tag = external {}

      # Tags that are used if no required tags are specified. These are treated
      # as if any of them will do.
      PreferredTags<public><native>: []tag = external {}

      # Tags required to be on the object.
      RequiredTags<public><native>: []tag = external {}

      # Flag to request sorting the results by tag.
      SortType<public><native>: tag_search_sort_type = external {}
    }

    tag_search_sort_type<public><native> := enum {
      Sorted

      Unsorted
    }

    @deprecated { Message := "Use `tag_type_info` instead." }
    # Deprecated alias, use `tag_type_info` instead.
    tag_selector<epic_internal> := tag_type_info

    @deprecated { Message := "Use `tag_type_info_container` instead." }
    # Deprecated alias, use `tag_type_info_container` instead.
    tag_selector_container<epic_internal> := tag_type_info_container

    @experimental
    # An experimental replacement for the `tag_container` class that uses the
    # new `has_tags` api. as well as the new underlying overridable serializaion
    # for tag instances.
    tag_set<epic_internal><native> := class(has_tags, diagnosable) {
      # Adds a `tag` instance to this container. Returns a `tag_key` that is
      # uniquely associated with the added instance.
      AddTag<native><override>(Tag: tag)<transacts>: tag_key

      # Fails if at least one type in `tag_types` cannot be found in this
      # container, succeeds otherwise. Note that this means that if `tag_types`
      # is empty this call succeeds.
      ContainsAllTags<native><override>(tag_types: []castable_subtype(tag))<decides><reads>: void

      # Succeeds if at least of the types in `tag_types` is found in this
      # container, fails otherwise. Note that this means that if `tag_types` is
      # empty this call fails.
      ContainsAnyTag<native><override>(tag_types: []castable_subtype(tag))<decides><reads>: void

      # Succeeds if at least one tag of type `tag_type` is found in this
      # container, fails otherwise.
      ContainsTag<native><override>(tag_type: castable_subtype(tag))<decides><reads>: void

      # Returns a human readable version of this `tag_set`.
      GetDiagnostic<override><native>()<reads>: diagnostic

      # Removes all tag instances of type `tag_type`, succeeds if at least one
      # instance was removed, fails otherwise.
      RemoveAllTags<native><override>(tag_type: castable_subtype(tag))<transacts><decides>: void

      # Removes all tag instances that are not of type `tag_type`, succeeds if
      # at least one instance was removed, fails otherwise.
      RemoveAllTagsExcept<native><override>(tag_type: castable_subtype(tag))<transacts><decides>: void

      # Removes all tag instances that are not of any of the types in
      # `tag_types`, succeeds if at least one instance was removed,
      # fails otherwise.
      RemoveAllTagsExcept<native><override>(tag_types: []castable_subtype(tag))<transacts><decides>: void

      # Removes the tag instance associated with the `tag_key`, succeeds if an
      # instance was removed, fails otherwise.
      RemoveTag<native><override>(Key: tag_key)<transacts><decides>: void
    }

    @import_as("/Script/VerseTags.FVerseTagTypeInfo")
    # Utility structure which allows users to select a tag when exposed
    # to editor
    tag_type_info<epic_internal><native> := struct<concrete> {}

    @import_as("/Script/VerseTags.FVerseTagTypeInfoContainer")
    # Utility structure which allows users to select a tag when exposed
    # to editor
    tag_type_info_container<epic_internal><native> := struct<concrete> {}

    # A queryable collection of tags.
    tag_view<public><native> := interface<epic_internal> {
      # Determine if TagToCheck is present in this container, also checking
      # against parent tags {"A.1"}.Has("A") will return True, {"A"}.Has("A.1")
      # will return False If TagToCheck is not Valid it will always
      # return False.
      Has<public>(TagToCheck: tag)<decides><reads>: void

      # Checks if this container contains ALL of the tags in the specified
      # container, also checks against parent tags
      # {"A.1","B.1"}.HasAll({"A","B"}) will return True,
      # {"A","B"}.HasAll({"A.1","B.1"}) will return False If InTags is
      # empty/invalid it will always return True, because there were no
      # failed checks.
      HasAll<public>(InTags: []tag)<decides><reads>: void

      # Checks if this container contains ANY of the tags in the specified
      # container, also checks against parent tags {"A.1"}.HasAny({"A","B"})
      # will return True, {"A"}.HasAny({"A.1","B"}) will return False If InTags
      # is empty/invalid it will always return False.
      HasAny<public>(InTags: []tag)<decides><reads>: void
    }
  }

  @hide_in_editor
  agent<public><native> := class<epic_internal><unique>(entity) {
    User<epic_internal><native>: ?user = external {}
  }

  @attribscope_class
  @attribscope_data
  @customattribhandler
  allow_self_reference<epic_internal> := class<computes>(attribute) {}

  category<epic_internal><constructor>(Category: string)<computes>: category_attribute = external {}

  @attribscope_class
  @attribscope_data
  @attribscope_function
  @customattribhandler
  category_attribute<epic_internal> := class<internal><computes>(attribute) {}

  clamp_max<epic_internal><constructor>(ClampMax: string)<computes>: clamp_max_attribute = external {}

  @attribscope_data
  @customattribhandler
  clamp_max_attribute<epic_internal> := class<internal><computes>(attribute) {}

  clamp_min<epic_internal><constructor>(ClampMin: string)<computes>: clamp_min_attribute = external {}

  @attribscope_data
  @customattribhandler
  clamp_min_attribute<epic_internal> := class<internal><computes>(attribute) {}

  class_and_subclass_group_names<epic_internal><constructor>(
    ClassGroupNames: string
  )<computes>: class_and_subclass_group_names_attribute = external {}

  @attribscope_class
  @attribscope_data
  @attribscope_function
  @customattribhandler
  class_and_subclass_group_names_attribute<epic_internal> := class<internal><computes>(attribute) {}

  display_name<epic_internal><constructor>(DisplayName: string)<computes>: display_name_attribute = external {}

  @attribscope_class
  @attribscope_data
  @attribscope_function
  @customattribhandler
  display_name_attribute<epic_internal> := class<internal><computes>(attribute) {}

  display_priority<epic_internal><constructor>(
    DisplayPriority: string
  )<computes>: display_priority_attribute = external {}

  @attribscope_class
  @attribscope_data
  @attribscope_function
  @customattribhandler
  display_priority_attribute<epic_internal> := class<internal><computes>(attribute) {}

  @attribscope_class
  @attribscope_struct
  @attribscope_data
  @customattribhandler
  editable<public> := class<computes>(attribute) {
    # The categories displayed in the editor.
    Categories<public>: []message = external {}

    EditInline<epic_internal>: logic = external {}

    # If true the property will only be displayed if epic developer
    # permission exist.
    EpicOnly<epic_internal>: logic = external {}

    # The short tooltip displayed in the editor.
    ShortToolTip<epic_internal>: message = external {}

    # The thumbnail shown in the content browser.
    ShowThumbnail<epic_internal>: logic = external {}

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

  editable_empty_message<epic_internal><localizes>: message = external {}

  @attribscope_class
  @attribscope_struct
  @attribscope_data
  @customattribhandler
  editable_non_concrete<epic_internal> := class<computes>(attribute) {
    EditInline<epic_internal>: logic = external {}
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

    (/Verse.org/Simulation/editable_number:)Simulation_editable_number_Variance<private>(): tuple(t, t, t) = external {}

    # Snap the spinbox to the nearest delta.
    SpinBoxDelta<public>: ?t = external {}
  }

  @attribscope_class
  @attribscope_struct
  @attribscope_data
  @customattribhandler
  editable_option<epic_internal>(t: type) := class<final><computes>(editable) {
    # The default value used when creating this value in the editor.
    DefaultValue<epic_internal>: ?t = external {}

    (/Verse.org/Simulation/editable_option:)Simulation_editable_option_Variance<private>(): tuple(t) = external {}
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

    # Used to change how sensitive the field value is when moving the slider via
    # mouse cursor.
    MouseLinearDeltaSensitivity<public>: float = external {}

    MouseShiftMovePixelPerDelta<public>: float = external {}

    (/Verse.org/Simulation/editable_slider:)Simulation_editable_slider_Variance<private>(): tuple(
      t,
      t,
      t,
      t
    ) = external {}

    # The amount the slider moves for each step.
    SliderDelta<public>: ?t = external {}

    # Used to scale a slider exponentially. Common values are found within the
    # range of 1-20.
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

    (/Verse.org/Simulation/editable_vector_number:)Simulation_editable_vector_number_Variance<private>(): tuple(
      t,
      t,
      t
    ) = external {}

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

    # Used to change how sensitive the field value is when moving the slider via
    # mouse cursor.
    MouseLinearDeltaSensitivity<public>: float = external {}

    MouseShiftMovePixelPerDelta<public>: float = external {}

    # Show the button that allows normalizing the vector.
    ShowNormalize<public>: logic = external {}

    # Show the button that allows locking the vector aspect ratio.
    ShowPreserveRatio<public>: logic = external {}

    (/Verse.org/Simulation/editable_vector_slider:)Simulation_editable_vector_slider_Variance<private>(): tuple(
      t,
      t,
      t,
      t
    ) = external {}

    # The amount the slider moves for each step.
    SliderDelta<public>: ?t = external {}

    # Used to scale a slider exponentially. Common values are found within the
    # range of 1-20.
    SliderExponent<public>: ?t = external {}
  }

  @attribscope_class
  @customattribhandler
  editor_type<epic_internal> := class<computes>(attribute) {}

  @attribscope_class
  @attribscope_data
  @customattribhandler
  experimental_always_overridden<epic_internal> := class<computes>(attribute) {}

  field<epic_internal><constructor>(FieldName: string)<computes>: field_attribute = external {}

  @attribscope_class
  @attribscope_data
  @customattribhandler
  field_attribute<epic_internal> := class<internal><computes>(attribute) {}

  @attribscope_class
  @customattribhandler
  hide_in_editor<epic_internal> := class<computes>(attribute) {
    CVar<epic_internal>: string = external {}

    Hidden<epic_internal>: logic = external {}

    HideInDropDown<epic_internal>: logic = external {}
  }

  localizable_agent<epic_internal><native> := class(localizable_value) {
    Value<epic_internal><native>: agent
  }

  @hide_in_editor
  player<public><native> := class<epic_internal><unique><persistent><module_scoped_var_weak_map_key>(agent) {
    # Succeeds when this `player` may be used as a module-scoped `var`
    # `weak_map` key. This coincides with the corresponding player having joined
    # the game and not yet left. Using a `player` as a module-scope `var`
    # `weak_map` key when this method fails results in a runtime error.
    IsActive<public><native>()<decides><reads>: void
  }

  player_primitive_data_context<epic_internal><native> := class {
    Entity<epic_internal><native>: entity

    Player<epic_internal><native>: player

    UserData<epic_internal><native>: player_primitive_data_payload = external {}

    WriteFloat<epic_internal><native>(Index: int, Value: float): void

    WriteVector4<epic_internal><native>(Index: int, X: float, Y: float, Z: float, W: float): void
  }

  # This class is used for the per-player primitive data feature on
  # mesh_components. Users can derive from it and add fields  and access this
  # user data in callbacks subscribed to ComputePlayerPrimitiveDataEvent.
  player_primitive_data_payload<epic_internal><native> := class {
    PredictsTransport<epic_internal>(): void = external {}

    SubscribeToEvent<epic_internal>(Event: subscribable_event_intrnl(tuple()))<transacts>: cancelable = external {}
  }

  using { /Verse.org/Native }
  # Type for which there is a single instance per round.  Use `GetSession` to
  # get the current round's `session` instance. May be used with `weak_map` to
  # implement global variables.
  # Note: may be changed in a future release to a single instance per game.
  # Round-local behavior should not be relied upon.
  session<public><native> := class<epic_internal><unique><module_scoped_var_weak_map_key> {}

  # Specifies what type of environment the current session is in.
  session_environment<public><native> := enum {
    # The current session is in an Edit environment for an experience, such as a
    # session started within UEFN.
    Edit

    # The current session is in a Live environment for an experience.
    Live

    # The current session is in a Private environment for an experience, such as
    # a playtest.
    Private
  }

  short_tool_tip<epic_internal><constructor>(ShortToolTip: string)<computes>: short_tool_tip_attribute = external {}

  @attribscope_class
  @attribscope_data
  @attribscope_function
  @customattribhandler
  short_tool_tip_attribute<epic_internal> := class<internal><computes>(attribute) {}

  team<public><native> := class<epic_internal><unique> {}

  tool_tip<epic_internal><constructor>(ToolTip: string)<computes>: tool_tip_attribute = external {}

  @attribscope_class
  @attribscope_data
  @attribscope_function
  @customattribhandler
  tool_tip_attribute<epic_internal> := class<internal><computes>(attribute) {}

  @attribscope_class
  @attribscope_data
  @customattribhandler
  transient<epic_internal> := class<computes>(attribute) {}

  ui_max<epic_internal><constructor>(UIMax: string)<computes>: ui_max_attribute = external {}

  @attribscope_data
  @customattribhandler
  ui_max_attribute<epic_internal> := class<internal><computes>(attribute) {}

  ui_min<epic_internal><constructor>(UIMin: string)<computes>: ui_min_attribute = external {}

  @attribscope_data
  @customattribhandler
  ui_min_attribute<epic_internal> := class<internal><computes>(attribute) {}

  units<epic_internal><constructor>(Unit: string)<computes>: units_attribute = external {}

  @attribscope_data
  @customattribhandler
  units_attribute<epic_internal> := class<internal><computes>(attribute) {}

  using { /Verse.org/SceneGraph }
  user<epic_internal><native> := class<epic_internal> {}
}

# Verse path: /Verse.org
# Module import path: /Verse.org/SpatialMath
SpatialMath<public> := module {
  # Returns `Rotation` if it does not contain `NaN`, `Inf` or `-Inf`.
  (Rotation: rotation).(/Verse.org/SpatialMath:)IsFinite<public><native>()<decides><converges>: rotation

  @available { MinUploadedAtFNVersion := 3600 }
  # Degrees version of GetAngleRadians
  (Rotation: rotation).GetAngleDegrees<public>()<reads>: float = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  @vm_no_effect_token
  # Returns the radians of right-handed `rotation` around the axis of
  # `rotation`. See also `GetAxis`.
  (Rotation: rotation).GetAngleRadians<public><native>()<reads><converges>: float

  @vm_no_effect_token
  # Makes a `vector3` from the axis of `rotation` for an right-handed angle.
  # If `rotation` is nearly identity, this will return the +Forward axis. See
  # also `GetAngleRadians`.
  (Rotation: rotation).GetAxis<public><native>()<reads><converges>: vector3

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
  (Rotation: rotation).GetEulerRadians<public><native>()<reads><converges>: tuple(float, float, float)

  # Makes a unit `vector3` pointing in the *forward* rotated direction.
  # This is equivalent
  # to: `vector3{Forward:=1.0, Left:=0.0, Up:=0.0} * Rotation`.
  (Rotation: rotation).GetForwardAxis<public>()<reads>: vector3 = external {}

  # Makes a unit `vector3` pointing in the *left* rotated direction.
  # This is equivalent
  # to: `vector3{Forward:=0.0, Left:=1.0, Up:=0.0} * Rotation`.
  (Rotation: rotation).GetLeftAxis<public>()<reads>: vector3 = external {}

  # Makes a unit `vector3` pointing in the *up* rotated direction.
  # This is equivalent
  # to: `vector3{Forward:=0.0, Left:=0.0, Up:=1.0} * Rotation`.
  (Rotation: rotation).GetUpAxis<public>()<reads>: vector3 = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  @vm_no_effect_token
  # Degrees version of `GetYawPitchRollRadians`.
  (Rotation: rotation).GetYawPitchRollDegrees<public><native>()<reads><converges>: tuple(float, float, float)

  @available { MinUploadedAtFNVersion := 3600 }
  # Makes a `tuple(float, float, float)` with three elements:
  #  * *yaw* of `rotation` in radians
  #  * *pitch* of `rotation` in radians
  #  * *roll* of `rotation` in radians
  # using the conventions of `MakeRotationFromYawPitchRollRadians`.
  (Rotation: rotation).GetYawPitchRollRadians<public>()<reads>: tuple(float, float, float) = external {}

  @vm_no_effect_token
  # Makes a `rotation` by inverting `Rotation` such
  # that `ApplyRotation(Rotation, Rotation.Invert())) = IdentityRotation`.
  (Rotation: rotation).Invert<public><native>()<reads><converges>: rotation

  # Succeeds when each component of `V` is within `AbsoluteTolerance` of `0.0`.
  (V: vector3).(/Verse.org/SpatialMath:)IsAlmostZero<public>(
    AbsoluteTolerance: float
  )<computes><decides>: void = external {}

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
  # Returns the smallest angular distance between `Rotation1` and `Rotation2`
  # in radians.
  AngularDistanceRadians<public><native>(Rotation1: rotation, Rotation2: rotation)<reads><converges>: float

  # Makes a unit `vector3` pointing in the positive Backward axis
  BackwardAxis<epic_internal>()<computes>: vector3 = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  # Returns the right-handed cross product of `V1` and `V2`.
  CrossProduct<public>(V1: vector3, V2: vector3)<reads>: vector3 = external {}

  # Returns the left-handed cross product of `V1` and `V2`.
  CrossProductLeftHanded<public>(V1: vector3, V2: vector3)<reads>: vector3 = external {}

  # Returns radians from `Degrees`.
  DegreesToRadians<public>(Degrees: float)<reads>: float = external {}

  @vm_no_effect_token
  # Returns the distance between `Rotation1` and `Rotation2`. The result will
  # be between:
  #  * `0.0`, representing equivalent rotations and
  #  * `1.0` representing rotations which are 180 degrees apart (i.e., the
  #    shortest rotation between them is 180 degrees around some axis).
  Distance<public><native>(Rotation1: rotation, Rotation2: rotation)<reads><converges>: float

  # Returns the Euclidean distance between `V1` and `V2`.
  Distance<public>(V1: vector3, V2: vector3)<reads>: float = external {}

  # Returns the 2-D Euclidean distance between `V1` and `V2` by ignoring the
  # difference in `Up`.
  DistanceForwardLeft<public>(V1: vector3, V2: vector3)<reads>: float = external {}

  # Returns the squared Euclidean distance between `V1` and `V2`.
  DistanceSquared<public>(V1: vector3, V2: vector3)<reads>: float = external {}

  # Returns the squared 2-D Euclidean distance between `V1` and `V2` by ignoring
  # their difference in `Up`.
  DistanceSquaredForwardLeft<public>(V1: vector3, V2: vector3)<reads>: float = external {}

  # Returns the dot product of `V1` and `V2`.
  DotProduct<public>(V1: vector3, V2: vector3)<reads>: float = external {}

  # Makes a unit `vector3` pointing in the positive Down axis
  DownAxis<epic_internal>()<computes>: vector3 = external {}

  # Makes a unit `vector3` pointing in the positive Forward axis
  ForwardAxis<epic_internal>()<computes>: vector3 = external {}

  # Makes the identity `rotation`.
  IdentityRotation<public><native>()<converges>: rotation

  # Succeeds when each component of `V1` and `V2` are within `AbsoluteTolerance`
  # of each other.
  (/Verse.org/SpatialMath:)IsAlmostEqual<public>(
    V1: vector3,
    V2: vector3,
    AbsoluteTolerance: float
  )<computes><decides>: void = external {}

  # Makes a unit `vector3` pointing in the positive Left axis
  LeftAxis<epic_internal>()<computes>: vector3 = external {}

  # Used to linearly interpolate/extrapolate between `From` (when
  # `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that all
  # arguments are finite.
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
  # Makes a `rotation` by applying a post-rotation of `LeftAxisAngle` followed
  # by `UpAxisAngle` and then `ForwardAxisAngle `in that order. Right-handed
  # convention (e.g. a positive rotation around Up takes +Forward to Left).
  MakeRotationFromEulerRadians<public><native>(
    LeftAxisAngle: float,
    UpAxisAngle: float,
    ForwardAxisAngle: float
  )<reads><converges>: rotation

  @vm_no_effect_token
  # Degrees version of `MakeRotationFromYawPitchRollRadians`
  MakeRotationFromYawPitchRollDegrees<public><native>(
    YawAngle: float,
    PitchAngle: float,
    RollAngle: float
  )<reads><converges>: rotation

  @available { MinUploadedAtFNVersion := 3600 }
  # Makes a `rotation` by applying a pre-rotation of `YawAngle` followed by
  # `PitchAngle` and then `RollAngle`, in that order:
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
  # Makes a `rotation` from `Axis` and `Angle` in radians using a right-handed
  # sign convention (e.g. a positive rotation around Up takes Forward to Left).
  MakeRotationRadians<public><native>(Axis: vector3, Angle: float)<reads><converges>: rotation

  @vm_no_effect_token
  # Makes the smallest angular `rotation` from `InitialVector` to `FinalVector`
  # two vectors of arbitrary length such that:
  # `InitialVector * MakeShortestRotationBetween(InitialVector, FinalVector)
  # = FinalVector` and
  # `MakeShortestRotationBetween(InitialVector, FinalVector)?.GetAngleRadians()`
  # is as small as possible.
  MakeShortestRotationBetween<public><native>(InitialVector: vector3, FinalVector: vector3)<reads><converges>: rotation

  # Makes a `vector3` with all components `1.0`.
  Ones<epic_internal>()<computes>: vector3 = external {}

  # Returns degrees from `Radians`.
  RadiansToDegrees<public>(Radians: float)<reads>: float = external {}

  # Makes a `vector3` by inverting the `SurfaceNormal` component of `Direction`.
  ReflectVector<public>(Direction: vector3, SurfaceNormal: vector3)<reads>: vector3 = external {}

  # Makes a unit `vector3` pointing in the positive Right axis
  RightAxis<epic_internal>()<computes>: vector3 = external {}

  @vm_no_effect_token
  # Used to perform spherical linear interpolation between `From` (when
  # `Ratio = 0.0`) and `To` (when `Ratio = 1.0`). Expects `0.0 <= Ratio <= 1.0`.
  Slerp<public><native>(InitialRotation: rotation, FinalRotation: rotation, Ratio: float)<reads><converges>: rotation

  # Makes a `string` representation of `InTransform` where the result is on
  # the form.
  # `"{Translation = {ToString(`InTransform.Translation`)}, Rotation
  # = {ToString(`InTransform.Rotation`)},
  # Scale = {ToString(`InTransform.Scale`)}}".
  (/Verse.org/SpatialMath:)ToString<public>(InTransform: transform)<reads>: string = external {}

  # Makes a `string` representation of `rotation` in axis/degrees format with a
  # right-handed sign convention.
  # `ToString(MakeRotationRadians(vector3{Left:=0.0, Up:=0.0, Forward:=1.0},
  # PiFloat/2.0))` produces the string: `"{Axis = {Left=0.000000, Up=0.000000,
  # Forward=1.000000}, Angle = 90.000000}"`.
  (/Verse.org/SpatialMath:)ToString<public>(Rotation: rotation)<reads>: string = external {}

  # Makes a `string` representation of `V`.
  (/Verse.org/SpatialMath:)ToString<public>(V: vector3)<reads>: string = external {}

  # Makes a unit `vector3` pointing in the positive Up axis
  UpAxis<epic_internal>()<computes>: vector3 = external {}

  # Makes a `vector3` with all components `0.0`.
  Zero<epic_internal>()<computes>: vector3 = external {}

  @available { MinUploadedAtFNVersion := 3600 }
  @vm_no_effect_token
  # Apply a `PreRotation` to `PostRotation` as `v * PreRotation * PostRotation`.
  (/Verse.org/SpatialMath:)operator'*'<public><native>(
    PreRotation: rotation,
    PostRotation: rotation
  )<reads><converges>: rotation

  @vm_no_effect_token
  # Makes a `vector3` by applying `Rotation` to `Vector`.
  (/Verse.org/SpatialMath:)operator'*'<public><native>(Vector: vector3, Rotation: rotation)<reads><converges>: vector3

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
  using { /Verse.org/Temporary/EpicGamesRestricted/Network }
  @replicatable
  @import_as("/*.FVRotation")
  # An abstract representation of an orientation change in 3d-space.
  rotation<public><native> := struct<concrete><uht_comparable> {}

  @replicatable
  @import_as("/*.FVTransform")
  # A combination of scale, rotation, and translation, applied in that order.
  transform<public><native> := struct<concrete><computes><uht_comparable> {
    @editable
    # The rotation of this `transform`.
    Rotation<public><native>: rotation = external {}

    @editable
    @units("x")
    # The scale of this `transform`.
    Scale<public><native>: vector3 = external {}

    @editable
    # The location of this `transform`.
    Translation<public><native>: vector3 = external {}
  }

  @replicatable
  @import_as("/*.FVVector3")
  # 3-dimensional vector with `float` components.
  vector3<public><native> := struct<concrete><computes><persistable><uht_comparable> {
    @editable
    # The Forward (was X) component of this vector.
    Forward<public><native>: float = external {}

    @editable
    # The Left (was -Y) component of this vector.
    Left<public><native>: float = external {}

    @editable
    # The Up (was Z) component of this vector.
    Up<public><native>: float = external {}
  }
}

# Verse path: /Verse.org
# Module import path: /Verse.org/StateMachine
StateMachine<public> := module {
  # Wether the leaves are the Parent state, or are a child of the Parent state.
  AreChildStatesOf<epic_internal><native>(Leaves: []state, Parent: state_container)<decides><reads>: void

  # Wether the Leaf is the Parent state, or is a child of the Parent state.
  IsChildStateOf<epic_internal><native>(Leaf: state, Parent: state_container)<decides><reads>: void

  state<epic_internal><native> := class<abstract><unique><final_super_base>(state_container) {
    # Called by the state machine (in correct order) when the state
    # is activated.
    OnEnter<public><native><native_callable>(): void

    # Called by the state machine (in correct order) when the state
    # is deactivated.
    OnExit<public><native><native_callable>(): void

    # The parent of the state.
    Parent<public><native>: state_container

    # Send a scene event to this state. OnReceive will be invoked propagating to
    # the child states. Consuming the event at any point will halt propagation.
    # A state that is not active at any point will halt propagation. Returns
    # true if any participant consumed the event.
    SendDown<public><final><native>(StateEvent: state_event): logic

    # Send a scene event to this state. OnReceive will be invoked propagating to
    # the parent's state. Consuming the event at any point will halt
    # propagation. A state that is not active at any point will halt
    # propagation. Returns true if any participant consumed the event.
    SendUp<public><final><native>(StateEvent: state_event): logic

    # Transition to the new leaf states, replacing all the active states child
    # of this state, and keeping the other leaves active.  Propagating from leaf
    # to root, OnExit will be invoked on active states that are not in the new
    # transition.  Then, propagating from root to leaf, OnEnter will be invoked
    # for the new states that were not previously activated.  Other transitions
    # can occur while invoking OnExit or in OnEnter.  The current OnExit or
    # OnEnter invocation will complete before the new transition executes.  The
    # previous transition will merge with the new transition. In case of
    # conflict, the new transition takes precedence.
    TransitionUnder<public><final>(Leaves: []state): void = external {}
  }

  state_container<epic_internal><native> := class<unique> {
    # Respond to a state event. Return true to consume the event and halt
    # propagation to the next state/state_machine.
    OnReceive<protected><native><native_callable>(StateEvent: state_event): state_receive_result
  }

  state_event<epic_internal><native> := interface {}

  state_machine<epic_internal><native> := class(state_container, diagnosable) {
    GetDiagnostic<override><native>()<reads>: diagnostic

    # Send a scene event to this state machine. OnReceive will be invoked from
    # the root states propagating to the child states. It uses the depth-first
    # pre-order algorithm for progapating the event. Consuming the event at any
    # point will halt propagation. Returns true if any participant consumed
    # the event.
    SendDown<public><final><native>(StateEvent: state_event): logic

    # Send a scene event to this state machine. OnReceive will be invoked on
    # each active leaf states on this state machine propagating to the parent's
    # state. It uses the depth-first post-order algorithm for progapating the
    # event. Consuming the event at any point will halt propagation. Returns
    # true if any participant consumed the event.
    SendUp<public><final><native>(StateEvent: state_event): logic

    # Transition to the new leaf states, replacing all the active states.
    # Propagating from leaf to root, OnExit will be invoked on active states
    # that are not in the new transition.  Then, propagating from root to leaf,
    # OnEnter will be invoked for the new states that were not previously
    # activated.  Other transitions can occur while invoking OnExit or in
    # OnEnter.  The current OnExit or OnEnter invocation will complete before
    # the new transition executes.  The previous transition will merge with the
    # new transition. In case of conflict, the new transition takes precedence.
    TransitionTo<public><final><native_callable>(Leaves: []state): void = external {}

    # Transition to the new leaf states, replacing all the active states child
    # of Parent state, and keeping the other leaves active.  Propagating from
    # leaf to root, OnExit will be invoked on active states that are not in the
    # new transition.  Then, propagating from root to leaf, OnEnter will be
    # invoked for the new states that were not previously activated.  Other
    # transitions can occur while invoking OnExit or in OnEnter.  The current
    # OnExit or OnEnter invocation will complete before the new transition
    # executes.  The previous transition will merge with the new transition. In
    # case of conflict, the new transition takes precedence.
    TransitionUnder<public><final>(Parent: state, Leaves: []state): void = external {}
  }

  state_receive_result<epic_internal><native> := enum {
    Consume

    Continue

    Preserve
  }

  state_tree_node<epic_internal><native> := struct {
    Children<public><native>: []state

    State<public><native>: state_container
  }
}

Temporary<public> := module {
  # Verse path: /Verse.org/Temporary
  # Module import path: /Verse.org/Temporary/EpicGamesRestricted
  EpicGamesRestricted<public> := module {
    # Module import path: /Verse.org/Temporary/EpicGamesRestricted/Network
    Network<public> := module {
      @attribscope_struct
      replicatable<epic_internal> := class<internal><computes>(attribute) {}

      replicated<epic_internal><constructor>(ReplicationArgs: string)<computes>: replicated_attribute = external {}

      @attribscope_data
      @customattribhandler
      replicated_attribute<epic_internal> := class<internal><computes>(attribute) {}
    }
  }
}

@available { MinUploadedAtFNVersion := 4200 }
# Module import path: /Verse.org/Timeline
Timeline<public> := module {
  @available { MinUploadedAtFNVersion := 4200 }
  # Abstract definition of any element that can be added to a timeline.See
  # timeline_element_point and timeline_element_span.
  timeline_element<public><native> := class(timeline_element_base_cancelable) {}

  using { /Verse.org/Native }
  using { /Verse.org/Simulation }
  @available { MinUploadedAtFNVersion := 4200 }
  @import_as("/Script/VerseTimeline.UVerseTimelineElementBase")
  timeline_element_base<epic_internal><native> := class<epic_internal> {}

  @available { MinUploadedAtFNVersion := 4200 }
  timeline_element_base_cancelable<epic_internal><native> := class(timeline_element_base, cancelable) {
    Cancel<override>()<transacts>: void = external {}
  }

  @available { MinUploadedAtFNVersion := 4200 }
  # A timeline element that occupies a single point in time.
  timeline_element_point<public><native> := class<abstract>(timeline_element) {
    SetTime<public><native>(NewTime: float)<transacts>: void

    @editable {}
    # The time of this point. May be +/-Inf.NaN will never be updated
    # or queried.
    var<private> Time<public><native>: float
  }

  @available { MinUploadedAtFNVersion := 4200 }
  # A timeline element that spans a range of time.
  timeline_element_span<public><native> := class<abstract>(timeline_element) {
    # Called to modify the timeline's range by assigning its begin and
    # end times.
    SetRange<public><native>(NewBeginTime: float, NewEndTime: float)<transacts>: void

    @editable {}
    # The time this span begins. Defaults to 0.0.Must be <> NaN and <= EndTime
    # in order for it to be updated or queriedMay be +/- Inf
    var<private> BeginTime<public><native>: float = external {}

    @editable {}
    # The time this span ends. Defaults to Inf.Must be <> NaN and >= BeginTime
    # in order for it to be updated or queriedMay be +/- Inf.
    var<private> EndTime<public><native>: float = external {}
  }
}

Verse<public> := module {
  @available { MinUploadedAtFNVersion := 3800 }
  @experimental
  # Succeeds if `element_type` is present in `InSet`.
  (InSet: classifiable_subset(t) where t: castable_subtype(k), k: type).Contains<public>(
    element_type: castable_subtype(k)
  )<decides><reads>: void = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  @experimental
  # Succeeds if all the `element_types` are present in `InSet`.
  (InSet: classifiable_subset(t) where t: castable_subtype(k), k: type).ContainsAll<public>(
    element_types: []castable_subtype(k)
  )<decides><reads>: void = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  @experimental
  # Succeeds if any of the `element_types` are present in `InSet`.
  (InSet: classifiable_subset(t) where t: castable_subtype(k), k: type).ContainsAny<public>(
    element_types: []castable_subtype(k)
  )<decides><reads>: void = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  @experimental
  # Returns a new set that contains all the elements in `InSet` that are of
  # type `element_type`.
  (InSet: classifiable_subset(t) where t: castable_subtype(k), k: type).FilterByType<public><native>(
    element_type: castable_subtype(k)
  )<transacts>: classifiable_subset(t)

  @available { MinUploadedAtFNVersion := 3800 }
  @experimental
  # TEMPORARY. Succeeds if `element_type` is present in `InSet`.
  (InSet: classifiable_subset_var(t) where t: castable_subtype(k), k: type).Contains<epic_internal>(
    element_type: castable_subtype(k)
  )<decides><reads>: void = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  @experimental
  # TEMPORARY. Succeeds if all the `element_types` are present in `InSet`.
  (InSet: classifiable_subset_var(t) where t: castable_subtype(k), k: type).ContainsAll<epic_internal>(
    element_types: []castable_subtype(k)
  )<decides><reads>: void = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  @experimental
  # TEMPORARY. Succeeds if any of the `element_types` are present in `InSet`.
  (InSet: classifiable_subset_var(t) where t: castable_subtype(k), k: type).ContainsAny<epic_internal>(
    element_types: []castable_subtype(k)
  )<decides><reads>: void = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  @experimental
  # TEMPORARY. Returns a new set that contains all the elements in `InSet` that
  # are of type `element_type`.
  (InSet: classifiable_subset_var(t) where t: castable_subtype(k), k: type).FilterByType<epic_internal>(
    element_type: castable_subtype(k)
  )<transacts>: classifiable_subset(t) = external {}

  @experimental
  # TEMPORARY. Adds `InElement` to `InSet` and returns a
  # `classifiable_subset_key` for removing that very element from `InSet` again.
  # This function will operate directly on classifiable_subset once
  # https://jira.it.epicgames.com/browse/SOL-7982 is complete.
  (InSet: classifiable_subset_var(t) where t: type).Add<epic_internal><native>(
    InElement: t
  )<transacts>: classifiable_subset_key(t)

  @experimental
  # TEMPORARY. Removes the element corresponding to `InKey` from `InSet`, fails
  # if the element was not present in `InSet` before trying to remove it. This
  # function will operate directly on classifiable_subset once
  # https://jira.it.epicgames.com/browse/SOL-7982 is complete.
  (InSet: classifiable_subset_var(t) where t: type).Remove<epic_internal><native>(
    InKey: classifiable_subset_key(t)
  )<transacts><decides>: void

  # Returns the first index whose element in `Input` equals `ElementToFind`.
  # Fails if ElementToFind does not exist in the array.
  (Input: []t where t: subtype(comparable)).Find<public>(ElementToFind: t)<computes><decides>: int = external {}

  # Makes an `array` by removing all elements that equal `ElementToRemove`
  # from `Input`.
  (Input: []t where t: subtype(comparable)).RemoveAllElements<public>(ElementToRemove: t)<computes>: []t = external {}

  # Makes an `array` by removing the element at the lowest index that equals
  # `ElementToRemove` from `Input`.
  # Fails if `Input` did not contain any instances of `ElementToRemove`.
  (Input: []t where t: subtype(comparable)).RemoveFirstElement<public>(
    ElementToRemove: t
  )<computes><decides>: []t = external {}

  # Makes an `array` by replacing all ranges of elements that equal
  # `ElementsToReplace` with `Replacement` in `Input`.
  # When there are multiple overlapping instances of `ElementsToReplace` in
  # `Input`, only the position with the lowest index is replaced.
  (Input: []t where t: subtype(comparable)).ReplaceAll<public>(
    ElementsToReplace: []t,
    Replacement: []t
  )<transacts>: []t = external {}

  # Makes an `array` by replacing all elements that equal `ElementToReplace`
  # with `ElementToReplaceWith` in `Input`.
  (Input: []t where t: subtype(comparable)).ReplaceAllElements<public>(
    ElementToReplace: t,
    ElementToReplaceWith: t
  )<computes>: []t = external {}

  # Makes an `array` by replacing the element at the lowest index that equals
  # `ElementToReplace` with `ElementToReplaceWith` in `Input`.
  # Fails if `Input` did not contain any instances of `ElementToReplace`.
  (Input: []t where t: subtype(comparable)).ReplaceFirstElement<public>(
    ElementToReplace: t,
    ElementToReplaceWith: t
  )<computes><decides>: []t = external {}

  # Makes an `array` by inserting `ElementsToInsert` into `Input` such that the
  # first element of `ElementsToInsert` is at `InsertionIndex`.
  (Input: []t where t: type).Insert<public>(
    InsertionIndex: int,
    ElementsToInsert: []t
  )<computes><decides>: []t = external {}

  # Makes an `array` by removing `Input`'s elements from `StartIndex`
  # to `StopIndex-1`.
  # Succeeds if `0 <= StartIndex <= StopIndex <= Input.Length`.
  (Input: []t where t: type).Remove<public>(StartIndex: int, StopIndex: int)<computes><decides>: []t = external {}

  # Makes an `array` by removing the element at `IndexToRemove` from `Input`.
  # Succeeds if `0 <= IndexToRemove <= Input.Length-1`.
  (Input: []t where t: type).RemoveElement<public>(IndexToRemove: int)<computes><decides>: []t = external {}

  # Makes an `array` by replacing the element at `IndexToReplace` with
  # `ElementToReplaceWith` in `Input`.
  # Succeeds if `0 <= IndexToReplace <= Input.Length-1`.
  (Input: []t where t: type).ReplaceElement<public>(
    IndexToReplace: int,
    ElementToReplaceWith: t
  )<computes><decides>: []t = external {}

  # Makes an `array` containing `Input`'s elements from `StartIndex`
  # to `Input.Length-1`.
  # Succeeds if `0 <= StartIndex <= Input.Length`.
  (Input: []t where t: type).Slice<public>(StartIndex: int)<computes><decides>: []t = external {}

  # Makes an `array` containing `Input`'s elements from `StartIndex`
  # to `StopIndex-1`.
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
  ArCosh<public><native>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the inverse hyperbolic sine of `X` if `IsFinite(X)`.
  ArSinh<public><native>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the inverse hyperbolic tangent of `X` if `IsFinite(X)`.
  ArTanh<public><native>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the inverse cosine (arccosine) of `X` as a value in radians
  # if `-1.0 <= X <= 1.0`.
  ArcCos<public><native>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the inverse sine (arcsine) of `X` as a value in radians
  # if `-1.0 <= X <= 1.0`.
  ArcSin<public><native>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the inverse tangent (arctangent) of `X` as a value in radians
  # such that:`-PiFloat/2.0 <= ArcTan(x) <= PiFloat/2.0`.
  ArcTan<public><native>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the angle in radians at the origin between a ray pointing to
  # `(X, Y)` and the positive `X` axis such
  # that `-PiFloat < ArcTan(Y, X) <= PiFloat`.
  # Returns `0.0` if `X=0.0 and Y=0.0`.
  ArcTan<public><native>(Y: float, X: float)<reads>: float

  # Returns whether the Verse code that called the currently-executing function
  # can access epic_internal definitions (i.e. is Epic-authored, or belongs to
  # an internal-user package).
  CanCallerAccessEpicInternal<epic_internal><native_callable>()<transacts>: logic = external {}

  CanCallerAccessEpicInternal_Impl<epic_internal><native>()<transacts>: logic

  # Returns the smallest `int` that is greater than or equal to `Val`.
  # Fails if `not IsFinite(Val)`.
  Ceil<public><native>(Val: float)<decides><reads>: int

  @rtfm_always_open
  # Constrains the value of `Val` between `A` and `B`. Robustly handles
  # different argument orderings.
  # Returns the median of `Val`, `A`, and `B`.
  Clamp<public><native>(Val: int, A: int, B: int)<computes>: int

  # Constrains the value of `Val` between `A` and `B`. Robustly handles
  # different argument orderings.
  # Returns the median of `Val`, `A`, and `B`, such that comparisons with `NaN`
  # operate as if `NaN > +Inf`.
  Clamp<public>(Val: float, A: float, B: float)<computes>: float = external {}

  using { /Verse.org/Concurrency }
  using { /Verse.org/Native }
  # Makes a flattened `array` by concatenating the elements of `Arrays`.
  Concatenate<public>(Arrays: [][]t where t: type)<computes>: []t = external {}

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the cosine of `X`, where `X` is interpreted as a value in radians,
  # if `IsFinite[X]`.
  # Returns `NaN` if `not IsFinite[X]`.
  Cos<public><native>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the hyperbolic cosine of `X`.
  Cosh<public><native>(X: float)<reads>: float

  @available { MinUploadedAtFNVersion := 4100 }
  # Module import path: /Verse.org/Verse/Easing
  Easing<public> := module {
    using { /Verse.org/Native }
    @available { MinUploadedAtFNVersion := 4100 }
    @experimental
    # Make a cubic bezier interpolation function.
    CubicBezier<public><native>(
      X1: float,
      Y1: float,
      X2: float,
      Y2: float
    )<converges>: type { _(: float)<reads>: float }

    @available { MinUploadedAtFNVersion := 4100 }
    @experimental
    # Ease interpolation function. `Ease` animations start slowly, speed up,
    # then end slowly. The speed of the animation is slightly slower at the end
    # than the start.
    Ease<public><native_callable>(Value: float)<reads>: float = external {}

    @available { MinUploadedAtFNVersion := 4100 }
    @experimental
    # Ease-in interpolation function. `EaseIn` animations start slow, then speed
    # up towards the end.
    EaseIn<public><native_callable>(Value: float)<reads>: float = external {}

    @available { MinUploadedAtFNVersion := 4100 }
    @experimental
    # Ease-in-out interpolation function. `EaseInOut` animations are similar to
    # `Ease` but the start and end animation speed is symmetric.
    EaseInOut<public><native_callable>(Value: float)<reads>: float = external {}

    @available { MinUploadedAtFNVersion := 4100 }
    @experimental
    # Ease-out interpolation function. `EaseOut` animations start fast, then
    # slow down towards the end.
    EaseOut<public><native_callable>(Value: float)<reads>: float = external {}

    @available { MinUploadedAtFNVersion := 4100 }
    @experimental
    # Linear interpolation function. `Linear` animations move at a
    # constant speed.
    Linear<public><native_callable>(Value: float)<reads>: float = external {}
  }

  # Halts the Verse runtime with error `Message`.
  Err<public><native>(Message: string)<computes>: false

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the natural exponent of `X`.
  Exp<public><native>(X: float)<reads>: float

  # Returns the largest `int` that is less than or equal to `Val`.
  # Fails if `not IsFinite(Val)`.
  Floor<public><native>(Val: float)<decides><reads>: int

  @available { MinUploadedAtFNVersion := 3300 }
  # Return an immediate subclass of base_type that is <castable> and
  # <final_super> and is also shared with Instance. Otherwise failure.
  GetCastableFinalSuperClass<epic_internal><native>(
    base_type: type,
    Instance: base_type
  )<decides><reads>: castable_subtype(base_type)

  @available { MinUploadedAtFNVersion := 3300 }
  # Return an immediate subclass of base_type that is <castable> and
  # <final_super> and is also shared with sub_type. Otherwise failure.
  GetCastableFinalSuperClassFromType<epic_internal><native>(
    base_type: type,
    sub_type: subtype(base_type)
  )<decides><reads>: castable_subtype(base_type)

  # Returns the number of seconds since January 1, 1970 UTC, ignoring leap
  # seconds. I.e, this function implements Unix time. This function always
  # returns the same value within the same transaction.
  GetSecondsSinceEpoch<public><native>()<reads>: float

  # Returns the `int` that equals `Val` without the fractional part.
  # Fails if `not IsFinite(val)`.
  Int<public><native>(Val: float)<decides><reads>: int

  # Succeeds if `Val1` and `Val2` are within `AbsoluteTolerance` of each other.
  IsAlmostEqual<public>(Val1: float, Val2: float, AbsoluteTolerance: float)<computes><decides>: void = external {}

  @available { MinUploadedAtFNVersion := 4100 }
  # Makes a `message` by concatenating `Separator` between the elements
  # of `Messages`.
  Join<public><native>(Messages: []message, Separator: message)<transacts>: message

  # Makes a `string` by concatenating `Separator` between the elements
  # of `Strings`.
  Join<public><native>(Strings: []string, Separator: string)<computes>: string

  @vm_no_effect_token
  @rtfm_always_open
  # Used to linearly interpolate/extrapolate between `From` (when
  # `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that all
  # arguments are finite.
  # Returns `From*(1 - Parameter) + To*Parameter`.
  Lerp<public><native>(From: float, To: float, Parameter: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the natural logarithm of `X`.
  Ln<public><native>(X: float)<reads>: float

  # Makes a `string` by localizing `Message` based on the current `locale`.
  Localize<public><native>(Message: message)<reads>: string

  # Returns the base `B` logarithm of `X`.
  Log<public>(B: float, X: float)<reads>: float = external {}

  @experimental
  # Constructs a `classifiable_subset` containing the `InElements`.
  MakeClassifiableSubset<public><native>(InElements: []t where t: type)<converges>: classifiable_subset(t)

  @experimental
  # TEMPORARY. Constructs a `classifiable_subset_var` containing
  # the `InElements`.
  MakeClassifiableSubsetVar<epic_internal><native>(
    InElements: []t where t: type
  )<reads><converges>: classifiable_subset_var(t)

  @available { MinUploadedAtFNVersion := 3800 }
  MakeError<public>(Result: error_type where error_type: type)<computes>: result(false, error_type) = external {}

  MakeLocalizableValue<epic_internal>(V: float): localizable_float = external {}

  MakeLocalizableValue<epic_internal>(V: int): localizable_int = external {}

  MakeLocalizableValue<epic_internal>(V: message): localizable_message = external {}

  MakeLocalizableValue<epic_internal>(V: string): localizable_string = external {}

  MakeMessageInternal<epic_internal><native>(K: string, D: string, S: [string]localizable_value)<converges>: message

  MakeMessageLiteral<epic_internal><native>(K: string, D: string)<converges>: message

  @available { MinUploadedAtFNVersion := 3800 }
  MakeSuccess<public>(
    Result: success_type where success_type: type
  )<computes>: result(success_type, false) = external {}

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
  Mod<public><native>(X: int, Y: int)<computes><decides>: int

  # Pi, the ratio of the circumference of a circle to its diameter.
  PiFloat<public>: float = external {}

  @vm_no_effect_token
  @rtfm_always_open
  # Returns `A` to the power of `B`.
  Pow<public><native>(A: float, B: float)<reads>: float

  # Writes `Message` to a dedicated `Print` log while displaying it in `Color`
  # on the client screen for `Duration` seconds. By default, `Color` is
  # `NamedColors.White` and `Duration` is `2.0` seconds.
  Print<public><native>(Message: message, ?Duration: float = external {}, ?Color: color = external {})<transacts>: void

  using { /Verse.org/Colors }
  # Verse path: /Verse.org/Verse
  # Writes `Message` to a dedicated `Print` log while displaying it in `Color`
  # on the client screen for `Duration` seconds. By default, `Color` is
  # `NamedColors.White` and `Duration` is `2.0` seconds.
  Print<public><native>(Message: string, ?Duration: float = external {}, ?Color: color = external {})<transacts>: void

  # Writes `Message` to a dedicated `Print` log while displaying it in `Color`
  # on the client screen for `Duration` seconds. By default, `Color` is
  # `NamedColors.White` and `Duration` is `2.0` seconds.
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
  Quotient<public><native>(X: int, Y: int)<computes><decides>: int

  # Returns `Val` rounded to the nearest `int`. When the fractional part of
  # `Val` is `0.5`, rounds to the nearest *even* `int` (per the IEEE-754 default
  # rounding mode).
  # Fails if `not IsFinite(Val)`.
  Round<public><native>(Val: float)<decides><reads>: int

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
  # Returns the sine of `X`, where `X` is interpreted as a value in radians,
  # if `IsFinite[X]`.
  # Returns `NaN` if `not IsFinite[X]`.
  Sin<public><native>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the hyperbolic sine of `X`.
  Sinh<public><native>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the square root of `X` if `X >= 0.0`.
  # Returns `NaN` if `X < 0.0`.
  Sqrt<public><native>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the tangent of `X`, where `X` is interpreted as a value in radians,
  # if `IsFinite[X]`.
  # Returns `NaN` if `not IsFinite[X]`.
  Tan<public><native>(X: float)<reads>: float

  @vm_no_effect_token
  @rtfm_always_open
  # Returns the hyperbolic tangent of `X`.
  Tanh<public><native>(X: float)<reads>: float

  # Converts any Verse value into an opaque diagnostic message.
  ToDiagnostic<public><native>(Value: any)<reads>: diagnostic

  # Makes a `string` by converting `Character` to UTF-8 from UTF-32.
  ToString<epic_internal><native>(Character: char32)<computes>: string

  # Makes a `string` from `Character`.
  ToString<public><native>(Character: char)<computes>: string

  # Makes a `string` representation of `Val`.
  ToString<public><native>(Val: float)<reads>: string

  # Makes a printable `string` representation of `Val`.
  ToString<public><native>(Val: int)<computes>: string

  # Returns `String` without modification.
  ToString<public>(String: string)<computes>: string = external {}

  # Prints the Verse runtime callstack with warning `Message`.
  Warn<epic_internal><native>(Message: string)<computes>: void

  accessor<epic_internal><native> := enum {
    Dummy
  }

  # Implemented by classes that allow users to cancel an operation. For example,
  # calling `subscribable.Subscribe` with a callback returns a `cancelable`
  # object. Calling `Cancel` on the return object unsubscribes the callback.
  cancelable<public><native> := interface {
    # Prevents any current or future work from completing.
    Cancel<public><native_callable>()<transacts>: void
  }

  @experimental
  # A `classifiable_subset` is a container that holds a set of elements. A
  # classifiable_subset can hold multiple elements of the same type.
  classifiable_subset<public><native>(element_type: type) := class<internal><final><computes>(diagnosable) {
    # Temporary function for constraining variance correctly.
    CovarianceConstraint<protected>(): ?element_type = external {}

    GetDiagnostic<override><native>()<reads>: diagnostic

    (/Verse.org/Verse/classifiable_subset:)Verse_classifiable_subset_Variance<private>(): tuple(
      element_type,
      element_type,
      element_type
    ) = external {}
  }

  @experimental
  # A `classifiable_subset_key` is used to remove dynamically added elements
  # from a `classifiable_subset`. The returned key will also work in resulting
  # sets from usage of the `+` operator as well as `FilterByType`.
  classifiable_subset_key<epic_internal><native>(element_type: type) := class<internal><final><unique><transacts>(
    diagnosable
  ) {
    # Temporary function for constraining variance correctly.
    CovarianceConstraint<protected>(): ?element_type = external {}

    GetDiagnostic<override><native>()<reads>: diagnostic

    (/Verse.org/Verse/classifiable_subset_key:)Verse_classifiable_subset_key_Variance<private>(): tuple(
      element_type
    ) = external {}
  }

  @experimental
  # TEMPORARY. Acts as a wrapper class for a classifiable_subset until `ref`
  # keyword exists. This wrapper class will be removed once
  # https://jira.it.epicgames.com/browse/SOL-7982 is complete.
  classifiable_subset_var<epic_internal><native>(element_type: type) := class<internal><final><reads>(diagnosable) {
    GetDiagnostic<override>()<reads>: diagnostic = external {}

    # Returns the underlying `classifiable_subset`.
    Read<public><native>()<reads>: classifiable_subset(element_type)

    (/Verse.org/Verse/classifiable_subset_var:)Verse_classifiable_subset_var_Variance<private>(
      : element_type
    ): tuple(element_type) = external {}

    # Writes `InSet` to the underlying `classifiable_subset`.
    Write<public><native>(InSet: classifiable_subset(element_type))<writes>: void
  }

  # Provides a hook for class-specific ToDiagnostic behavior; ToDiagnostic will
  # call this interface when provided a class that implements it.
  diagnosable<epic_internal><native> := interface<computes> {
    GetDiagnostic<epic_internal><native_callable>()<reads>: diagnostic
  }

  # An opaque diagnostic message that only shows up in diagnostic logs. The
  # format of the diagnostic may change at any time without warning and may not
  # be inspected by Verse code.
  diagnostic<public><native> := class<epic_internal><computes>(diagnosable) {
    GetDiagnostic<override>()<reads>: diagnostic = external {}

    String<epic_internal><native>: string
  }

  # Implemented by classes whose instances have limited lifetimes.
  disposable<public><native> := interface {
    # Cleans up this object.
    Dispose<public>(): void
  }

  # Implemented by classes whose instances can be enabled and disabled.
  enableable<public><native> := interface<public> {
    # Disable this object.
    Disable<public>(): void

    # Enable this object.
    Enable<public>(): void

    # Succeeds if the object is enabled, fails if it’s disabled.
    IsEnabled<public>()<transacts><decides>: void
  }

  # A *recurring*, successively signaled parametric `event` with a `payload`
  # allowing a simple mechanism to coordinate between concurrent tasks.
  event<public><native>(t: type) := class(event_base_intrnl, signalable(t), awaitable(t)) {
    # Suspends the current task until another task calls `Signal`.
    # If called during another invocation of `Signal`, the the task will still
    # suspend and resume during the next call to `Signal`.
    Await<native><override>()<suspends>: t

    # Concurrently resumes the tasks that were suspended by `Await` calls before
    # this call to `Signal`.
    #
    # Tasks are resumed in the order they were suspended. Each task will perform
    # as much work as it can until it encounters a blocking call, whereupon it
    # will transfer control to the next suspended task.
    Signal<native><override>(Val: t): void

    (/Verse.org/Verse/event:)Verse_event_Variance<private>(: t): tuple(t) = external {}

    @available { MinUploadedAtFNVersion := 4210 }
    (/Verse.org/Verse/event:)Verse_event_Variance_Inherited<private>(: t): tuple(t, t) = external {}
  }

  # A *recurring*, successively signaled event allowing a simple mechanism to
  # coordinate between concurrent tasks.
  event<public>() := event(tuple())

  event_base_intrnl<epic_internal><native> := class {}

  # Implemented by classes whose instances can become invalid at runtime.
  invalidatable<public><native> := interface(disposable) {
    # Succeeds if this object is still valid.
    IsValid<public>()<transacts><decides>: void
  }

  # A parametric interface combining `awaitable` and `subscribable`.
  listenable<public><native>(payload: type) := interface(awaitable(payload), subscribable(payload)) {
    @available { MinUploadedAtFNVersion := 4210 }
    (/Verse.org/Verse/listenable:)Verse_listenable_Variance_Inherited<private>(): tuple(
      payload,
      payload,
      payload
    ) = external {}
  }

  # A parameterless interface combining `awaitable` and `subscribable`.
  listenable<public>() := listenable(tuple())

  # Used for message localization.
  locale<public><native> := struct<epic_internal> {}

  localizable_float<epic_internal><native> := class<internal>(localizable_value) {}

  localizable_int<epic_internal><native> := class<internal>(localizable_value) {}

  localizable_message<epic_internal><native> := class<internal>(localizable_value) {}

  localizable_string<epic_internal><native> := class<internal>(localizable_value) {}

  localizable_value<epic_internal><native> := class {}

  # A localizable text message.
  message<public><native> := class<epic_internal> {
    DefaultText<epic_internal><native>: string = external {}

    Key<epic_internal><native>: string = external {}

    Substitutions<epic_internal><native>: [string]localizable_value = external {}
  }

  using { /Verse.org/Simulation }
  using { /Verse.org/Temporary/EpicGamesRestricted/Network }
  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  # Implemented by classes to provide a method for modification evaluation.
  modifier<public><native>(t: type) := interface {
    Evaluate<public><native_callable>(InValue: t)<reads>: t

    (/Verse.org/Verse/modifier:)Verse_modifier_Variance<private>(: t): tuple(t) = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  # Modifier stacks provide an ordered application of modifiers.
  modifier_stack<public><native>(t: type) := class(modifier(t)) {
    # Insert a Modifier at Position in the stack.
    # If multiple modifiers are added at the same position, they are applied
    # such that the most recently added is the last evaluated.
    # Returns a cancelable which can be used to remove Modifier from the stack.
    AddModifier<public>(Modifier: modifier(t), Position: rational)<transacts>: cancelable = external {}

    # Returns a t which is the input evaluated against each modifier in the
    # stack, executed in position order.
    Evaluate<override>(InValue: t)<reads>: t = external {}

    (/Verse.org/Verse/modifier_stack:)Verse_modifier_stack_Variance<private>(
      : t,
      : t,
      : t,
      : t
    ): tuple(t, t, t, t) = external {}

    @available { MinUploadedAtFNVersion := 4210 }
    (/Verse.org/Verse/modifier_stack:)Verse_modifier_stack_Variance_Inherited<private>(: t): tuple(t) = external {}

    @replicated("RepNotify")
    @editable
    var Entries<epic_internal><native>: []modifier_stack_entry = external {}

    var<private> FirstPosition<public><native>: rational = external {}

    var<private> LastPosition<public><native>: rational = external {}
  }

  @available { MinUploadedAtFNVersion := 4100 }
  @experimental
  modifier_stack_entry<epic_internal><native> := class<epic_internal>(cancelable) {
    Cancel<override>()<transacts>: void = external {}

    @replicated("RepNotify")
    @editable
    Modifier<epic_internal><native>: modifier(any)

    @replicated("")
    @editable
    Position<epic_internal><native>: rational = external {}

    @replicated("")
    Stack<epic_internal><native>: modifier_stack(any)
  }

  @experimental
  # TEMPORARY. Returns a new set that is the union of all elements in `InSetL`
  # set and `InSetR`.
  operator'+'<epic_internal>((
    InSetL: classifiable_subset_var(t),
    InSetR: classifiable_subset_var(t)
  ) where t: type)<transacts>: classifiable_subset(t) = external {}

  @experimental
  # Returns a new set that is the union of all elements in `InSetL` set
  # and `InSetR`.
  operator'+'<public><native>((
    InSetL: classifiable_subset(t),
    InSetR: classifiable_subset(t)
  ) where t: type)<transacts>: classifiable_subset(t)

  # Concatenates two diagnostic messages.
  operator'+'<public>(Lhs: diagnostic, Rhs: diagnostic)<computes>: diagnostic = external {}

  # Concatenates a diagnostic message with a normal string, yielding a
  # diagnostic message.
  operator'+'<public>(Lhs: diagnostic, Rhs: string)<computes>: diagnostic = external {}

  # Concatenates a normal string with a diagnostic message, yielding a
  # diagnostic message.
  operator'+'<public>(Lhs: string, Rhs: diagnostic)<computes>: diagnostic = external {}

  @available { MinUploadedAtFNVersion := 3800 }
  # Implemented by classes that provide a result for an operation, which can
  # fail or be successful
  result<public><native>(success_type: type, error_type: type) := interface<internal><computes> {
    # Returns the error data of the specified type.
    GetError<public><native_callable>()<computes><decides>: error_type

    # Returns the success data of the specified type.
    GetSuccess<public><native_callable>()<computes><decides>: success_type

    (/Verse.org/Verse/result:)Verse_result_Variance<private>(): tuple(success_type, error_type) = external {}
  }

  # Implemented by classes whose instances can change visibility to be shown
  # or hidden.
  showable<public><native> := interface {
    # Set this value to hide or show the class.
    var Show<public>: logic
  }

  # A parametric interface implemented by events with a `payload` that can
  # be signaled.
  # Can be used with `awaitable`, `subscribable`, or both (see: `listenable`).
  signalable<public><native>(payload: type) := interface {
    # Concurrently resumes the tasks waiting for this event in `awaitable.Await`
    # and synchronously invokes any callbacks added to this event
    # by `subscribable.Subscribe`.
    Signal<public><native_callable>(Val: payload): void

    (/Verse.org/Verse/signalable:)Verse_signalable_Variance<private>(: payload): tuple() = external {}
  }

  # A parametric interface implemented by events with a `payload` that can be
  # subscribed to.
  # Matched with `signalable.`
  subscribable<public><native>(t: type) := interface {
    # Registers `Callback` to be invoked on matching calls to `signable.Signal`.
    # Returns an unsubscriber object. Call `cancelable.Cancel` on the
    # unsubscriber to unregister `Callback`.
    Subscribe<public>(Callback: type { _(: t): void })<transacts>: cancelable

    (/Verse.org/Verse/subscribable:)Verse_subscribable_Variance<private>(): tuple(t) = external {}
  }

  # A parameterless interface implemented by events that can be subscribed to.
  subscribable<public>() := subscribable(tuple())

  subscribable_event_intrnl<epic_internal>() := subscribable_event_intrnl(tuple())

  subscribable_event_intrnl<epic_internal><native>(t: type) := class(event(t), listenable(t)) {
    Signal<native><override>(Val: t): void

    # Registers `Callback` to be invoked each time `Signal` is called.
    # Call `Cancel` on the returned `cancelable` to unregister `Callback`.
    Subscribe<native><override>(Callback: type { _(: t): void })<transacts>: cancelable

    (/Verse.org/Verse/subscribable_event_intrnl:)Verse_subscribable_event_intrnl_Variance<private>(
      : t
    ): tuple(t) = external {}

    @available { MinUploadedAtFNVersion := 4210 }
    (/Verse.org/Verse/subscribable_event_intrnl:)Verse_subscribable_event_intrnl_Variance_Inherited<private>(
      : t
    ): tuple(t, t, t) = external {}
  }
}

# Verse path: /Verse.org
# Module import path: /Verse.org/VerseExperimental
VerseExperimental<public> := module {
  # Creates and initializes a new instance with the specified year, month, day,
  # hour, minute, second and millisecond.
  CreateDateTime<public><native>(
    Year: int,
    Month: int,
    Day: int,
    Hour: int,
    Minute: int,
    Second: int,
    Millisecond: int
  )<transacts><decides>: date_time

  # Creates and initializes a new instance with the specified days, hours,
  # minutes, seconds and milliseconds.
  CreateTimeSpan<public><native>(
    Days: int,
    Hours: int,
    Minutes: int,
    Seconds: int,
    Milliseconds: int
  )<transacts>: time_span

  # Returns the maximum date value. The maximum date value is December 31, 9999,
  # 23:59:59.9999999. See DateTimeMin
  DateTimeMax<public>()<transacts>: date_time = external {}

  # Returns the minimum date value. The minimum date value is January 1, 0001,
  # 00:00:00.0. See DateTimeMax
  DateTimeMin<public>()<transacts>: date_time = external {}

  # Return the number of days in the specified month of the specified year
  DaysInMonth<public><native>(Year: int, Month: int): int

  # Return the number of days in the specified year
  DaysInYear<public><native>(Year: int): int

  GetDate<public><native>(Val: date_time): date_parts

  GetDay<public><native>(Val: date_time): int

  GetDayOfWeek<public><native>(Val: date_time): day_of_week

  GetDays<public><native>(Val: time_span): int

  GetHours<public><native>(Val: date_time): int

  GetHours<public><native>(Val: time_span): int

  GetMicroseconds<public><native>(Val: date_time): int

  GetMicroseconds<public><native>(Val: time_span): int

  GetMilliseconds<public><native>(Val: date_time): int

  GetMilliseconds<public><native>(Val: time_span): int

  GetMinutes<public><native>(Val: date_time): int

  GetMinutes<public><native>(Val: time_span): int

  GetMonth<public><native>(Val: date_time): int

  GetMonthOfYear<public><native>(Val: date_time): month_of_year

  GetNanoseconds<public><native>(Val: date_time): int

  GetNanoseconds<public><native>(Val: time_span): int

  GetSeconds<public><native>(Val: date_time): int

  GetSeconds<public><native>(Val: time_span): int

  GetTimeOfDay<public><native>(Val: date_time): time_of_day_parts

  GetTotalDays<public><native>(Val: time_span): int

  GetTotalHours<public><native>(Val: time_span): int

  GetTotalMicroseconds<public><native>(Val: time_span): int

  GetTotalMilliseconds<public><native>(Val: time_span): int

  GetTotalMinutes<public><native>(Val: time_span): int

  GetTotalSeconds<public><native>(Val: time_span): int

  GetYear<public><native>(Val: date_time): int

  Greater<public>(Left: date_time, Right: date_time)<transacts><decides>: date_time = external {}

  Greater<public>(Left: time_span, Right: time_span)<transacts><decides>: time_span = external {}

  GreaterEqual<public>(Left: date_time, Right: date_time)<transacts><decides>: date_time = external {}

  GreaterEqual<public>(Left: time_span, Right: time_span)<transacts><decides>: time_span = external {}

  Less<public>(Left: date_time, Right: date_time)<transacts><decides>: date_time = external {}

  Less<public>(Left: time_span, Right: time_span)<transacts><decides>: time_span = external {}

  LessEqual<public>(Left: date_time, Right: date_time)<transacts><decides>: date_time = external {}

  LessEqual<public>(Left: time_span, Right: time_span)<transacts><decides>: time_span = external {}

  # Returns a string representation of the datetime in the following format:
  # yyyy.mm.dd-hh.mm.ss. Assumes Datetime is in UTC.
  (/Verse.org/VerseExperimental:)ToString<public><native>(Val: date_time): string

  # Returns a string representation of the time span in the following
  # format: yyyy.mm.dd-hh.mm.ss.
  (/Verse.org/VerseExperimental:)ToString<public><native>(Val: time_span): string

  # Returns the current UTC date_time.
  UtcNow<public><native>(): date_time

  ValidateDateTime<public><native>(
    Year: int,
    Month: int,
    Day: int,
    Hour: int,
    Minute: int,
    Second: int,
    Millisecond: int
  ): logic

  date_parts<public><native> := struct<internal> {
    Day<native>: int

    Month<native>: int

    Year<native>: int
  }

  date_time<public><native> := struct {
    Ticks<public><native>: int = external {}
  }

  # Enumerates the days of the week in 7-day calendars.
  day_of_week<public><native> := enum {
    Friday

    Monday

    Saturday

    Sunday

    Thursday

    Tuesday

    Wednesday
  }

  # Enumerates the months of the year in 12-month calendars.
  month_of_year<public><native> := enum {
    April

    August

    December

    February

    January

    July

    June

    March

    May

    November

    October

    September
  }

  (/Verse.org/VerseExperimental:)operator'*'<public>(Left: float, Right: time_span): time_span = external {}

  (/Verse.org/VerseExperimental:)operator'*'<public>(Left: time_span, Right: float): time_span = external {}

  (/Verse.org/VerseExperimental:)operator'+'<public>(Left: date_time, Right: time_span): date_time = external {}

  (/Verse.org/VerseExperimental:)operator'+'<public>(Left: time_span, Right: time_span): time_span = external {}

  (/Verse.org/VerseExperimental:)operator'-'<public>(Left: date_time, Right: date_time): time_span = external {}

  (/Verse.org/VerseExperimental:)operator'-'<public>(Left: date_time, Right: time_span): date_time = external {}

  (/Verse.org/VerseExperimental:)operator'-'<public>(Left: time_span, Right: time_span): time_span = external {}

  (/Verse.org/VerseExperimental:)operator'-'<public>(Right: time_span): time_span = external {}

  (/Verse.org/VerseExperimental:)operator'/'<public>(Left: time_span, Right: float): time_span = external {}

  time_of_day_parts<public><native> := struct<internal> {
    Hours<native>: int

    Microseconds<native>: int

    Milliseconds<native>: int

    Minutes<native>: int

    Nanoseconds<native>: int

    Seconds<native>: int
  }

  time_span<public><native> := struct {
    Ticks<public>: int = external {}
  }
}

subscribable_event<epic_internal>(t: type) := class(subscribable_event_intrnl(t)) {
  Broadcast<epic_internal>(Val: t): void = external {}

  (/Verse.org/subscribable_event:)subscribable_event_Variance<private>(: t): tuple() = external {}

  @available { MinUploadedAtFNVersion := 4210 }
  (/Verse.org/subscribable_event:)subscribable_event_Variance_Inherited<private>(
    : t,
    : t,
    : t,
    : t,
    : t,
    : t
  ): tuple(t, t, t, t, t, t, t, t, t) = external {}
}
