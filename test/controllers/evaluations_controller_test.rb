require "test_helper"

class EvaluationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @evaluation = evaluations(:one)
  end

  test "should get index" do
    get evaluations_url
    assert_response :success
  end

  test "should get new" do
    get new_evaluation_url
    assert_response :success
  end

  test "should create evaluation" do
    assert_difference("Evaluation.count") do
      post evaluations_url, params: { evaluation: { accuracy: @evaluation.accuracy, accuracy_description: @evaluation.accuracy_description, bias: @evaluation.bias, bias_description: @evaluation.bias_description, comments: @evaluation.comments, relevance: @evaluation.relevance, relevance_description: @evaluation.relevance_description, task_id: @evaluation.task_id } }
    end

    assert_redirected_to evaluation_url(Evaluation.last)
  end

  test "should show evaluation" do
    get evaluation_url(@evaluation)
    assert_response :success
  end

  test "should get edit" do
    get edit_evaluation_url(@evaluation)
    assert_response :success
  end

  test "should update evaluation" do
    patch evaluation_url(@evaluation), params: { evaluation: { accuracy: @evaluation.accuracy, accuracy_description: @evaluation.accuracy_description, bias: @evaluation.bias, bias_description: @evaluation.bias_description, comments: @evaluation.comments, relevance: @evaluation.relevance, relevance_description: @evaluation.relevance_description, task_id: @evaluation.task_id } }
    assert_redirected_to evaluation_url(@evaluation)
  end

  test "should destroy evaluation" do
    assert_difference("Evaluation.count", -1) do
      delete evaluation_url(@evaluation)
    end

    assert_redirected_to evaluations_url
  end
end
