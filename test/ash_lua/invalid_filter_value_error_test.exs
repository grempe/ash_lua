# SPDX-FileCopyrightText: 2026 ash_lua contributors <https://github.com/ash-project/ash_lua/graphs/contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshLua.InvalidFilterValueErrorTest do
  use ExUnit.Case, async: true

  test "the value is reported when it is known" do
    error = Ash.Error.Query.InvalidFilterValue.exception(value: "x", message: "no")

    assert %{code: "invalid_filter_value", vars: %{value: ~s("x"), detail: "no"}} =
             AshLua.Error.to_error(error)
  end

  test "the value is left out when it is not known" do
    error = Ash.Error.Query.InvalidFilterValue.exception(no_value?: true, message: "does not fit")
    assert %{code: "invalid_filter_value", vars: vars} = AshLua.Error.to_error(error)
    refute Map.has_key?(vars, :value)
    assert vars.detail == "does not fit"
  end
end
