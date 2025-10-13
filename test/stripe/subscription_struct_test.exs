defmodule Stripe.SubscriptionStructTest do
  use ExUnit.Case, async: true

  @moduledoc """
  Tests for the Subscription struct to ensure patched fields are present.
  These fields exist in Stripe's actual API but are missing from their OpenAPI spec.
  See: https://docs.stripe.com/api/subscriptions/object
  """

  describe "Subscription struct" do
    test "includes current_period_start field" do
      struct_fields = Stripe.Subscription.__struct__() |> Map.keys()
      
      assert :current_period_start in struct_fields,
        "Subscription struct should include :current_period_start field"
    end

    test "includes current_period_end field" do
      struct_fields = Stripe.Subscription.__struct__() |> Map.keys()
      
      assert :current_period_end in struct_fields,
        "Subscription struct should include :current_period_end field"
    end

    test "can create struct with current_period fields without KeyError" do
      # This test verifies the fix for the original issue:
      # ** (KeyError) key :current_period_end not found
      now = System.system_time(:second)
      
      subscription = %Stripe.Subscription{
        id: "sub_test",
        object: "subscription",
        current_period_start: now,
        current_period_end: now + 2_592_000  # 30 days later
      }
      
      assert subscription.current_period_start == now
      assert subscription.current_period_end == now + 2_592_000
      assert subscription.id == "sub_test"
    end

    test "can pattern match on current_period fields" do
      now = System.system_time(:second)
      
      subscription = %Stripe.Subscription{
        id: "sub_test",
        current_period_start: now,
        current_period_end: now + 2_592_000
      }
      
      # Pattern matching should work
      assert %Stripe.Subscription{
        current_period_start: ^now,
        current_period_end: period_end
      } = subscription
      
      assert period_end == now + 2_592_000
    end
  end
end

