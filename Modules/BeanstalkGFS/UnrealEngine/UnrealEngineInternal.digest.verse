# Copyright Epic Games, Inc. All Rights Reserved.
#################################################
# Generated Digest of Verse API
# DO NOT modify this manually!
# Generated from build: ++Fortnite+Release-37.51-CL-46968237
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

  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  # Navigation layers are various representations of the world that can be used by agents of different shapes and abilities
  navigation_layer<native><epic_internal> := class<abstract> {}

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
  using { /Verse.org/SceneGraph }
  ability<native><public> := class {
    Activate<native><protected>()<suspends>: void

    GameplayAbilityPath<native><epic_internal>: ?string = external {}
  }

  @experimental
  ability_component<native><public> := class<final_super>(component) {
    ActivateAbility<native><epic_internal>(Ability: ability): void

    ActivateAbility<native><public>(ability_type: subtype(ability)): void

    GiveAbility<native><epic_internal>(Ability: ability)<transacts><decides>: void

    GiveAbility<native><public>(ability_type: subtype(ability))<transacts><decides>: void
  }

  @attribscope_data
  @customattribhandler
  ability_link<epic_internal> := class<computes>(attribute) {
    Name<epic_internal>: string = external {}
  }
}

using { /UnrealEngine.com/Temporary/SpatialMath }
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

  play_sound_subscription<native><epic_internal> := class(cancelable) {
    Cancel<native><override>()<transacts>: void
  }

  spawn_particle_system_subscription<native><epic_internal> := class(cancelable) {
    Cancel<native><override>()<transacts>: void
  }
}

using { /Verse.org/Assets }
using { /Verse.org/SceneGraph }
# Module import path: /UnrealEngine.com/BasicShapes
BasicShapes<public> := module {
  cone<public> := class<final><public>(mesh_component) {
    Mesh<override>: mesh = external {}
  }

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

using { /Verse.org/Simulation/Tags }
# Module import path: /UnrealEngine.com/ComponentTestSuite
ComponentTestSuite<public> := module {
  @hide_in_editor
  test_component_key_component_a<native><epic_internal> := class(test_component_key_component_base) {}

  @hide_in_editor
  test_component_key_component_b<native><epic_internal> := class(test_component_key_component_base) {}

  @hide_in_editor
  test_component_key_component_base<native><epic_internal> := class<final_super>(component) {}

  @hide_in_editor
  test_tag_animal<native><epic_internal> := class(tag) {}

  @hide_in_editor
  test_tag_animal_cat<native><epic_internal> := class(test_tag_animal) {}

  @hide_in_editor
  test_tag_animal_cat_cheddar<native><epic_internal> := class(test_tag_animal_cat) {}

  @hide_in_editor
  test_tag_animal_cat_jello<native><epic_internal> := class(test_tag_animal_cat) {}

  @hide_in_editor
  test_tag_animal_dog<native><epic_internal> := class(test_tag_animal) {}

  @hide_in_editor
  test_tag_animal_dog_kimchi<native><epic_internal> := class(test_tag_animal_dog) {}

  @hide_in_editor
  test_tag_animal_dog_pollo<native><epic_internal> := class(test_tag_animal_dog) {}

  @hide_in_editor
  test_tag_vehicle<native><epic_internal> := class(tag) {}

  @hide_in_editor
  test_tag_vehicle_bike<native><epic_internal> := class(test_tag_vehicle) {}

  @hide_in_editor
  test_tag_vehicle_bike_norton<native><epic_internal> := class(test_tag_vehicle_bike) {}

  @hide_in_editor
  test_tag_vehicle_car<native><epic_internal> := class(test_tag_vehicle) {}

  @hide_in_editor
  test_tag_vehicle_car_datsun<native><epic_internal> := class(test_tag_vehicle_car) {}
}

using { /Verse.org/Native }
using { /Verse.org/SpatialMath }
# Module import path: /UnrealEngine.com/ControlInput
ControlInput<public> := module {
  @available { MinUploadedAtFNVersion := 3630 }
  # Access input-related data and settings for a player.
  GetPlayerInput<native><public>(Player: player)<transacts><decides>: player_input

  MakeInputAsset<native><epic_internal>((
    InputAction: input_action(t),
    Path: string
  ) where t: type)<converges>: input_action(t)

  @available { MinUploadedAtFNVersion := 3630 }
  # Input_events is a container for user input events which can be subscribed to.
  #   * Use the 'GetPlayerInput' and 'GetInputEvents' functions to retrieve an input_events object for a given player.
  #   * Low-level notifications of current user input: DetectionBeginEvent, DetectionOngoingEvent, and DetectionEndEvent.
  #   * High-level notifications of triggered events: ActivationTriggeredEvent and ActivationCanceledEvent.
  #
  #                         /—----------<-------\
  #  DetectionBeginEvent -> DetectionOngoingEvent -> ActivationTriggeredEvent -> DetectionEndEvent
  #            /\                         /\                                            /
  #              \---------------------> ActivationCanceledEvent ----------------------/
  input_events<native><public>(t: type) := class<epic_internal> {
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

  @available { MinUploadedAtFNVersion := 3630 }
  # This is the main manager class for input-related settings and functions for a player.
  player_input<native><public> := class {
    AddInputMapping<native><public>(InputMapping: input_mapping): void

    GetInputEvents<native><public>(ActionToBind: input_action(t) where t: type): input_events(t)

    MakeFloatInputEvents<native_callable><epic_internal>(): input_events(float) = external {}

    MakeLogicInputEvents<native_callable><epic_internal>(): input_events(logic) = external {}

    MakeVector3InputEvents<native_callable><epic_internal>(): input_events((/Verse.org/SpatialMath:)vector3) = external {}

    RemoveInputMapping<native><public>(InputMapping: input_mapping): void
  }
}

using { /Verse.org/Simulation }
# Module import path: /UnrealEngine.com/EntityRegistryTestSuite
EntityRegistryTestSuite<public> := module {
  @hide_in_editor
  entity_registry_not_used_test_entity<native><epic_internal> := class(entity) {}

  @hide_in_editor
  entity_registry_other_test_component<native><epic_internal> := class<final_super>(component) {}

  @hide_in_editor
  entity_registry_test_component<native><epic_internal> := class<final_super>(component) {}

  @hide_in_editor
  entity_registry_test_entity<native><epic_internal> := class(entity) {}

  @hide_in_editor
  entity_registry_unused_test_component<native><epic_internal> := class<final_super>(component) {}
}

using { /Verse.org/Temporary/EpicGamesRestricted/Network }
# Module import path: /UnrealEngine.com/EntityTestSuite
EntityTestSuite<public> := module {
  @hide_in_editor
  derived_test_component<native><epic_internal> := class(test_component) {}

  @hide_in_editor
  lambda_test_component<native><epic_internal> := class<final_super>(component) {
    OnAddedToSceneInternal<native><override>(): void

    OnBeginSimulationInternal<native><override>(): void

    OnEndSimulationInternal<native><override>(): void

    OnInitializedInternal<native><override>(): void

    OnRemovingFromSceneInternal<native><override>(): void

    OnSimulate<override>()<suspends>: void = external {}

    OnUninitializingInternal<native><override>(): void
  }

  @hide_in_editor
  lambda_test_component_2<native><epic_internal> := class<final_super>(component) {
    OnAddedToSceneInternal<native><override>(): void

    OnBeginSimulationInternal<native><override>(): void

    OnEndSimulationInternal<native><override>(): void

    OnInitializedInternal<native><override>(): void

    OnRemovingFromSceneInternal<native><override>(): void

    OnSimulate<override>()<suspends>: void = external {}

    OnUninitializingInternal<native><override>(): void
  }

  @hide_in_editor
  second_derived_test_component<native><epic_internal> := class(test_component) {}

  @hide_in_editor
  test_component<native><epic_internal> := class<final_super>(component) {}

  @hide_in_editor
  test_component_dependency_auto<native><epic_internal> := class<final_super>(component) {}

  @hide_in_editor
  test_component_dependency_init<native><epic_internal> := class<final_super>(component) {
    @replicated("")
    var AutoComponent<native><epic_internal>: ?component = external {}
  }

  @hide_in_editor
  test_contentscope_events_component<native><epic_internal> := class<final_super>(component) {
    KeyframeReachedEvent<native><public>: listenable(tuple()) = external {}

    OnBeginSimulation<override>(): void = external {}
  }

  @hide_in_editor
  test_contentscope_execution_component<native><epic_internal> := class<final_super>(component) {
    OnBeginSimulation<override>(): void = external {}
  }

  @hide_in_editor
  test_material<native><epic_internal> := class(material) {
    ___PropertyInterface_On_BaseColor_Changed<epic_internal>(): void = external {}
  }

  @hide_in_editor
  test_material_component<native><epic_internal> := class<final_super>(component) {
    OnBeginSimulation<override>(): void = external {}
  }

  @hide_in_editor
  test_replication_component<native><epic_internal> := class<final_super>(component) {
    @replicated("")
    var<private> TestReplicatedSubObject<native><epic_internal>: ?test_replication_object = external {}
  }

  @hide_in_editor
  test_replication_object<native><epic_internal> := class {}

  @hide_in_editor
  test_stable_component<native><epic_internal> := class<final_super>(component) {}

  @hide_in_editor
  test_stable_entity<native><epic_internal> := class<concrete><unique><transacts>(entity) {}
}

Itemization<public> := module {
  @experimental
  (InAgent: agent).GetInventory<native><public>()<reads><decides>: inventory_component

  DefaultText<localizes><epic_internal>: message = external {}

  @experimental
  add_inventory_result<native><epic_internal> := class<epic_internal> {
    Inventory<native><public>: inventory_component

    ParentInventory<native><public>: inventory_component
  }

  @experimental
  add_item_event<native><public> := class<epic_internal>(scene_event) {
    ItemComponent<native><public>: item_component

    var EligibleInventories<native><public>: []inventory_with_priority
  }

  @experimental
  add_items_result<native><public> := class<epic_internal> {
    AddedItems<native><public>: []entity

    Inventory<native><public>: inventory_component
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

  @experimental
  change_items_slot_result<native><epic_internal> := struct<epic_internal> {
    Inventory<native><public>: inventory_component

    SlotChangedItems<native><public>: []item_slot_change
  }

  using { /UnrealEngine.com/Abilities }
  using { /Verse.org }
  using { /Verse.org/Assets }
  using { /Verse.org/Colors }
  using { /Verse.org/Native }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  using { /Verse.org/Simulation/Tags }
  using { /Verse.org/Temporary/EpicGamesRestricted/Network }
  @experimental
  copy_from_item<native><epic_internal> := interface<epic_internal> {
    CopyFromItem<native_callable><epic_internal>(SourceItem: entity)<transacts>: void
  }

  @experimental
  failure_reason<native><public> := class<castable><concrete><reads> {}

  @experimental
  # Item Merge Rules Interface. Implemented by components that want to participate in item mergeability checks.
  has_item_merge_rules<public> := interface<unique> {
    CanMergeInto<public>(TargetItem: entity)<reads><decides>: void = external {}

    OnMergeInto<public>(TargetItem: entity, MergeAmount: int)<transacts>: void = external {}
  }

  @experimental
  invalid_item_failure_reason<native><public> := class<final><reads>(failure_reason) {}

  @experimental
  # Inventory components hold items. An entity with an inventory component can be considered to have an inventory.
  # The inventory component controls which items can enter or exit.
  # They also determine whether an item can be equipped.
  inventory_component<native><public> := class<final_super>(component) {
    AddInventory<native><final><epic_internal>(Inventory: inventory_component)<transacts><decides>: void

    # Adds items to the inventory. Fails if no items could be added.
    AddItem<native><final><public>(
      Item: entity,
      ?AllowMergeItems: logic = external {},
      ?AllowPartialItemMove: logic = external {}
    )<transacts><decides>: void

    AddItemsEvent<native><final><public>: listenable(add_items_result) = external {}

    # Adds the provided inventory_rule_interface instance to this inventory's rule list if not already present.
    # NOTE: this part of the API is likely to change during Experimental.
    AddRule<native><final><public>(Rule: inventory_rule_interface)<transacts><decides>: cancelable

    # Returns a failure reason (such as being full) if the provided item entity cannot be added.
    CanAddItem<final><native><public>(
      Item: entity,
      ?AllowMergeItems: logic = external {},
      ?AllowPartialItemMove: logic = external {}
    )<transacts>: ?failure_reason

    CanEquipItem<native><epic_internal>(Item: entity)<transacts><decides>: void

    # Returns a failure reason if the provided item is not present or cannot be removed.
    CanRemoveItem<final><native><public>(Item: entity)<transacts>: ?failure_reason

    EquipItem<native><epic_internal>(Item: entity)<transacts><decides>: void

    @available { MinUploadedAtFNVersion := 2930 }
    # Returns a list of all sub-inventories within this inventory and its descendant inventories.
    FindInventories<native><final><public>()<reads>: generator(inventory_component)

    @available { MinUploadedAtFNVersion := 2930 }
    # Returns a list of all items within this inventory and its descendant inventories.
    FindItems<native><final><public>()<reads>: generator(entity)

    GetEquippedItems<final><native><epic_internal>(): []entity

    GetInputAction<epic_internal>(ItemSlot: int): ?input_action(type) = external {}

    # Returns a list of sub-inventories of this inventory only.
    GetInventories<native><final><public>()<reads>: []inventory_component

    GetItemSlot<native><epic_internal>(Item: entity)<reads>: int

    # Returns a list of items currently within this inventory only.
    GetItems<native><final><public>()<reads>: []entity

    GetNativeInputAction<native><epic_internal>(ItemSlot: int): ?input_action(type)

    GetNavigateNextInputAction<native><epic_internal>(): ?input_action(type)

    GetNavigatePreviousInputAction<native><epic_internal>(): ?input_action(type)

    InventoryAddedEvent<native><final><epic_internal>: listenable(add_inventory_result) = external {}

    InventoryPropertyChangedEvent<native><final><epic_internal>: listenable(inventory_property_change_result) = external {}

    InventoryRemovedEvent<native><final><epic_internal>: listenable(remove_inventory_result) = external {}

    ItemsSlotChangedEvent<native><final><epic_internal>: listenable(change_items_slot_result) = external {}

    OnInitializedInternal<native><override>(): void

    OnUninitializingInternal<native><override>(): void

    RemoveInventory<native><final><epic_internal>(Inventory: inventory_component)<transacts><decides>: void

    # Removes items from the inventory. Fails if no items could be removed.
    RemoveItem<native><final><public>(Item: entity)<transacts><decides>: void

    RemoveItemsEvent<native><final><public>: listenable(remove_items_result) = external {}

    ShowSlotBindings<native><epic_internal>: logic = external {}

    SlotBindingList<native><epic_internal>: []tuple(input_action(type), int) = external {}

    UnequipItem<native><epic_internal>(Item: entity)<transacts><decides>: void

    @replicated("")
    var<private> EnableItemStacking<native><epic_internal>: logic = external {}

    @replicated("")
    var<private> InventoryDescription<native><epic_internal>: message = external {}

    @replicated("")
    var<private> InventoryDisplayName<native><epic_internal>: message = external {}

    @replicated("RepNotify")
    var<private> InventoryMaxStackSizeOverride<native><epic_internal>: int = external {}

    @replicated("")
    var<private> InventoryName<native><epic_internal>: string = external {}

    var<private> InventoryRuleList<native><public>: []inventory_rule_interface = external {}

    @replicated("")
    var<private> PickupPriority<native><epic_internal>: int = external {}

    @replicated("RepNotify")
    var<private> TotalSlots<native><protected>: int = external {}
  }

  @experimental
  inventory_full_failure_reason<epic_internal> := class<final><reads>(failure_reason) {}

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
    InventoryRules<native><public>: []inventory_rule_interface = external {}

    @editable
    PickupPriority<native><public>: int = external {}

    @editable
    SlotBindings<native><public>: []inventory_slot_binding_definition

    @editable_number(int) { MinValue := option { 0 } }
    TotalSlotsOverride<native><public>: int = external {}
  }

  @experimental
  inventory_property_change_result<native><epic_internal> := struct<epic_internal> {
    Inventory<native><public>: inventory_component
  }

  @experimental
  # Interface for inventory rules. Used for composable rules for inventories.
  inventory_rule_interface<native><public> := interface<unique><castable> {
    CanAddItem<native_callable><public>(
      InventoryComponent: inventory_component,
      Item: entity,
      ?AllowMergeItems: logic = external {},
      ?AllowPartialItemMove: logic = external {}
    ): ?failure_reason = external {}

    CanMergeItem<native_callable><public>(
      InventoryComponent: inventory_component,
      Item: entity
    ): ?failure_reason = external {}

    CanRemoveItem<native_callable><public>(
      InventoryComponent: inventory_component,
      Item: entity
    ): ?failure_reason = external {}

    # Called after an inventory_rule_interface instance is added to an inventory.
    OnRuleAdded<native_callable><public>(InventoryComponent: inventory_component): void = external {}
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
  inventory_with_priority<native><public> := class {
    Inventory<native><public>: inventory_component

    Priority<native><public>: float
  }

  @experimental
  item_ability_binding<native><final><epic_internal> := class<concrete> {
    @editable
    var<private> Ability<native><public>: ?ability = external {}

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

  @experimental
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

  @experimental
  # item_category is used to classify items.
  item_category<native><public> := class<castable><concrete><unique><final> {}

  @experimental
  # Anything using this component should be considered an item. Required to interact with inventories.
  item_component<native><public> := class<final_super>(component) {
    # Succeeds if this item can be merged into the target item. Merging an entity with itself will always fail.
    CanMergeInto<final><native_callable><public>(TargetItem: entity)<reads><decides>: void = external {}

    CanMergeIntoInternal<final><native><epic_internal>(TargetItem: entity)<reads>: tuple(logic, logic)

    @editable
    # Categories which this item can belong to. Note that some projects may only use the first entry.
    Categories<native><public>: []item_category = external {}

    CloneItem<final><native><epic_internal>()<transacts>: entity

    # Removes the item from its inventory and places it in the simulation world. Works on orphaned items i.e. outside the world or any inventory. Fails if the item is already a pickup.
    Drop<native><public>()<transacts><decides>: void

    EquippedChangedEvent<native><final><public>: listenable(item_equipped_change) = external {}

    # Returns the inventory_component this item currently resides in. Fails if it cannot find a valid parent inventory.
    GetParentInventory<native><final><public>()<reads><decides>: inventory_component

    InventoryChangeEvent<native><final><public>: listenable(item_inventory_change) = external {}

    # Succeeds if this item is considered currently within an inventory and equipped.
    IsItemEquipped<native><final><public>()<reads><decides>: void

    MaxStackSizeChangedEvent<native><final><public>: listenable(item_max_stack_size_change) = external {}

    # Attempts to merge this item into the specified item. Fails if items cannot be merged or no items are moved.
    #  If TargetAmount is specified, only that amount will try to be merged into this item.
    MergeInto<final><native_callable><public>(
      TargetItem: entity,
      ?TargetAmount: ?int = external {}
    )<transacts><decides>: void = external {}

    MergeIntoInternal<final><native><epic_internal>(TargetItem: entity, TargetAmount: int)<transacts><decides>: int

    @available { MinUploadedAtFNVersion := 3200 }
    # List of item_component classes we can be merged with.
    MergeableItemComponentClasses<native><public>: []castable_subtype(item_component) = external {}

    OnInitializedInternal<native><override>(): void

    # Fails if this item is already in an inventory, or the inventory cannot accept the item.
    PickUp<native><public>(Inventory: inventory_component)<transacts><decides>: void

    # Sets the maximum stack size for this item. If ClampStackSize is true, StackSize will be clamped to NewMaxStackSize.
    SetMaxStackSize<final><native><public>(NewMaxStackSize: int, ?ClampStackSize: logic = external {})<transacts>: void

    # Sets the stack size of this item.
    SetStackSize<final><native><public>(NewStackSize: int)<transacts>: void

    StackSizeChangedEvent<native><final><public>: listenable(item_stack_size_change) = external {}

    # Takes the specified amount of this item's stack, reducing this item's stack size in the process.
    #  If amount is greater than the amount in the stack, the stack amount will be used instead.
    #  Returns a clone of the item with a stack size equial to the amount it was able to take from the item.
    Take<final><native><public>(Amount: int)<transacts><decides>: entity

    @replicated("")
    var<private> ItemDefinition<native><epic_internal>: ?item_definition_base = external {}

    # Maximum stack size for this item.
    var<protected> MaxStackSize<native><public>: ?int = external {}

    # Current stack size of this item.
    var<protected> StackSize<native><public>: int = external {}
  }

  @experimental
  @import_as("/Script/ItemizationCoreRuntime.UItemDefinitionBase")
  item_definition_base<native><epic_internal> := class<epic_internal> {}

  @experimental
  # Component that holds the details of an item.
  item_details_component<native><public> := class<final_super>(component, has_description) {}

  @experimental
  item_equipped_change<native><public> := class<epic_internal> {
    IsItemEquipped<native><public>: logic

    ItemComponent<native><public>: item_component
  }

  @experimental
  # Component that holds the icon for an item.
  item_icon_component<native><public> := class<final_super>(component, has_icon) {}

  @experimental
  item_inventory_change<native><public> := class<epic_internal> {
    CurrentInventory<native><public>: ?inventory_component

    ItemComponent<native><public>: item_component

    PreviousInventory<native><public>: ?inventory_component
  }

  @experimental
  item_limit_inventory_rule<native><epic_internal> := class(inventory_rule_interface) {
    CanAddItem<override>(
      InventoryComponent: inventory_component,
      Item: entity,
      ?AllowMergeItems: logic = external {},
      ?AllowPartialItemMove: logic = external {}
    ): ?failure_reason = external {}

    @editable
    ItemLimit<native><public>: int = external {}
  }

  @experimental
  item_max_stack_size_change<native><public> := class<epic_internal> {
    CurrentMaxStackSize<native><public>: ?int

    ItemComponent<native><public>: item_component

    PreviousMaxStackSize<native><public>: ?int
  }

  @experimental
  item_mesh_attachment_definition<native><epic_internal> := class<concrete>(item_attachment_definition) {
    @editable
    EntityToAttach<native><public>: ?subtype(entity) = external {}

    @editable
    var AttachToSocketName<native><public>: string = external {}
  }

  @experimental
  # Item component setting owner pose data for this item.
  item_owner_pose_modifier_component<native><final><epic_internal> := class<final_super>(component) {
    @editable
    EquippedPose<native><public>: ?pose_modifier = external {}

    @editable
    NotEquippedPose<native><public>: ?pose_modifier = external {}
  }

  @experimental
  item_rarity<native><epic_internal> := class<unique><concrete> {
    @editable
    RarityColor<native><public>: color = external {}

    @editable
    RarityDescription<native><public>: string = external {}

    @editable
    RarityName<native><public>: string = external {}

    @editable
    RarityTier<native><public>: float = external {}
  }

  @experimental
  item_rarity_component<native><final><epic_internal> := class<final_super>(component) {
    @editable
    var<private> Rarity<native><public>: ?item_rarity
  }

  @experimental
  item_slot_change<native><epic_internal> := struct<epic_internal> {
    CurrentSlot<native><public>: int

    Item<native><public>: entity

    PreviousSlot<native><public>: int
  }

  @experimental
  item_stack_size_change<native><public> := class<epic_internal> {
    CurrentStackSize<native><public>: int

    ItemComponent<native><public>: item_component

    PreviousStackSize<native><public>: int
  }

  @experimental
  item_type<native><epic_internal> := class<concrete><unique> {
    @editable
    ItemTypeDescription<native><public>: message = external {}

    @editable
    ItemTypeName<native><public>: message = external {}

    @editable
    ParentType<native><public>: ?item_type = external {}
  }

  @experimental
  item_type_component<native><final><epic_internal> := class<final_super>(component) {
    GetItemTypeTags<native><epic_internal>(): tag_container

    @editable
    ItemTypeSource<native><epic_internal>: ?item_type_source = external {}

    @editable
    var<private> ItemType<native><public>: item_type
  }

  @experimental
  item_type_source<native><epic_internal> := class<abstract> {
    GetItemType<native><native_callable><epic_internal>(Default: item_type): item_type
  }

  @experimental
  itemization_core_debug_library<native><epic_internal> := class {
    AddTestItem<native_callable><public>(InInventory: inventory_component): void = external {}

    # Adds an item which is also an inventory (let's call it a bag). There is an object inside the bag.
    AddTestItemWithInventory<native_callable><public>(InInventory: inventory_component): void = external {}

    # Adds a mergeable item which can be stacked to the inventory.
    AddTestStackableItem<native_callable><public>(InInventory: inventory_component): void = external {}

    RemoveAllItems<native_callable><public>(InInventory: inventory_component): void = external {}
  }

  @experimental
  itemization_debug_item_component_mergeable<epic_internal> := class(item_component) {
    @available { MinUploadedAtFNVersion := 3200 }
    MergeableItemComponentClasses<override>: []castable_subtype(item_component) = external {}
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

  @experimental
  @import_as("/Script/ItemizationCoreRuntime.UItemOwnerPoseAsset")
  # Owner poses let an item affect their owner's default animation stance.
  #  For example, to make a character hold an item like a torch, or a 2-handed weapon.
  pose_modifier<native><epic_internal> := class<concrete><unique>(asset) {}

  @experimental
  remove_inventory_result<native><epic_internal> := class<epic_internal> {
    Inventory<native><public>: inventory_component

    ParentInventory<native><public>: inventory_component
  }

  @experimental
  remove_items_result<native><public> := class<epic_internal> {
    Inventory<native><public>: inventory_component

    RemovedItems<native><public>: []entity
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

using { /UnrealEngine.com/Temporary/UI }
# Module import path: /UnrealEngine.com/SceneGraph
(/UnrealEngine.com:)SceneGraph<public> := module {
  # Module import path: /UnrealEngine.com/SceneGraph/UI
  (/UnrealEngine.com/SceneGraph:)UI<public> := module {
    @experimental
    umg_frame_component<native><epic_internal> := class<abstract>(frame_component) {
      Asset<native><epic_internal>: umg_widget_class_asset

      GetNamedSlotOptional_<native><epic_internal>(NamedSlotName: []char)<transacts>: ?widget

      GetNamedSlot_<native><epic_internal>(NamedSlotName: []char)<transacts>: widget

      GetViewmodelOptional_<native><epic_internal>(viewmodel_type: type, ViewmodelName: []char)<transacts>: viewmodel_type

      GetViewmodel_<native><epic_internal>(viewmodel_type: type, ViewmodelName: []char)<transacts>: viewmodel_type

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
    }
  }
}

Temporary<public> := module {
  using { /UnrealEngine.com/Temporary/Diagnostics }
  using { /Verse.org/SpatialMath }
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

      # Draws a 3D text at the named location, and using the provided draw parameters.
      DrawText<epic_internal>(
        Text: string,
        Position: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        ?Color: color = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {},
        ?FontScale: float = external {},
        ?DrawShadow: logic = external {}
      )<transacts>: void = external {}

      # Draws a 3D text at the named location, and using the provided draw parameters.
      DrawText<native><epic_internal>(
        Text: string,
        Position: (/Verse.org/SpatialMath:)vector3,
        ?Color: color = external {},
        ?DrawDurationPolicy: debug_draw_duration_policy = external {},
        ?Duration: float = external {},
        ?FontScale: float = external {},
        ?DrawShadow: logic = external {}
      )<transacts>: void

      # Hide Debug Draw for the channel for all users.
      HideChannel<native><public>()<transacts>: void

      # Show Debug Draw for the channel for all users.
      ShowChannel<native><public>()<transacts>: void
    }

    # debug_draw_channel is the base class used to define debug draw channels.
    debug_draw_channel<native><public> := class<abstract> {}

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

      # Sets the default log level of the displayed message. See log_level enum for more info on log levels. Defaults to log_level.Normal.
      DefaultLevel<native><public>: log_level = external {}

      # Print message using the given log level
      (/UnrealEngine.com/Temporary/Diagnostics/log:)Print<epic_internal>(Message: message, ?Level: log_level = external {})<reads>: void = external {}

      # Print diagnostic using the given log level
      (/UnrealEngine.com/Temporary/Diagnostics/log:)Print<public>(Message: diagnostic, ?Level: log_level = external {})<computes>: void = external {}

      # Print message using the given log level
      (/UnrealEngine.com/Temporary/Diagnostics/log:)Print<public>(Message: string, ?Level: log_level = external {})<computes>: void = external {}

      # Prints the current script call stack using the given log level
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

  using { /Verse.org/Native }
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

    # Makes a `vector3` from the axis of `rotation`.
    # If `rotation` is nearly identity, this will return the +X axis. See also `GetAngle`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).(/UnrealEngine.com/Temporary/SpatialMath:)GetAxis<native><public>()<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3

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

    # Makes a `vector3` by applying `Rotation` to `Vector`.
    (Rotation: (/UnrealEngine.com/Temporary/SpatialMath:)rotation).RotateVector<native><public>(Vector: (/UnrealEngine.com/Temporary/SpatialMath:)vector3)<reads>: (/UnrealEngine.com/Temporary/SpatialMath:)vector3

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

    # Makes a `rotation` from `Axis` and `AngleRadians` using a left-handed sign convention (e.g. a positive rotation around +Z takes +X to +Y). If `Axis.IsAlmostZero[]`, make the identity rotation.
    MakeRotation<native><public>(
      Axis: (/UnrealEngine.com/Temporary/SpatialMath:)vector3,
      AngleRadians: float
    )<reads><converges>: (/UnrealEngine.com/Temporary/SpatialMath:)rotation

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

    @editable
    @import_as("/Script/EpicGamesTemporary.FVerseRotation_Deprecated")
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

      # Report a test result of `Failed`. `Category` and `SubCategory` are used to calculate test result stats as part of printing the summary.
      ReportTestFailed<native><epic_internal>(
        Message: string,
        ?Category: string = external {},
        ?SubCategory: string = external {}
      ): void

      # Report a test result of `Passed`. `Category` and `SubCategory` are used to calculate test result stats as part of printing the summary.
      ReportTestPassed<native><epic_internal>(
        Message: string,
        ?Category: string = external {},
        ?SubCategory: string = external {}
      ): void

      # Report a test result of `Result`. `Category` and `SubCategory` are used to calculate test result stats as part of printing the summary.
      ReportTestResult<native><epic_internal>(
        Message: string,
        Result: test_result,
        ?Category: string = external {},
        ?SubCategory: string = external {}
      ): void

      # Report a test result of `Skipped`. `Category` and `SubCategory` are used to calculate test result stats as part of printing the summary.
      ReportTestSkipped<native><epic_internal>(
        Message: string,
        ?Category: string = external {},
        ?SubCategory: string = external {}
      ): void

      # Resets test results.
      Reset<native><epic_internal>(): void
    }

    # test result outcomes
    test_result<native><epic_internal> := enum {
      Failed

      Passed

      Skipped
    }
  }

  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /Verse.org/Assets }
  using { /Verse.org/Colors }
  using { /Verse.org/SceneGraph }
  using { /Verse.org/Simulation }
  # Module import path: /UnrealEngine.com/Temporary/UI
  UI<public> := module {
    # Returns the `player_ui` associated with `Player`.
    # Fails if there is no `player_ui` associated with `Player`.
    GetPlayerUI<native><public>(Player: player)<transacts><decides>: player_ui

    # Make a canvas slot for fixed position widget.
    # If Size is set, then the Offsets is calculated and the SizeToContent is set to false.
    # If Size is not set, then Right and Bottom are set to zero and are not used. The widget size will be automatically calculated. The SizeToContent is set to true.
    # The widget is not anchored and will not move if the parent is resized.
    # The Anchors is set to zero.
    MakeCanvasSlot<native><public>(Widget: widget, Position: vector2, ?Size: vector2 = external {}, ?ZOrder: type { _X: int where 0 <= _X, _X <= 2147483647 } = external {}, ?Alignment: vector2 = external {})<computes>: canvas_slot

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
      # Subscribable event that fires when the button is clicked.
      OnClick<public>(): listenable(widget_message) = external {}

      # Sets the child widget slot.
      SetWidget<native><public>(InSlot: button_slot): void

      # The child widget of the button. Used only during initialization of the widget and not modified by SetSlot.
      Slot<native><public>: button_slot
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

      # Sets the user's focus on this widget. The target widget must be focusable, otherwise this has no effect.
      SetFocus<native><epic_internal>(Widget: widget): void
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
    using { /UnrealEngine.com/Temporary/SpatialMath }
    using { /Verse.org/Assets }
    # Module import path: /UnrealEngine.com/Temporary/WorldPartition/VerseWorldPartition
    VerseWorldPartition<public> := module {
      GetWorldPartitionHelper<native><epic_internal>()<transacts>: ?world_partition_helper

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
      PrintEpicAPIFunctionLog<native><public>(): void

      # Takes a screenshot on clients that are connected to the server this is called onPasses in the file name of the screenshot that gets saved to a fixed directory
      ScreenshotAllClients<native><epic_internal>(ScreenshotFileName: string): void
    }
  }
}

VerseTypeEditor<public> := module {
  using { /Verse.org/Assets }
  verse_type_editor_asset<native><epic_internal> := class(asset) {}
}

WebAPI<public> := module {
  MakeClient<constructor><native><public>(ClientId: client_id)<converges>: client

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